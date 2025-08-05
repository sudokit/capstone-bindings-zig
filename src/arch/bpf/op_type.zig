const cs = @import("capstone-c");

pub const OpType = enum(c_int) {
    INVALID,
    REG,
    IMM,
    OFF,
    MEM,
    MMEM,
    MSH,
    EXT,
};
