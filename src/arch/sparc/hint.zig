const cs = @import("capstone-c");

pub const Hint = enum(c_int) {
    INVALID,
    A,
    PT,
    PN = 4,
};
