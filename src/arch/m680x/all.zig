pub const OpExt = @import("op_ext.zig").OpExt;
pub const OpRel = @import("op_rel.zig").OpRel;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const OpIdx = @import("op_idx.zig").OpIdx;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    flags: u8,
    op_count: u8,
    operands: [9]Operand,
};
