const cs = @import("capstone-c");

pub const AddressMode = enum(c_int) {
    INVALID,
    ACC,
    X,
    Y,
    P,
    SP,
    DP,
    B,
    K,
    ENDING,
};
