class Hidpify < Formula
  desc "Force HiDPI on macOS external displays via a virtual display"
  homepage "https://github.com/raeseoklee/hidpify"
  url "https://github.com/raeseoklee/hidpify/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c1835ff3a5dcb336f485595e3f74e5b96ec3051db0c4df380bf94ba2ca2ba413"
  license "Apache-2.0"
  head "https://github.com/raeseoklee/hidpify.git", branch: "main"

  depends_on :macos

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/hidpify"
    # Re-sign after Homebrew relocates the binary so launchd accepts the daemon
    # (SPM's linker signature is invalidated on copy).
    system "codesign", "--force", "--sign", "-", bin/"hidpify"
  end

  def caveats
    <<~EOS
      hidpify uses a private CoreGraphics API and a per-user LaunchAgent.
      To run the daemon automatically at login:
        hidpify install-agent

      Streaming mode additionally needs Screen Recording permission and is
      experimental — mirroring (the default) is recommended for everyday use.
    EOS
  end

  test do
    system bin/"hidpify", "list"
  end
end
