cask "hidpify" do
  version "0.1.6"
  sha256 "079ef8e66f89c28c0c2e3023c065f3e988aeef9ef6e4ebc38b05b8bf3f5e60db"

  url "https://github.com/raeseoklee/hidpify/releases/download/v#{version}/Hidpify.app.zip"
  name "Hidpify"
  desc "Menu bar app to force HiDPI on external displays"
  homepage "https://github.com/raeseoklee/hidpify"

  # The menu bar app is a pure frontend; the CLI/daemon (this formula) does the
  # real work, and the app points the login daemon at its stable binary.
  depends_on formula: "raeseoklee/tap/hidpify"
  depends_on macos: :sonoma

  app "Hidpify.app"

  # ⚠️ DO NOT REMOVE THIS postflight. The app is ad-hoc signed (not notarized),
  # so if it stays quarantined, macOS Sequoia shows "Apple can't verify … malware"
  # whose DEFAULT button is "Move to Trash" — users click it and the app is
  # DELETED. Clearing the quarantine flag here makes it open normally. This was
  # once removed to make the cask "declarative/trusted" and it caused exactly that
  # regression; it must stay until the app is notarized. It does NOT touch the
  # daemon (kept decoupled — the app self-heals it). Trade-off: this arbitrary
  # code marks the cask "untrusted", so a plain `brew upgrade` skips it — update
  # the app with `brew upgrade --cask …`. That friction is acceptable; a deleted
  # app is not.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Hidpify.app"],
                   sudo:         false,
                   must_succeed: false
  end

  uninstall quit: "dev.irae.hidpify.app"

  zap launchctl: "dev.irae.hidpify",
      trash:     [
        "~/Library/LaunchAgents/dev.irae.hidpify.plist",
        "~/.config/hidpify",
        "~/Library/Logs/hidpify.log",
      ]

  caveats <<~EOS
    The installer clears the app's Gatekeeper quarantine flag (the app is ad-hoc
    signed, not notarized), so it opens normally. Just open Hidpify once from
    /Applications — that also sets up the background daemon, which then runs at
    every login. If macOS ever still blocks it, run once:
      xattr -dr com.apple.quarantine /Applications/Hidpify.app

    Update:      brew upgrade --cask raeseoklee/tap/hidpify
    Remove all:  brew uninstall --zap --cask raeseoklee/tap/hidpify
                 (a plain uninstall removes the app but leaves the daemon; use
                  --zap, or run `hidpify uninstall-agent`, to remove it too)
  EOS
end
