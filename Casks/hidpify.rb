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

  # The app isn't notarized (ad-hoc signed), so macOS Gatekeeper would block
  # the first launch. Clear the quarantine flag on install so it opens
  # normally. (You are trusting this third-party tap by installing it.)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hidpify.app"],
                   sudo: false
  end

  caveats <<~EOS
    Hidpify.app isn't notarized (ad-hoc signed), so macOS Gatekeeper blocks
    the first launch. Allow it by running once:
      xattr -dr com.apple.quarantine "/Applications/Hidpify.app"
    (On macOS 15 the old right-click -> Open trick no longer works; you can
    instead click "Open Anyway" in System Settings > Privacy & Security.)

    Enable "Start at Login" from the app (or run `hidpify install-agent`) to
    keep the daemon running across logins.
  EOS
end
