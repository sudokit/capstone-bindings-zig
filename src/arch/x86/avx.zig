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
    EQ_UQ,
    NGE,
    NGT,
    FALSE,
    NEQ_OQ,
    GE,
    GT,
    TRUE,
    EQ_OS,
    LT_OQ,
    LE_OQ,
    UNORD_S,
    NEQ_US,
    NLT_UQ,
    NLE_UQ,
    ORD_S,
    EQ_US,
    NGE_UQ,
    NGT_UQ,
    FALSE_OS,
    NEQ_OS,
    GE_OQ,
    GT_OQ,
    TRUE_US,
};

pub const Rm = enum(c_int) {
    INVALID = 0,
    RN,
    RD,
    RU,
    RZ,
};

pub const Bcast = enum(c_int) {
    INVALID = 0,
    @"2",
    @"4",
    @"8",
    @"16",
};
