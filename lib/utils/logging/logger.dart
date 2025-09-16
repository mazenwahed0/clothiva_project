import 'package:logger/logger.dart';

class CLoggerHelper {
  // Initialize a logger instance
  static final Logger _logger = Logger(
    printer: PrettyPrinter(), // Custom printer for better log formatting
    level: Level.debug, // Set the default log level
  );

  // Debug level logging
  static void debug(String message) {
    _logger.d(message); // 'd' is for debug level
  }

  // Info level logging
  static void info(String message) {
    _logger.i(message); // 'i' is for info level
  }

  // Warning level logging
  static void warning(String message) {
    _logger.w(message); // 'w' is for warning level
  }

  // Error level logging with optional error details
  static void error(String message, [dynamic error]) {
    _logger.e(message,
        error: error, stackTrace: StackTrace.current); // 'e' is for error level
  }
}
