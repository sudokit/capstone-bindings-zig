pub const Bc = @import("bc.zig").Bc;
pub const Bh = @import("bh.zig").Bh;
pub const OpMem = @import("op_mem.zig").OpMem;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const OpCrx = @import("op_crx.zig").OpCrx;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    bc: Bc,
    bh: Bh,
    update_cr0: bool,
    op_count: u8,
    operands: [8]Operand,
};
