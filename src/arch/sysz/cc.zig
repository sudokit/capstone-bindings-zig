const cs = @import("capstone-c");

pub const Cc = enum(c_int) {
    INVALID,
    O,
    H,
    NLE,
    L,
    NHE,
    LH,
    NE,
    E,
    NLH,
    HE,
    NL,
    LE,
    NH,
    NO,
};
