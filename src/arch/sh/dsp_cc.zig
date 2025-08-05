const cs = @import("capstone-c");

pub const DspCc = enum(c_int) {
    INVALID,
    NONE,
    DCT,
    DCF,
};
