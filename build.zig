const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = std.zig.CrossTarget{
        .cpu_arch = .riscv64,
        .os_tag = .freestanding,
        .abi = .none,
    };

    const kernel = b.addExecutable("kernel", "src/main.zig");
    kernel.setLinkerScriptPath(.{ .path = "src/linker/kernel.lds" });
    kernel.addAssemblyFile("src/asm/boot.s");
    kernel.addAssemblyFile("src/asm/trap.s");

    const qemu_args = &[_][]const u8{
        "qemu-system-riscv64", "-d",                 "guest_errors,unimp",
        "-kernel",             "zig-out/bin/kernel", "-machine",
        "virt",                "-bios",              "none",
        "-cpu",                "rv64",               "-m",
        "128M",                "-smp",               "4",
    };

    const qemu_cmd = b.addSystemCommand(qemu_args);
    if (b.args) |args| for (args) |arg| qemu_cmd.addArg(arg);
    const qemu_step = b.step("run", "run the kernel inside qemu");
    qemu_step.dependOn(b.getInstallStep());
    qemu_step.dependOn(&qemu_cmd.step);

    kernel.setTarget(target);
    kernel.setBuildMode(mode);
    kernel.code_model = .medium;
    kernel.install();
}
