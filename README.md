# Basic RISC-V Kernel in Zig

This repository contains very basic initialization code to start writing a
RISC-V kernel in the [Zig](https://ziglang.org) programming language. Compiling
and running the kernel should provide a basic kernel that halts on start.

## Directory Structure

```txt
src - base zig code for the kernel
src/asm - assembly files for booting and similar
src/linker/kernel.lds - linker script to link the kernel
build.zig - the build script to compile the kernel
```

## License

```txt
BSD Zero Clause License

Copyright (c) 2022, Hanna Rose

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```
