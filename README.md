<div align="center">

# 📝 Swift Log Bridge

**Flutter bridge to Apple's [swift-log](https://github.com/apple/swift-log)**

[![CI](https://github.com/kasianov-mikhail/swift_log_bridge/actions/workflows/ci.yml/badge.svg)](https://github.com/kasianov-mikhail/swift_log_bridge/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/swift_log_bridge.svg)](https://pub.dev/packages/swift_log_bridge)
[![license](https://img.shields.io/github/license/kasianov-mikhail/swift_log_bridge.svg)](https://github.com/kasianov-mikhail/swift_log_bridge/blob/main/LICENSE)

trace · debug · info · notice · warning · error · critical

</div>

<br>

> [!NOTE]
> iOS only.

## 📦 Installation

```yaml
dependencies:
  swift_log_bridge: ^0.1.0
```

## 🚀 Usage

```dart
import 'package:swift_log_bridge/swift_log_bridge.dart';

const logger = Logger('MyApp');

await logger.info('User signed in');
await logger.error('Request failed', metadata: {'status': '500'});
await logger.debug('Cache hit');
```

## ⚙️ How It Works

Each `Logger` instance maps to a `Logging.Logger` on iOS via method channels. By default, swift-log prints to the console — configure a backend like [Scout](https://github.com/kasianov-mikhail/scout) on the iOS side to persist logs.
