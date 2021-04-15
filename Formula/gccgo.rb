class Gccgo < Formula
  desc "GNU compiler collection for gccgo"
  homepage "https://gcc.gnu.org"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.3.0/gcc-10.3.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-10.3.0/gcc-10.3.0.tar.xz"
  sha256 "64f404c1a650f27fc33da242e1f2df54952e3963a49e06e73f6940f3223ac344"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "binutils"

  def install
    mkdir "gcc-build" do
      system "../configure", "--prefix=#{prefix}",
                             "--disable-nls",
                             "--enable-languages=c,c++,go"
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"

      # FSF-related man pages may conflict with native gcc
      (share/"man/man7").rmtree
    end
  end

  test do
    (testpath/"test-c.c").write <<~EOS
      int main(void)
      {
        int i=0;
        while(i<10) i++;
        return i;
      }
    EOS
    system "#{bin}/gcc", "-c", "-o", "test-c.o", "test-c.c"
    assert_match "file format elf64-x86-64",
      shell_output("#{Formula["binutils"].bin}/objdump -a test-c.o")
  end
end
