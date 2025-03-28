import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sensor_tree/Classes/Service/api_client.dart';

class ApiService {
  final Dio _dio = ApiClient().dio;

  // ✅ Generic POST Request
  Future<Map<String, dynamic>> postRequest(
    String endpoint,
    Map<String, dynamic> payload, {
    bool useFormData = false,
    String? token,
  }) async {
    try {
      Options options = Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );

      Response response = await _dio.post(
        endpoint,
        data: useFormData ? FormData.fromMap(payload) : payload,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // ✅ Generic GET Request
  Future<Map<String, dynamic>> getRequest(
    String endpoint,
    Map<String, dynamic> queryParams, {
    String? token,
  }) async {
    try {
      Options options = Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );

      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // ✅ GET Request Without Params
  Future<Map<String, dynamic>> getRequestWithoutParams(
    String endpoint, {
    String? token,
  }) async {
    try {
      Options options = Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );

      Response response = await _dio.get(endpoint, options: options);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
      return {'success': false, 'error': e.message};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // 🔥 Central Error Handler
  void _handleDioError(DioException e) {
    if (kDebugMode) {
      print("❌ Dio Error: ${e.response?.statusCode} - ${e.message}");
      if (e.response != null) {
        print("🔹 Response Data: ${e.response?.data}");
      }
    }
  }
}
