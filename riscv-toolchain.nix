{ stdenv, pkgs, fetchFromGitHub,
  xlen ? 64, arch ? "IMAFD", newlibCflags ? "",
  enableLinux ? false, enableMultilib ? false,
  disableFloat ? false, disableAtomic ? false }:

stdenv.mkDerivation rec {
    name = "riscv-toolchain";

    src = fetchFromGitHub {
      owner = "riscv";
      repo = "riscv-gnu-toolchain";
      rev = "34db4e0c9d030c6a5263989d162a1f650a83a57e";
      sha256 = "1jkk120fkrvi441fqg9snpwfgrshws59kxjl2sb18mmdhxsbvz50";
    };

    buildInputs = with pkgs; [ autoconf automake texinfo
      gmp libmpc mpfr gawk bison flex texinfo gperf curl ];

    configureFlags = [
        "--with-xlen=${toString xlen}"
        "--with-arch=${arch}"
        (if enableLinux then "--enable-linux" else "")
        (if enableMultilib then "--enable-multilib" else "")
        (if disableFloat then "--disable-float" else "")
        (if disableAtomic then "--disable-atomic" else "")
    ];

    CFLAGS_FOR_TARGET = newlibCflags;

    dontPatchELF = true;
    dontStrip = true;
}
