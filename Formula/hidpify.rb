class Hidpify < Formula
  desc "Force HiDPI on macOS external displays via a virtual display"
  homepage "https://github.com/raeseoklee/hidpify"
  # Ships a prebuilt universal (arm64 + x86_64) binary rather than building from
  # source: `swift build` needs an up-to-date Xcode Command Line Tools install,
  # and an outdated/missing one fails the install outright. The binary is ad-hoc
  # signed at release time and its signature survives Homebrew's copy, so no
  # toolchain (not even codesign) is required here.
  url "https://github.com/raeseoklee/hidpify/releases/download/v0.1.9/hidpify-0.1.9-macos-universal.tar.gz"
  sha256 "b3585e7e738f03dcc3a35b80661438505115be54c4b0567791ecf9ab63c65ce3"
  version "0.1.9"
  license "Apache-2.0"

  depends_on macos: :sonoma

  def install
    bin.install "hidpify"
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
