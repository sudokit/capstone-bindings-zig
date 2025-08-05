const cs = @import("capstone-c");

pub const DspOperand = enum(c_int) {
    INVALID,
    REG_PRE,
    REG_IND,
    REG_POST,
    REG_INDEX,
    REG,
    IMM,
};
