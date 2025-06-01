pub const Barrier = @import("barrier.zig").Barrier;
pub const Cc = @import("cc.zig").Cc;
pub const Extender = @import("extender.zig").Extender;
pub const OpType = @import("op_type.zig").OpType;
pub const Prefetch = @import("prefetch.zig").Prefetch;
pub const Pstate = @import("pstate.zig").Pstate;
pub const Register = @import("register.zig").Register;
pub const Shift = @import("shift.zig").Shift;
pub const Svcr = @import("svcr.zig").Svcr;
pub const SysOp = @import("sys_op.zig").SysOp;
pub const Vas = @import("vas.zig").Vas;
pub const Sme = @import("sme.zig").Sme;
pub const Shifter = @import("shifter.zig").Shifter;
const instruction = @import("instruction.zig");
pub const OpMem = instruction.OpMem;
pub const Instruction = instruction.Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    cc: Cc,
    update_flags: bool,
    writeback: bool,
    post_index: bool,
    op_count: u8,
    operands: [8]Operand,
};
