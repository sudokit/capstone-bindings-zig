pub const DspCc = @import("dsp_cc.zig").DspCc;
pub const DspInsn = @import("dsp_insn.zig").DspInsn;
pub const DspOperand = @import("dsp_operand.zig").DspOperand;
pub const Insn = @import("insn.zig").Insn;
pub const MemType = @import("mem_type.zig").MemType;
pub const OpMem = @import("op_mem.zig").OpMem;
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const OpDsp = @import("op_dsp.zig").OpDsp;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    insn: Insn,
    size: u8,
    op_count: u8,
    operands: [3]Operand,
};
