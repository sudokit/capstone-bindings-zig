const cs = @import("capstone-c");

pub const OpType = enum(c_int) {
    INVALID,
    NONE,
    INT7,
    VARUINT32,
    VARUINT64,
    UINT32,
    UINT64,
    IMM,
    BRTABLE,
};
