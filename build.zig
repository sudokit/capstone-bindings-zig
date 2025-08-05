const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const capstone = b.dependency("capstone", .{
        .target = target,
        .optimize = optimize,
    });
    const compiled_capstone = capstone.artifact("capstone");

    compiled_capstone.getEmittedIncludeTree().addStepDependencies(&compiled_capstone.step);
    const capstone_c = b.addTranslateC(.{
        .root_source_file = compiled_capstone.getEmittedIncludeTree().path(b, "capstone/capstone.h"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    const capstone_c_mod = capstone_c.createModule();

    const mod = b.addModule("capstone-bindings-zig", .{
        .root_source_file = b.path("capstone.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{
                .name = "capstone-c",
                .module = capstone_c_mod,
            },
        },
    });
    mod.addLibraryPath(compiled_capstone.getEmittedBin().dirname());
    mod.linkLibrary(capstone.artifact("capstone"));
    mod.addIncludePath(compiled_capstone.getEmittedIncludeTree());

    const mod_test = b.addTest(.{
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/tests.zig"),
        }),
    });
    mod_test.step.dependOn(&compiled_capstone.step);

    mod_test.root_module.addImport("capstone-c", capstone_c_mod);
    mod_test.addLibraryPath(compiled_capstone.getEmittedBin().dirname());
    mod_test.linkLibrary(capstone.artifact("capstone"));
    mod_test.addIncludePath(compiled_capstone.getEmittedIncludeTree());

    const run_lib_tests = b.addRunArtifact(mod_test);
    const test_step = b.step("test", "Run the library tests");
    test_step.dependOn(&run_lib_tests.step);
}
