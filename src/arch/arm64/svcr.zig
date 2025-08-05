const cs = @import("capstone-c");

pub const Svcr = enum(c_int) {
    INVALID = 0,
    SVCRSM = 1,
    SVCRSMZA = 3,
    SVCRZA = 2,
};
