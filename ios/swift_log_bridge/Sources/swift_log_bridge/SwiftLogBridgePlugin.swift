#if canImport(Logging)
import Logging
#endif
import Flutter
import UIKit

public class SwiftLogBridgePlugin: NSObject, FlutterPlugin {
    #if canImport(Logging)
    private var loggers: [String: Logging.Logger] = [:]
    #endif

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "swift_log_bridge",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftLogBridgePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "log":
            handleLog(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleLog(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        #if canImport(Logging)
        guard let args = call.arguments as? [String: Any],
              let label = args["label"] as? String,
              let levelName = args["level"] as? String,
              let message = args["message"] as? String else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing label, level, or message", details: nil))
            return
        }

        var logger = getLogger(label: label)

        if let metadata = args["metadata"] as? [String: String] {
            for (key, value) in metadata {
                logger[metadataKey: key] = .string(value)
            }
        }

        let level = logLevel(from: levelName)
        logger.log(level: level, "\(message)")
        result(nil)
        #else
        result(FlutterError(
            code: "UNAVAILABLE",
            message: "swift-log requires Swift Package Manager.",
            details: nil
        ))
        #endif
    }

    #if canImport(Logging)
    private func getLogger(label: String) -> Logging.Logger {
        if let logger = loggers[label] {
            return logger
        }
        let logger = Logging.Logger(label: label)
        loggers[label] = logger
        return logger
    }

    private func logLevel(from name: String) -> Logging.Logger.Level {
        switch name {
        case "trace": return .trace
        case "debug": return .debug
        case "info": return .info
        case "notice": return .notice
        case "warning": return .warning
        case "error": return .error
        case "critical": return .critical
        default: return .info
        }
    }
    #endif
}
