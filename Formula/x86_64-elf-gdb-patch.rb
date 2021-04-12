class X8664ElfGdbPatch < Formula
  desc "GNU debugger for i386-elf cross development"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://sourceware.org/pub/gdb/snapshots/current/gdb-weekly-11.0.50.20210411.tar.xz"
  sha256 "982662fe8255f3a19961e293da3acd3bdc422446264d5dbaa762fccb025dba24"
  license "GPL-3.0-or-later"
  head "https://sourceware.org/git/binutils-gdb.git"

  depends_on "python@3.9"
  depends_on "xz"

  conflicts_with "gdb", because: "both install include/gdb, share/gdb and share/info"
  conflicts_with "i386-elf-gdb", because: "both install include/gdb, share/gdb and share/info"

  def install
    args = %W[
      --target=x86_64-elf
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --with-lzma
      --enable-targets=x86_64-none-elf
      --with-python=#{Formula["python@3.9"].opt_bin}/python3
      --disable-binutils
    ]

    mkdir "build" do
      system "../configure", *args
      system "make"

      system "make", "install-gdb"
    end
  end

  test do
    system "#{bin}/x86_64-elf-gdb", "#{bin}/x86_64-elf-gdb", "-configuration"
  end
end
