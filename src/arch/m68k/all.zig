pub const AddressMode = @import("address_mode.zig").AddressMode;
pub const OpMem = @import("op_mem.zig").OpMem;
const opsize = @import("op_size.zig");
pub const CpuSize = opsize.CpuSize;
pub const FpuSize = opsize.FpuSize;
pub const UnitSize = opsize.UnitSize;
pub const SizeType = opsize.SizeType;
pub const OpSize = opsize.OpSize;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    operands: [4]Operand,
    op_size: OpSize,
    op_count: u8,
};
