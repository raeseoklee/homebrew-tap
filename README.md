# raeseoklee Homebrew tap

[한국어](README.ko.md)

Homebrew packages for three macOS tools: [bium](https://github.com/raeseoklee/bium) for disk cleanup, [hidpify](https://github.com/raeseoklee/hidpify) for external-display HiDPI, and [SSMV](https://github.com/raeseoklee/ssmv) for reading Markdown.

```sh
brew tap raeseoklee/tap
```

## SSMV — So Simple Markdown Viewer

A native, read-only Markdown viewer for **macOS 13 and later**, built with Swift and AppKit without a web view or third-party packages. Open documents from Finder, switch between files in a collapsible sidebar, use light or dark appearance, and export to PDF. Removing a sidebar entry preserves the original file.

```sh
brew install --cask raeseoklee/tap/ssmv
```

[Features, limitations, and source builds](https://github.com/raeseoklee/ssmv). The Universal app supports Apple Silicon and Intel.

## bium

Reclaims disk space on a Mac. Counts hard links once and reports directories it could not read instead of treating them as empty.

```sh
brew install raeseoklee/tap/bium        # command-line tool
brew install --cask raeseoklee/tap/bium # SwiftUI app; macOS 14+
```

The two are independent: the app is not a wrapper around the binary, and either can be installed on its own. [Source and usage](https://github.com/raeseoklee/bium).

## hidpify

Enables HiDPI on macOS external displays through a virtual display.

```sh
brew install raeseoklee/tap/hidpify        # CLI and daemon
brew install --cask raeseoklee/tap/hidpify # menu bar app; macOS 14+
```

The cask depends on the formula: the menu bar app is a front end, and the CLI daemon does the work. [Source and usage](https://github.com/raeseoklee/hidpify).

## Signing and installation behavior

These packages install prebuilt Universal binaries for Apple Silicon and Intel; installation does not require a Swift toolchain. The current apps are ad-hoc signed, not Developer ID signed or notarized by Apple.

- **SSMV checks the archive SHA-256 and app signature, then removes quarantine from SSMV.app only.** This allows the ad-hoc build to launch by bypassing Gatekeeper’s first-launch check for this app; it does not provide notarization or change global security settings. A manual download may still be blocked. See [Apple’s app-opening guidance](https://support.apple.com/en-gb/102445) or [build from source](https://github.com/raeseoklee/ssmv#build-from-source).
- **bium and hidpify have existing `postflight` steps that remove the installed app’s quarantine flag.** These two casks use legacy Ruby flight blocks, which alter Gatekeeper’s normal first-launch behavior. Homebrew may classify casks with such steps as untrusted and skip them during a general upgrade; update them explicitly:

```sh
brew upgrade --cask raeseoklee/tap/bium raeseoklee/tap/hidpify
```
