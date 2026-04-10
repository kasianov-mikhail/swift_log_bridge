import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'swift_log_bridge_method_channel.dart';
import 'src/log_level.dart';

abstract class SwiftLogBridgePlatform extends PlatformInterface {
  SwiftLogBridgePlatform() : super(token: _token);

  static final Object _token = Object();
  static SwiftLogBridgePlatform _instance = MethodChannelSwiftLogBridge();

  static SwiftLogBridgePlatform get instance => _instance;

  static set instance(SwiftLogBridgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> log({
    required String label,
    required LogLevel level,
    required String message,
    Map<String, String>? metadata,
  }) {
    throw UnimplementedError('log() has not been implemented.');
  }
}
