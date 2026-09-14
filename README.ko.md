# raeseoklee Homebrew tap

[English](README.md)

macOS용 도구 세 가지를 Homebrew로 설치할 수 있습니다. [bium](https://github.com/raeseoklee/bium)은 디스크 공간을 정리하고, [hidpify](https://github.com/raeseoklee/hidpify)는 외부 디스플레이에서 HiDPI를 활성화합니다. [SSMV](https://github.com/raeseoklee/ssmv)는 Markdown 문서를 읽는 앱입니다.

```sh
brew tap raeseoklee/tap
```

## SSMV — So Simple Markdown Viewer

**macOS 13 이상**에서 Markdown 문서를 읽는 네이티브 앱입니다. Swift와 AppKit으로 만들었으며 웹뷰나 외부 패키지를 사용하지 않습니다. Finder에서 파일을 열고, 접을 수 있는 사이드바에서 문서를 선택하며 읽을 수 있습니다. 라이트·다크 모드와 PDF 내보내기도 지원합니다. 사이드바에서 문서를 제거해도 원본 파일은 삭제되지 않습니다.

```sh
brew install --cask raeseoklee/tap/ssmv
```

Apple Silicon과 Intel을 모두 지원하는 Universal 앱입니다. 지원 기능과 제한, 소스에서 빌드하는 방법은 [SSMV 한국어 문서](https://github.com/raeseoklee/ssmv/blob/main/docs/README.ko.md)를 참고하세요.

## bium

Mac의 디스크 공간을 정리하는 도구입니다. 하드 링크는 한 번만 계산합니다. 읽지 못한 디렉터리는 비어 있다고 처리하지 않고 따로 알립니다.

```sh
brew install raeseoklee/tap/bium        # 명령줄 도구
brew install --cask raeseoklee/tap/bium # SwiftUI 앱; macOS 14 이상
```

앱과 명령줄 도구는 각각 설치할 수 있습니다. 앱이 명령줄 도구를 감싸서 실행하는 구조가 아니라 둘이 독립적으로 동작합니다. 자세한 내용은 [소스와 사용법](https://github.com/raeseoklee/bium)을 참고하세요.

## hidpify

가상 디스플레이를 통해 macOS 외부 디스플레이에서 HiDPI를 활성화합니다.

```sh
brew install raeseoklee/tap/hidpify        # CLI와 데몬
brew install --cask raeseoklee/tap/hidpify # 메뉴 막대 앱; macOS 14 이상
```

메뉴 막대 앱에서 기능을 조작하면 CLI 데몬이 실제 작업을 처리합니다. 따라서 앱을 제공하는 cask는 CLI와 데몬을 제공하는 formula에 의존합니다. 자세한 내용은 [소스와 사용법](https://github.com/raeseoklee/hidpify)을 참고하세요.

## 앱 서명과 설치 시 참고 사항

Apple Silicon과 Intel용으로 미리 빌드한 Universal 바이너리를 설치하므로 Swift 도구 모음은 필요하지 않습니다. 현재 앱들은 ad-hoc 서명 상태이며 Apple Developer ID 서명과 공증을 받지 않았습니다.

- **SSMV는 압축 파일의 SHA-256과 앱 서명을 확인한 뒤 SSMV.app의 격리 속성만 제거합니다.** 해당 앱의 Gatekeeper 최초 실행 검사를 건너뛰어 ad-hoc 빌드가 실행되도록 합니다. Apple 공증을 받거나 시스템 전체의 보안 설정을 바꾸는 것은 아닙니다. 직접 내려받은 앱은 차단될 수 있으므로 [Apple의 앱 실행 안내](https://support.apple.com/en-gb/102445)를 확인하세요. [소스에서 직접 빌드](https://github.com/raeseoklee/ssmv/blob/main/docs/README.ko.md)할 수도 있습니다.
- **bium과 hidpify는 기존 `postflight` 단계에서 설치된 앱의 격리 속성을 제거합니다.** 두 cask는 기존 Ruby `postflight` 방식을 사용하며, 이 과정에서 Gatekeeper의 일반적인 최초 실행 동작이 달라집니다. Homebrew가 이런 cask를 신뢰되지 않은 것으로 분류해 일반 업데이트에서 건너뛸 수 있습니다. 두 앱을 업데이트하려면 다음과 같이 명시적으로 지정하세요.

```sh
brew upgrade --cask raeseoklee/tap/bium raeseoklee/tap/hidpify
```
