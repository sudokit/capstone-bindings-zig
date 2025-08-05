const cs = @import("capstone-c");

pub const CpuSize = enum(c_int) {
    NONE,
    BYTE,
    WORD,
    LONG = 4,
};

pub const FpuSize = enum(c_int) {
    NONE,
    SINGLE = 4,
    DOUBLE = 8,
    EXTENDED = 12,
};

pub const UnitSize = extern union {
    cpu_size: CpuSize,
    fpu_size: FpuSize,
};

pub const SizeType = enum(c_int) {
    INVALID,
    CPU,
    FPU,
};

pub const OpSize = extern struct {
    type: SizeType,
    unit_size: UnitSize,
};
