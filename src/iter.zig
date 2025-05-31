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
    insn: *Insn,

    // Consumes the iterator and goes to the next
    pub fn next(self: *Iter) ?*const Insn {
        if (cs.cs_disasm_iter(self.handle, @ptrCast(&self.code.ptr), @ptrCast(&self.code.len), &self.address, @ptrCast(self.insn))) {
            self.insn.normalizeStrings();
            return self.insn;
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
    insn: *Insn,

    pub fn init(handle: Handle, code: []const u8, address: u64) !IterManaged {
        const insn_ptr: ?*Insn = @ptrCast(cs.cs_malloc(handle));
        const insn = if (insn_ptr) |i| i else return error.OutOfMemory;
        return .{
            .inner = Iter{
                .handle = handle,
                .code = code,
                .original_code = code,
                .original_address = address,
                .address = address,
                .insn = insn,
            },
            .insn = insn,
        };
    }

    // Consumes the iterator and goes to the next
    pub fn next(self: *IterManaged) ?*const Insn {
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
