class X8664ElfGrub < Formula
  desc "GNU GRUB 2 targetting x86_64-elf"
  homepage "https://www.gnu.org/software/grub/"
  url "https://ftp.gnu.org/gnu/grub/grub-2.02.tar.xz"
  version "2.02"
  sha256 "810b3798d316394f94096ec2797909dbf23c858e48f7b3830826b8daa06b7b0f"

  depends_on "x86_64-elf-gcc"

  def install
    mkdir "grub-build" do
      system "../configure",
        "--disable-nls",
        "--disable-werror",
        "--disable-efiemu",
        "--target=x86_64-elf",
        "--prefix=#{prefix}",
        "TARGET_CC=x86_64-elf-gcc",
        "TARGET_NM=x86_64-elf-nm",
        "TARGET_OBJCOPY=x86_64-elf-objcopy",
        "TARGET_RANLIB=x86_64-elf-ranlib",
        "TARGET_STRIP=x86_64-elf-strip"

      system "make", "install"
    end
  end

  test do
    system "grub-shell", "--version"
  end
end
