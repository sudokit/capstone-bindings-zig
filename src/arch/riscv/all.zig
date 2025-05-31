pub const OpMem = @import("op_mem.zig").OpMem;
pub const OpType = @import("op_type.zig").OpType;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    need_effective_addr: bool,
    op_count: u8,
    operands: [8]Operand,
};
