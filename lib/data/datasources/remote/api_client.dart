import 'package:dio/dio.dart';
import 'package:lich_van_nien/core/constants/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  // Gửi yêu cầu GET đến một endpoint
  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Gửi yêu cầu POST tới một endpoint
  Future<Response> post(String endpoint, {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  // Xử lý phản hồi từ API
  Response _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response; // Thành công
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
