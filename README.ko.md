# raeseoklee Homebrew tap

[English](README.md)

macOS용 도구 세 가지를 제공하는 Homebrew tap입니다. [bium](https://github.com/raeseoklee/bium)은 디스크 정리, [hidpify](https://github.com/raeseoklee/hidpify)는 외부 디스플레이 HiDPI, [SSMV](https://github.com/raeseoklee/ssmv)는 Markdown 읽기를 지원합니다.

```sh
brew tap raeseoklee/tap
```

## SSMV — So Simple Markdown Viewer

**macOS 13 이상**에서 사용하는 네이티브 Markdown 읽기 전용 앱입니다. Swift와 AppKit으로 구현했으며 웹뷰나 외부 패키지를 사용하지 않습니다. Finder에서 문서를 열고, 접을 수 있는 사이드바에서 문서를 전환하며, 라이트·다크 모드와 PDF 내보내기를 사용할 수 있습니다. 사이드바에서 제거해도 원본 파일은 유지됩니다.

```sh
brew install --cask raeseoklee/tap/ssmv
```

[기능·제한 사항·소스 빌드 안내](https://github.com/raeseoklee/ssmv/blob/main/docs/README.ko.md). Universal 앱으로 Apple Silicon과 Intel을 지원합니다.

## bium

Mac의 디스크 공간을 정리합니다. 하드 링크는 한 번만 계산하며, 읽지 못한 디렉터리는 비어 있다고 처리하지 않고 따로 알립니다.

```sh
brew install raeseoklee/tap/bium        # 명령줄 도구
brew install --cask raeseoklee/tap/bium # SwiftUI 앱; macOS 14 이상
```

앱과 명령줄 도구는 독립적이며 각각 설치할 수 있습니다. 앱은 명령줄 도구를 감싼 프로그램이 아닙니다. [소스·사용법](https://github.com/raeseoklee/bium).

## hidpify

가상 디스플레이를 통해 macOS 외부 디스플레이에서 HiDPI를 활성화합니다.

```sh
brew install raeseoklee/tap/hidpify        # CLI와 데몬
brew install --cask raeseoklee/tap/hidpify # 메뉴 막대 앱; macOS 14 이상
```

앱 cask는 formula에 의존합니다. 메뉴 막대 앱이 조작 화면을 제공하고 CLI 데몬이 실제 작업을 수행합니다. [소스·사용법](https://github.com/raeseoklee/hidpify).

## 서명 및 설치 동작

Apple Silicon·Intel용으로 미리 빌드한 Universal 바이너리를 설치하므로 Swift 도구 모음이 필요하지 않습니다. 현재 앱들은 ad-hoc 서명 상태이며 Apple Developer ID 서명 및 공증을 받지 않았습니다.

- **SSMV는 Gatekeeper 격리 속성을 유지합니다.** cask가 격리 속성을 제거하거나 macOS 보안 설정을 바꾸지 않습니다. 처음 실행할 때 차단될 수 있으므로 실행 여부를 결정하기 전에 [Apple의 앱 실행 안내](https://support.apple.com/en-gb/102445)를 확인하거나 [소스에서 직접 빌드](https://github.com/raeseoklee/ssmv/blob/main/docs/README.ko.md)하세요.
- **bium과 hidpify에는 설치된 앱의 격리 속성을 제거하는 기존 `postflight` 단계가 있습니다.** 이는 Gatekeeper의 일반적인 최초 실행 동작을 바꾸며 두 cask에만 해당합니다. Homebrew가 이런 단계를 포함한 cask를 신뢰되지 않은 것으로 분류해 일반 업데이트에서 건너뛸 수 있으므로 명시적으로 업데이트합니다.

```sh
brew upgrade --cask raeseoklee/tap/bium raeseoklee/tap/hidpify
```
