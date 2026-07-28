# homebrew-tap

Homebrew tap for [hidpify](https://github.com/raeseoklee/hidpify).

```sh
brew install raeseoklee/tap/hidpify
```

Or:

```sh
brew tap raeseoklee/tap
brew install hidpify
```

The formula builds from source (a Swift package that uses a private CoreGraphics
API — not distributable as a notarized bottle), so a Swift toolchain
(`xcode-select --install`) is required.
