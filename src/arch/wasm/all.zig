pub const BrTable = @import("brtable.zig").BrTable;
pub const OpType = @import("op_type.zig").OpType;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    op_count: u8,
    operands: [2]Operand,
};
