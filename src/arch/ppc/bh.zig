const cs = @import("capstone-c");

pub const Bh = enum(c_int) {
    INVALID,
    PLUS,
    MINUS,
};
