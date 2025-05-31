const cs = @import("capstone-c");
const insn = @import("insn.zig");

const Allocator = @import("std").mem.Allocator;
const Handle = cs.csh;

/// The Iterator for traversing the disassembler
pub const IterUnmanaged = struct {
    handle: Handle,
    code: []const u8,
    original_code: []const u8,
    original_address: u64,
    address: u64,
    ins: *insn.Insn,

    // Consumes the iterator and goes to the next
    pub fn next(self: *IterUnmanaged) ?*const insn.Insn {
        if (cs.cs_disasm_iter(self.handle, @ptrCast(&self.code.ptr), @ptrCast(&self.code.len), &self.address, @ptrCast(self.ins))) {
            self.ins.normalizeStrings();
            return self.ins;
        } else {
            return null;
        }
    }

    pub fn reset(self: *IterUnmanaged) void {
        self.address = self.original_address;
        self.code = self.original_code;
    }
};

/// The Iterator for traversing the disassembler, but **allocates** space using the provided `std.mem.Allocator`.
pub const IterManaged = struct {
    allocator: Allocator,
    unmanaged: IterUnmanaged,
    ins: *insn.Insn,

    pub fn init(allocator: Allocator, handle: Handle, code: []const u8, address: u64) !IterManaged {
        const ins = try allocator.create(insn.Insn);
        ins.detail = try allocator.create(insn.Detail);
        return .{
            .allocator = allocator,
            .unmanaged = IterUnmanaged{
                .handle = handle,
                .code = code,
                .original_code = code,
                .original_address = address,
                .address = address,
                .ins = ins,
            },
            .ins = ins,
        };
    }

    // Consumes the iterator and goes to the next
    pub fn next(self: *IterManaged) ?*const insn.Insn {
        return self.unmanaged.next();
    }

    pub fn reset(self: *IterManaged) void {
        self.unmanaged.reset();
    }

    // Clean up the iter
    pub fn deinit(self: IterManaged) void {
        self.allocator.destroy(self.ins.detail.?);
        self.allocator.destroy(self.ins);
    }
};
