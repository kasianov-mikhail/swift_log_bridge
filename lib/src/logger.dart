import '../swift_log_bridge_platform_interface.dart';
import 'log_level.dart';

/// A logger backed by Apple's swift-log on iOS.
///
/// Each [Logger] instance is associated with a [label] that categorizes
/// log messages. On iOS, a corresponding `Logging.Logger` is created
/// with the same label.
class Logger {
  /// Creates a logger with the given [label].
  const Logger(this.label);

  /// The category label for this logger.
  final String label;

  /// Log a message at the given [level].
  Future<void> log(
    LogLevel level,
    String message, {
    Map<String, String>? metadata,
  }) {
    return SwiftLogBridgePlatform.instance.log(
      label: label,
      level: level,
      message: message,
      metadata: metadata,
    );
  }

  /// Log a message at the [LogLevel.trace] level.
  Future<void> trace(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.trace, message, metadata: metadata);

  /// Log a message at the [LogLevel.debug] level.
  Future<void> debug(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.debug, message, metadata: metadata);

  /// Log a message at the [LogLevel.info] level.
  Future<void> info(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.info, message, metadata: metadata);

  /// Log a message at the [LogLevel.notice] level.
  Future<void> notice(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.notice, message, metadata: metadata);

  /// Log a message at the [LogLevel.warning] level.
  Future<void> warning(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.warning, message, metadata: metadata);

  /// Log a message at the [LogLevel.error] level.
  Future<void> error(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.error, message, metadata: metadata);

  /// Log a message at the [LogLevel.critical] level.
  Future<void> critical(String message, {Map<String, String>? metadata}) =>
      log(LogLevel.critical, message, metadata: metadata);
}
