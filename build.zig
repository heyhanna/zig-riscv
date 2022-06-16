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

    // zig fmt: off
    const qemu_args = &[_][]const u8{
        "qemu-system-riscv64",
        "-d", "guest_errors,unimp",
        "-kernel", "zig-out/bin/kernel",
        "-machine", "virt",
        "-bios", "none",
        "-cpu", "rv64",
        "-m", "128M",
        "-smp", "4",
    // zig fmt: on
    };

    const run_cmd = b.addSystemCommand(qemu_args);
    run_cmd.step.dependOn(&kernel.step);

    const run_step = b.step("run", "run the kernel in qemu");
    run_step.dependOn(&run_cmd.step);

    kernel.setTarget(target);
    kernel.setBuildMode(mode);
    kernel.code_model = .medium;
    kernel.install();
}
