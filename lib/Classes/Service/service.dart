// import 'package:anamak/features/Services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sensor_tree/Classes/Service/api_client.dart';

class ApiService {
  final Dio _dio = ApiClient().dio;

  // ✅ Generic POST Request (Handles both JSON & FormData)
  Future<Map<String, dynamic>> postRequest(
    String endpoint,
    Map<String, dynamic> payload, {
    bool useFormData = false, // If true, sends data as FormData
  }) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data:
            useFormData
                ? FormData.fromMap(payload)
                : payload, // ✅ Send as JSON by default
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // ✅ Generic GET Request (With Query Parameters)
  Future<Map<String, dynamic>> getRequest(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // 🔥 Handles Dio errors centrally
  void _handleDioError(DioException e) {
    if (kDebugMode) {
      print("❌ Dio Error: ${e.response?.statusCode} - ${e.message}");
      if (e.response != null) {
        print("🔹 Response Data: ${e.response?.data}");
      }
    }
  }
}
