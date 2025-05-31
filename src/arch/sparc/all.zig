pub const Cc = @import("cc.zig").Cc;
pub const OpMem = @import("op_mem.zig").OpMem;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Hint = @import("hint.zig").Hint;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    cc: Cc,
    hint: Hint,
    op_count: u8,
    operands: [4]Operand,
};
