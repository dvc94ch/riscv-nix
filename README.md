## Nix scripts for riscv projects

# Getting started

1. Install the nix package manager
2. Clone this repo into ~/.nixpkgs
3. Create a default.nix file in your project directory
4. Run nix-shell to build a custom riscv-toolchain for your project

Example `default.nix` file:
```nix
with import <nixpkgs> {};

let
    riscv32i-toolchain = pkgs.riscv-toolchain.override {
        xlen = 32;
        arch = "I";
        disableFloat = true;
        disableAtomic = true;
        newlibCflags = [
            "-g" "-Os"
            "-DINTEGER_ONLY"
            "-DPREFER_SIZE_OVER_SPEED"
            "-DREENTRANT_SYSCALLS_PROVIDED"
            "-fomit-frame-pointer"
        ];
    };
    riscv32i-spike = pkgs.riscv-spike.override {
        enableGdb = true;
        defaultISA = "RV32I";
    };
    riscv32i-pk = pkgs.riscv-pk.override {
        riscv-toolchain = riscv32i-toolchain;
        riscv-spike = riscv32i-spike;
        xlen = 32;
    };
    riscv32i-gdb = pkgs.riscv-gdb.override {
        xlen = 32;
    };
in
stdenv.mkDerivation {
    name = "riscv-test";

    buildInputs = [ riscv32i-toolchain riscv32i-spike riscv32i-gdb riscv32i-pk which ];
}
```
