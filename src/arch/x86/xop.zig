const cs = @import("capstone-c");

pub const Cc = enum(c_int) {
    INVALID = 0,
    LT,
    LE,
    GT,
    GE,
    EQ,
    NEQ,
    FALSE,
    TRUE,
};
