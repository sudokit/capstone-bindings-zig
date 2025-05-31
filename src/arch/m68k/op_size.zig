const cs = @import("capstone-c");

pub const CpuSize = enum(cs.m68k_cpu_size) {
    NONE,
    BYTE,
    WORD,
    LONG = 4,
};

pub const FpuSize = enum(cs.m68k_fpu_size) {
    NONE,
    SINGLE = 4,
    DOUBLE = 8,
    EXTENDED = 12,
};

pub const UnitSize = extern union {
    cpu_size: CpuSize,
    fpu_size: FpuSize,
};

pub const SizeType = enum(cs.m68k_size_type) {
    INVALID,
    CPU,
    FPU,
};

pub const OpSize = extern struct {
    type: SizeType,
    unit_size: UnitSize,
};
