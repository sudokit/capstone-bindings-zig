const cs = @import("capstone-c");

pub const Cc = enum(c_int) {
    INVALID = 0,
    EQ,
    LT,
    LE,
    UNORD,
    NEQ,
    NLT,
    NLE,
    ORD,
};
