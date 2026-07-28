cask "hidpify" do
  version "0.1.1"
  sha256 "2164e52f2aed85281aee1053b49993acdce70d1b577399448e97a56ed6d31132"

  url "https://github.com/raeseoklee/hidpify/releases/download/v#{version}/Hidpify.app.zip"
  name "Hidpify"
  desc "Menu bar app to force HiDPI on external displays"
  homepage "https://github.com/raeseoklee/hidpify"

  # The menu bar app is a pure frontend; the CLI/daemon does the real work.
  depends_on formula: "raeseoklee/tap/hidpify"
  depends_on macos: :sonoma

  app "Hidpify.app"

  caveats <<~EOS
    Hidpify.app uses a private CoreGraphics API and can't be notarized, so
    macOS Gatekeeper blocks the first launch. Open it once with a
    right-click -> Open, or clear the quarantine flag:
      xattr -dr com.apple.quarantine "/Applications/Hidpify.app"

    Enable "Start at Login" from the app (or run `hidpify install-agent`) to
    keep the daemon running across logins.
  EOS
end
