import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/secrets/server_secrets.dart';

@lazySingleton
class DioService {
  final _dio = Dio(BaseOptions(baseUrl: baseUrl));
  dynamic get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;    
  }
  dynamic post({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
      final response = await _dio.post(
        path,
        options: Options(headers: headers),
        data: body,
      );
      return response.data;    
  }
  dynamic put({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
      final response = await _dio.put(
        path,
        options: Options(headers: headers),
        data: body,
      );
      return response.data;    
  }
  dynamic delete({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
      final response = await _dio.delete(
        path,
        options: Options(headers: headers),
        data: body,
      );
      return response.data;    
  }
}
