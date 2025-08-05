const cs = @import("capstone-c");

pub const OpType = enum(c_int) {
    INVALID,
    REG,
    IMM,
    MEM,
    FP,
    CIMM = 64,
    PIMM = 65,
    SETEND = 66,
    SYSREG = 67,
};
