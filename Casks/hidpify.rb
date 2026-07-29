cask "hidpify" do
  version "0.1.4"
  sha256 "1fe2dda9340effb257159a9c116a40509bf768cb7882d7cb286a960a25755767"

  url "https://github.com/raeseoklee/hidpify/releases/download/v#{version}/Hidpify.app.zip"
  name "Hidpify"
  desc "Menu bar app to force HiDPI on external displays"
  homepage "https://github.com/raeseoklee/hidpify"

  # The menu bar app is a pure frontend; the CLI/daemon does the real work.
  depends_on formula: "raeseoklee/tap/hidpify"
  depends_on macos: :sonoma

  app "Hidpify.app"

  postflight do
    # The app isn't notarized (ad-hoc signed), so macOS Gatekeeper would block
    # the first launch — clear the quarantine flag so it opens normally.
    # (You are trusting this third-party tap by installing it.)
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hidpify.app"],
                   sudo:         false,
                   must_succeed: false
    # Install the LaunchAgent so the daemon starts now and at every login,
    # so the tool works immediately after install. Remove with
    # `hidpify uninstall-agent`.
    system_command "#{HOMEBREW_PREFIX}/bin/hidpify",
                   args:         ["install-agent"],
                   sudo:         false,
                   must_succeed: false
  end

  uninstall_preflight do
    # postflight installed a LaunchAgent outside Homebrew's tracking, so removing
    # the app alone would leave the daemon running and registered. Tear it down
    # (stop the daemon + delete the plist) so uninstall leaves nothing behind.
    system_command "#{HOMEBREW_PREFIX}/bin/hidpify",
                   args:         ["uninstall-agent"],
                   sudo:         false,
                   must_succeed: false
  end

  zap trash: [
    "~/.config/hidpify",
    "~/Library/Logs/hidpify.log",
  ]

  caveats <<~EOS
    Setup ran automatically: the app's quarantine flag was cleared (it isn't
    notarized) and the hidpify daemon was registered to run now and at login.

    If macOS still blocks the app on first launch, run once:
      xattr -dr com.apple.quarantine "/Applications/Hidpify.app"

    To stop the daemon from running at login:  hidpify uninstall-agent
  EOS
end
