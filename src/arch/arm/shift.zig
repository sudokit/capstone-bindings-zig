const cs = @import("capstone-c");

pub const Shift = enum(c_int) {
    INVALID,
    ASR,
    LSL,
    LSR,
    ROR,
    RRX,
    ASR_REG,
    LSL_REG,
    LSR_REG,
    ROR_REG,
    RRX_REG,
};
