const cs = @import("capstone-c");

pub const Cc = enum(c_int) {
    INVALID,
    EQ,
    NE,
    HS,
    LO,
    MI,
    PL,
    VS,
    VC,
    HI,
    LS,
    GE,
    LT,
    GT,
    LE,
    AL,
};
