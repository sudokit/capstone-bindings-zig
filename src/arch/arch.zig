pub const x86 = @import("x86/all.zig");
pub const arm64 = @import("arm64/all.zig");
pub const arm = @import("arm/all.zig");
pub const m68k = @import("m68k/all.zig");
pub const mips = @import("mips/all.zig");
pub const ppc = @import("ppc/all.zig");
pub const sparc = @import("sparc/all.zig");
pub const sysz = @import("sysz/all.zig");
pub const xcore = @import("xcore/all.zig");
pub const tms320c64x = @import("tms320c64x/all.zig");
pub const m680x = @import("m680x/all.zig");
pub const evm = @import("evm/all.zig");
pub const mos65xx = @import("mos65xx/all.zig");
pub const wasm = @import("wasm/all.zig");
pub const bpf = @import("bpf/all.zig");
pub const riscv = @import("riscv/all.zig");
pub const sh = @import("sh/all.zig");
pub const tricore = @import("tricore/all.zig");

pub const Arch = extern union {
    x86: x86.Arch,
    arm64: arm64.Arch,
    arm: arm.Arch,
    m68k: m68k.Arch,
    mips: mips.Arch,
    ppc: ppc.Arch,
    sparc: sparc.Arch,
    sysz: sysz.Arch,
    xcore: xcore.Arch,
    tms320c64x: tms320c64x.Arch,
    m680x: m680x.Arch,
    evm: evm.Arch,
    mos65xx: mos65xx.Arch,
    wasm: wasm.Arch,
    bpf: bpf.Arch,
    riscv: riscv.Arch,
    sh: sh.Arch,
    tricore: tricore.Arch,
};
