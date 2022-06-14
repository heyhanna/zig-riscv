const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = std.zig.CrossTarget{
        .cpu_arch = .riscv64,
        .os_tag = .freestanding,
        .abi = .none,
    };

    const kernel = b.addExecutable("kernel", "src/main.zig");
    kernel.setLinkerScriptPath("src/kernel.lds");
    kernel.addAssemblyFile("src/asm/boot.s");
    kernel.addAssemblyFile("src/asm/trpa.s");

    kernel.setTarget(target);
    kernel.setBuildMode(mode);
    kernel.code_model = .medium;
    kernel.install();
}
