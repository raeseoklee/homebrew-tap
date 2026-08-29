cask "bium" do
  version "0.1.2"
  sha256 "edce95b96977400f72645a4c9259dfedf9e7124287fc5c08d1ded0823cc2713e"

  url "https://github.com/raeseoklee/bium/releases/download/v#{version}/Bium.app.zip"
  name "bium"
  desc "Reclaim disk space on a Mac, honestly"
  homepage "https://github.com/raeseoklee/bium"

  depends_on macos: :sonoma

  app "Bium.app"

  uninstall quit: "com.raeseoklee.bium"

  # ⚠️ DO NOT REMOVE THIS postflight. The app is ad-hoc signed (not notarized),
  # so if it stays quarantined, macOS shows "Apple can't verify … malware" whose
  # DEFAULT button is "Move to Trash" — users click it and the app is DELETED.
  # Clearing the quarantine flag here makes it open normally. Same reasoning as
  # the hidpify cask, where removing it caused exactly that regression.
  #
  # Trade-off: arbitrary code marks the cask "untrusted", so a plain
  # `brew upgrade` skips it and the app needs `brew upgrade --cask bium`. That
  # friction is acceptable; a deleted app is not.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "-r", "com.apple.quarantine", "#{appdir}/Bium.app"],
                   sudo: false,
                   must_succeed: false
  end

  caveats <<~EOS
    bium only touches your home directory, and cleaning defaults to the SAFE
    level, moving items to the Trash rather than deleting them.

    macOS keeps ~/.Trash, Safari caches and iOS backups behind Full Disk Access.
    Without it bium reports those locations as unreadable instead of counting
    them as empty. Grant it under System Settings > Privacy & Security > Full
    Disk Access if you want them included.

    The command line tool is a separate formula:
      brew install raeseoklee/tap/bium
  EOS

  zap trash: [
    "~/Library/Application Support/bium",
  ]
end
