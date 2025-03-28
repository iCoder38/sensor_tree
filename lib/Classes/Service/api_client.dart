// import 'package:anamak/features/UTILS/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sensor_tree/Classes/Utils/utils.dart';

class ApiClient {
  late final Dio dio;

  // Singleton pattern to ensure a single Dio instance
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: BaseURL().baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging and error handling interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print(
              "📤 Request: ${options.method} ${options.baseUrl}${options.path}",
            );
            print("🔹 Headers: ${options.headers}");
            print("📩 Payload: ${options.data}");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print("✅ Response (${response.statusCode}): ${response.data}");
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print("❌ Dio Error: ${e.message}");
          }
          return handler.next(e);
        },
      ),
    );
  }
}
