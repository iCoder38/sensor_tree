import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';

final Logger logger = Logger(
  level: kReleaseMode ? Level.off : Level.debug,
  printer: PrettyPrinter(colors: true),
);
void customLog(dynamic message) {
  if (kDebugMode) {
    // print(message);
    logger.d(message);
  }
}
