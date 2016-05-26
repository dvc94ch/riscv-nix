{ libcxxStdenv, fetchFromGitHub, riscv-fesvr,
  enableGdb ? false, defaultISA ? "RV64IMAFDC" }:

libcxxStdenv.mkDerivation rec {
    name = "riscv-isa-sim";
    version = "2016.05.15";

    srcRiscv = fetchFromGitHub {
        owner = "riscv";
        repo = "riscv-isa-sim";
        rev = "3bfc00ef2a1b1f0b0472a39a866261b00f67027e";
        sha256 = "0psikrlhxayrz7pimn9gvkqd5syvcm3l90hnwkgbd63nmv11fazi";
    };

    srcTimsifive = fetchFromGitHub {
        owner = "timsifive";
        repo = "riscv-isa-sim";
        rev = "143496ea96c111248811439280a5b3e3b3d3f27d";
        sha256 = "0d7gimh0xrs7lv991jib2mzj7s0j2c769n324p1i4ip7s6xz0pjs";
    };

    src = if enableGdb then srcTimsifive else srcRiscv;

    buildInputs = [ riscv-fesvr ];
    configureFlags = [ "--with-isa=${defaultISA}" ];
}
