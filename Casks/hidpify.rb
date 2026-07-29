cask "hidpify" do
  version "0.1.5"
  sha256 "8184c8aca714e2977cb01ef232751cfe4cd2c9b973533f86b1e10c600ded8dc5"

  url "https://github.com/raeseoklee/hidpify/releases/download/v#{version}/Hidpify.app.zip"
  name "Hidpify"
  desc "Menu bar app to force HiDPI on external displays"
  homepage "https://github.com/raeseoklee/hidpify"

  # The menu bar app is a pure frontend; the CLI/daemon (this formula) does the
  # real work, and the app points the login daemon at its stable binary.
  depends_on formula: "raeseoklee/tap/hidpify"
  depends_on macos: :sonoma

  app "Hidpify.app"

  # Declarative only — no postflight/uninstall_preflight arbitrary code. That
  # keeps the cask "trusted" (so a plain `brew upgrade` handles it) and keeps the
  # daemon's lifecycle decoupled from cask operations: `brew upgrade`/`uninstall`
  # never remove the LaunchAgent, so the daemon can't be left half-torn-down.
  # The daemon is installed by the app on first launch (self-heal) and removed
  # by `--zap` (below) or `hidpify uninstall-agent`.
  uninstall quit: "dev.irae.hidpify.app"

  zap launchctl: "dev.irae.hidpify",
      trash:     [
        "~/Library/LaunchAgents/dev.irae.hidpify.plist",
        "~/.config/hidpify",
        "~/Library/Logs/hidpify.log",
      ]

  caveats <<~EOS
    Hidpify isn't notarized (it's ad-hoc signed), so open it once after install:
    launch Hidpify from /Applications and, if macOS blocks it, allow it under
    System Settings → Privacy & Security → "Open Anyway" (or run once:
      xattr -dr com.apple.quarantine /Applications/Hidpify.app).
    Opening the app the first time also sets up the background daemon, which then
    runs at every login.

    Update:      brew upgrade --cask raeseoklee/tap/hidpify
    Remove all:  brew uninstall --zap --cask raeseoklee/tap/hidpify
                 (a plain uninstall removes the app but leaves the daemon; use
                  --zap, or run `hidpify uninstall-agent`, to remove it too)
  EOS
end
