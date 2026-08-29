class Bium < Formula
  desc "Reclaim disk space on a Mac, honestly"
  homepage "https://github.com/raeseoklee/bium"
  # Ships a prebuilt universal (arm64 + x86_64) binary rather than building from
  # source, for the same reason as hidpify: `swift build` needs an up-to-date
  # Xcode Command Line Tools install, and an outdated or missing one fails the
  # install outright. The binary is ad-hoc signed at release time and that
  # signature survives Homebrew's copy, so no toolchain is required here.
  url "https://github.com/raeseoklee/bium/releases/download/v0.1.0/bium-0.1.0-macos-universal.tar.gz"
  sha256 "927b1782bff445dbf57bb481849b1f31eebbd94362d303f46ca54729e474ce36"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bium"
  end

  def caveats
    <<~EOS
      bium only touches your home directory, and `clean` defaults to the SAFE
      level, moving things to the Trash rather than deleting them.

      macOS keeps ~/.Trash, Safari caches and iOS backups behind Full Disk
      Access. Without it bium reports those locations as unreadable instead of
      counting them as empty; grant it under System Settings > Privacy &
      Security > Full Disk Access if you want them included.

      Start with:
        bium scan
    EOS
  end

  test do
    assert_match "bium", shell_output("#{bin}/bium --help")
    # scan never modifies anything, so it is safe to run in the test sandbox.
    system bin/"bium", "scan", "--no-actions"
  end
end
