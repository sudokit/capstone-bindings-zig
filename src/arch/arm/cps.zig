const cs = @import("capstone-c");

pub const Flag = enum(c_int) {
    INVALID,
    IE = 2,
    ID = 3,
};

pub const Mode = enum(c_int) {
    INVALID,
    F,
    I,
    A = 4,
    NONE = 16,
};
