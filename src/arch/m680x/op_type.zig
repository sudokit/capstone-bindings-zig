const cs = @import("capstone-c");

pub const OpType = enum(c_int) {
    INVALID,
    REGISTER,
    IMMEDIATE,
    INDEXED,
    EXTENDED,
    DIRECT,
    RELATIVE,
    CONSTANT,
};
