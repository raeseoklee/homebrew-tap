# frozen_string_literal: true

cask "ssmv" do
  version "0.1.0"
  sha256 "c2ac9544e58405f0f5fc060e2ca61cb383a36cff629a0d8b5ac703829813bf82"

  url "https://github.com/raeseoklee/ssmv/releases/download/v#{version}/SSMV-#{version}.zip"
  name "SSMV"
  name "So Simple Markdown Viewer"
  desc "Native Markdown viewer with PDF export"
  homepage "https://github.com/raeseoklee/ssmv"

  depends_on macos: ">= :ventura"

  app "SSMV.app"

  uninstall quit: "io.github.irae.ssmv"

  zap trash: "~/Library/Preferences/io.github.irae.ssmv.plist"
end
