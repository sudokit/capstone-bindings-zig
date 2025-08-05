const cs = @import("capstone-c");

pub const OpType = enum(c_int) {
    INVALID,
    REG,
    IMM,
    MEM,
    FP_SINGLE,
    FP_DOUBLE,
    REG_BITS,
    REG_PAIR,
    BR_DISP,
};
