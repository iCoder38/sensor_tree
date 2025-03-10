import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/web.dart';

class BaseURL {
  // base URL
  String baseUrl = dotenv.env['API_BASE_URL'].toString();
}

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
