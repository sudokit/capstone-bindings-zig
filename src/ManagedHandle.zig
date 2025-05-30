const builtin = @import("builtin");
const std = @import("std");

const cs = @import("capstone-c");

const err = @import("error.zig");
const insn = @import("insn.zig");
const setup = @import("setup.zig");
const enums = @import("enums.zig");
const impl = @import("impl.zig");

const iter = @import("iter.zig");

const Iter = iter.Iter;
const IterManaged = iter.IterManaged;

native: impl.Handle,

// To avoid heap allocations...
const TmpStorage = blk: {
    if (builtin.single_threaded) {
        break :blk struct {
            var detail: insn.Detail = std.mem.zeroes(insn.Detail);
            var ins: insn.Insn = std.mem.zeroes(insn.Insn);
            fn getIns() *insn.Insn {
                ins.detail = &detail;
                return &ins;
            }
        };
    } else {
        break :blk struct {
            threadlocal var detail: insn.Detail = std.mem.zeroes(insn.Detail);
            threadlocal var ins: insn.Insn = std.mem.zeroes(insn.Insn);
            fn getIns() *insn.Insn {
                ins.detail = &detail;
                return &ins;
            }
        };
    }
};

const Self = @This();

pub const Options = struct {
    /// Assembly output syntax
    syntax: enums.Syntax = .DEFAULT,
    /// Break down instruction structure into details
    detail: bool = false,
    /// Skip data when disassembling. Then engine is in SKIPDATA mode.
    skipdata: bool = false,
    /// Customize instruction mnemonic
    /// Must be valid till the handle is closed if set.
    mnemonic: []const MnemonicOption = &.{},
    /// print immediate operands in unsigned form
    unsigned: bool = false,
    /// ARM, prints branch immediates without offset.
    no_branch_offset: bool = false,

    /// cs_opt_mnem
    pub const MnemonicOption = extern struct {
        id: c_uint,
        mnemonic: [*:0]const u8,
    };
};

pub fn init(arch: enums.Arch, mode: enums.Mode, options: Options) !Self {
    const handle = try impl.open(arch, mode);

    if (options.syntax != .DEFAULT) {
        try impl.option(handle, .SYNTAX, @intFromEnum(options.syntax));
    }

    if (options.detail) {
        try impl.option(handle, .DETAIL, cs.CS_OPT_ON);
    }

    if (options.skipdata) {
        try impl.option(handle, .SKIPDATA, cs.CS_OPT_ON);
    }

    if (options.unsigned) {
        try impl.option(handle, .UNSIGNED, cs.CS_OPT_ON);
    }

    if (options.no_branch_offset) {
        try impl.option(handle, .NO_BRANCH_OFFSET, cs.CS_OPT_ON);
    }

    if (options.mnemonic.len > 0) {
        try impl.option(handle, .MNEMONIC, @intFromPtr(options.mnemonic.ptr));
    }

    return Self{ .native = handle };
}

/// Allocates using the cs_malloc function or the user defined one which is set through cs_option/setup.initCapstone(Manually).
/// Should be freed using cs_free, capstone provided free function or the user defined one if set through option.
pub fn disasm(self: Self, code: []const u8, address: usize, count: usize) err.CapstoneError![]insn.Insn {
    return impl.disasm(self.native, code, address, count);
}

/// Copies using zig user-land allocator and frees the cs_malloc'd memory.
pub fn disasmAlloc(self: Self, allocator: std.mem.Allocator, code: []const u8, address: usize, count: usize) ![]insn.Insn {
    const disass = try impl.disasm(self.native, code, address, count);
    defer impl.free(disass);
    return allocator.dupe(insn.Insn, disass);
}

/// Uses global/threadlocal storage to avoid heap allocations for the single Insn struct.
pub fn disasmIter(self: Self, code: []const u8, address: u64) Iter {
    return impl.disasmIter(self.native, code, address, @ptrCast(TmpStorage.getIns()));
}

pub fn deinit(self: *Self) void {
    impl.close(&self.native) catch |e| {
        std.io.getStdErr().writer().print("Failed to close handle: {any}\n", .{impl.strerror(e)}) catch {};
    };
}

test "with options" {
    const code = "\x75\x14";

    var handle = try init(.X86, .@"64", .{
        .syntax = .INTEL,
        .detail = true,
        .mnemonic = &.{.{ .id = cs.X86_INS_JNE, .mnemonic = "jnz" }},
    });
    defer handle.deinit();

    const disass = try handle.disasm(code, 0x1000, 0);
    defer impl.free(disass);

    try std.testing.expectEqual(1, disass.len);
    try std.testing.expect(disass[0].detail != null);
    try std.testing.expectEqualStrings("jnz", disass[0].mnemonic[0..3]);
}
