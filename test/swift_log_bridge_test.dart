import 'package:flutter_test/flutter_test.dart';
import 'package:swift_log_bridge/swift_log_bridge.dart';
import 'package:swift_log_bridge/swift_log_bridge_platform_interface.dart';
import 'package:swift_log_bridge/swift_log_bridge_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSwiftLogBridgePlatform
    with MockPlatformInterfaceMixin
    implements SwiftLogBridgePlatform {
  String? lastLabel;
  String? lastMessage;
  LogLevel? lastLevel;
  Map<String, String>? lastMetadata;

  @override
  Future<void> log({
    required String label,
    required LogLevel level,
    required String message,
    Map<String, String>? metadata,
  }) async {
    lastLabel = label;
    lastLevel = level;
    lastMessage = message;
    lastMetadata = metadata;
  }
}

void main() {
  final SwiftLogBridgePlatform initialPlatform =
      SwiftLogBridgePlatform.instance;

  test('MethodChannelSwiftLogBridge is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSwiftLogBridge>());
  });

  test('Logger.info delegates to platform', () async {
    final mock = MockSwiftLogBridgePlatform();
    SwiftLogBridgePlatform.instance = mock;

    const logger = Logger('TestApp');
    await logger.info('hello');

    expect(mock.lastLabel, 'TestApp');
    expect(mock.lastLevel, LogLevel.info);
    expect(mock.lastMessage, 'hello');
  });

  test('Logger.error with metadata delegates to platform', () async {
    final mock = MockSwiftLogBridgePlatform();
    SwiftLogBridgePlatform.instance = mock;

    const logger = Logger('TestApp');
    await logger.error('failure', metadata: {'code': '500'});

    expect(mock.lastLevel, LogLevel.error);
    expect(mock.lastMessage, 'failure');
    expect(mock.lastMetadata, {'code': '500'});
  });

  test('all log levels delegate correctly', () async {
    final mock = MockSwiftLogBridgePlatform();
    SwiftLogBridgePlatform.instance = mock;
    const logger = Logger('Test');

    await logger.trace('t');
    expect(mock.lastLevel, LogLevel.trace);

    await logger.debug('d');
    expect(mock.lastLevel, LogLevel.debug);

    await logger.notice('n');
    expect(mock.lastLevel, LogLevel.notice);

    await logger.warning('w');
    expect(mock.lastLevel, LogLevel.warning);

    await logger.critical('c');
    expect(mock.lastLevel, LogLevel.critical);
  });
}
