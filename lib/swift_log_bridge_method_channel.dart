import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'swift_log_bridge_platform_interface.dart';
import 'src/log_level.dart';

class MethodChannelSwiftLogBridge extends SwiftLogBridgePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('swift_log_bridge');

  @override
  Future<void> log({
    required String label,
    required LogLevel level,
    required String message,
    Map<String, String>? metadata,
  }) async {
    await methodChannel.invokeMethod('log', {
      'label': label,
      'level': level.name,
      'message': message,
      'metadata': metadata,
    });
  }
}
