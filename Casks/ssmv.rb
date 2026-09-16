# frozen_string_literal: true

cask "ssmv" do
  version "0.5.1"
  sha256 "79313b9749836c3bb1035717ec8bf54f9e9291b5910a20dd08a852014b5973c7"

  url "https://github.com/raeseoklee/ssmv/releases/download/v#{version}/SSMV-#{version}.zip"
  name "SSMV"
  name "So Simple Markdown Viewer"
  desc "Native Markdown viewer with PDF export"
  homepage "https://github.com/raeseoklee/ssmv"

  depends_on macos: :ventura

  app "SSMV.app"
  binary "#{appdir}/SSMV.app/Contents/MacOS/SSMVCLI", target: "ssmv"

  # The ad-hoc release is not notarized. Verify the bundle before allowing it
  # to open, matching this tap's existing app distribution behavior.
  postflight_steps do
    run "/usr/bin/codesign", args: ["--verify", "--strict", "{{appdir}}/SSMV.app"]
    run "/usr/bin/xattr", args: ["-d", "-r", "com.apple.quarantine", "{{appdir}}/SSMV.app"]
  end

  uninstall quit: "io.github.irae.ssmv"

  zap trash: "~/Library/Preferences/io.github.irae.ssmv.plist"

  caveats <<~EOS
    Open SSMV once after installation to register it in Finder's Open With menu.

    SSMV is ad-hoc signed and not Apple notarized. After checksum and bundle
    signature checks, this cask removes quarantine from SSMV.app only so it
    can launch. This bypasses Gatekeeper's first-launch check for this app;
    it does not provide Apple notarization or change global security settings.
  EOS
end
