const cs = @import("capstone-c");

pub const Setend = enum(c_int) {
    INVALID,
    BE,
    LE,
};
