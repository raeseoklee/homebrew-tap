# homebrew-tap

Homebrew tap for [bium](https://github.com/raeseoklee/bium) and
[hidpify](https://github.com/raeseoklee/hidpify).

```sh
brew tap raeseoklee/tap
```

## bium

Reclaims disk space on a Mac. Counts hard links once, never guesses, and reports
the directories it was not allowed to read instead of calling them empty.

```sh
brew install raeseoklee/tap/bium        # command line tool
brew install --cask raeseoklee/tap/bium # SwiftUI app
```

The two are independent: the app is not a wrapper around the binary, and either
can be installed on its own.

## hidpify

Forces HiDPI on macOS external displays through a virtual display.

```sh
brew install raeseoklee/tap/hidpify        # CLI and daemon
brew install --cask raeseoklee/tap/hidpify # menu bar app
```

The cask depends on the formula: the menu bar app is a front end, and the
CLI daemon does the work.

## Notes

**These ship prebuilt binaries.** Both formulae install a universal (arm64 and
x86_64) binary from a release archive rather than compiling on your machine, so
no Swift toolchain is needed. The binaries are ad-hoc signed at release time and
that signature survives Homebrew's copy.

**The casks are not notarized.** Each one clears the quarantine flag in a
`postflight`. Without it macOS shows an "Apple can't verify … malware" dialog
whose default button is *Move to Trash*, which deletes the app the user just
installed.

That `postflight` runs arbitrary code, so Homebrew marks these casks untrusted
and a plain `brew upgrade` skips them. Upgrade the apps explicitly:

```sh
brew upgrade --cask bium hidpify
```
