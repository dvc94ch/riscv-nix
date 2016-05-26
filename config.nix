with import <nixpkgs> {};

{
  packageOverrides = pkgs: rec {
    riscv-fesvr = callPackage ./riscv-fesvr.nix {};
    riscv-spike = callPackage ./riscv-isa-sim.nix {};
    riscv-gdb = callPackage ./riscv-gdb.nix {};
    riscv-pk = callPackage ./riscv-pk.nix {};
    riscv-tools = callPackage ./riscv-tools.nix {};
    riscv-toolchain = callPackage ./riscv-toolchain.nix {};
  };
}
