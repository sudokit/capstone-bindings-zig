pub const AddressMode = @import("address_mode.zig").AddressMode;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    am: AddressMode,
    modifies_flags: bool,
    op_count: u8,
    operands: [3]Operand,
};
