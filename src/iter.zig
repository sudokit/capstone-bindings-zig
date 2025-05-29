const cs = @import("capstone-c");

const Insn = @import("insn.zig").Insn;
const Handle = cs.csh;

/// The Iterator for traversing the disassembler
pub const Iter = struct {
    handle: Handle,
    code: []const u8,
    original_code: []const u8,
    original_address: u64,
    address: u64,
    insn: [*]Insn,

    pub fn init(handle: Handle, code: []const u8, address: u64, insn: [*]Insn) Iter {
        return Iter{
            .handle = handle,
            .code = code,
            .original_code = code,
            .original_address = address,
            .address = address,
            .insn = insn,
        };
    }

    // Consumes the iterator and goes to the next
    pub fn next(self: *Iter) ?*Insn {
        if (cs.cs_disasm_iter(self.handle, @ptrCast(&self.code.ptr), @ptrCast(&self.code.len), &self.address, @ptrCast(self.insn))) {
            const ret = &self.insn[0];
            ret.normalizeStrings();
            return ret;
        } else {
            return null;
        }
    }

    pub fn reset(self: *Iter) void {
        self.address = self.original_address;
        self.code = self.original_code;
    }
};

/// The Iterator for traversing the disassembler, but **allocates** space using capstone malloc.
pub const IterManaged = struct {
    inner: Iter,
    insn: [*]Insn,

    pub fn init(handle: Handle, code: []const u8, address: u64) IterManaged {
        const insn: [*]Insn = @ptrCast(cs.cs_malloc(handle));
        return .{
            .inner = Iter.init(handle, code, address, insn),
            .insn = insn,
        };
    }

    // Consumes the iterator and goes to the next
    pub fn next(self: *IterManaged) ?*Insn {
        return self.inner.next();
    }

    pub fn reset(self: *IterManaged) void {
        self.inner.reset();
    }

    // Clean up the iter
    pub fn deinit(self: IterManaged) void {
        cs.cs_free(@ptrCast(self.insn), 1);
    }
};
