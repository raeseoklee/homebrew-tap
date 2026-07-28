class Hidpify < Formula
  desc "Force HiDPI on macOS external displays via a virtual display"
  homepage "https://github.com/raeseoklee/hidpify"
  url "https://github.com/raeseoklee/hidpify/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9b71c8eacfcc2835e254161b90d50c9f8ffb0e8d73a1dd73a87b2a66dd234a61"
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
