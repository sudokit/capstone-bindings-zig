pub const Barrier = @import("barrier.zig").Barrier;
pub const Cc = @import("cc.zig").Cc;
pub const Cps = @import("cps.zig");
pub const OpType = @import("op_type.zig").OpType;
pub const Register = @import("register.zig").Register;
pub const Setend = @import("setend.zig").Setend;
pub const Shift = @import("shift.zig").Shift;
pub const VectorData = @import("vectordata.zig").VectorData;
pub const OpMem = @import("op_mem.zig").OpMem;
pub const Shifter = @import("shifter.zig").Shifter;
pub const Instruction = @import("instruction.zig").Instruction;
pub const Operand = @import("operand.zig").Operand;

pub const Arch = extern struct {
    usermode: bool,
    vector_size: c_uint,
    vector_data: VectorData,
    cps_mode: Cps.Mode,
    cps_flag: Cps.Flag,
    cc: Cc,
    update_flags: bool,
    writeback: bool,
    post_index: bool,
    mem_barrier: Barrier,
    op_count: u8,
    operands: [36]Operand,
};
