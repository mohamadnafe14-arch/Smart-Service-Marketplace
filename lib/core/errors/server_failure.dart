import 'package:dio/dio.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';

class ServerFailuer extends Failure {
  ServerFailuer({required super.message});

  factory ServerFailuer.fromDioError({
    required DioException dioException,
  }) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuer(
          message: 'Connection timeout with server',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailuer(
          message: 'Send timeout with server',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailuer(
          message: 'Receive timeout with server',
        );

      case DioExceptionType.badResponse:
        return ServerFailuer.fromBadResponse(
          statusCode: dioException.response?.statusCode,
          data: dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailuer(
          message: 'Request to server was cancelled',
        );

      case DioExceptionType.connectionError:
        return ServerFailuer(
          message: 'No internet connection',
        );

      case DioExceptionType.badCertificate:
        return ServerFailuer(
          message: 'Bad certificate from server',
        );

      case DioExceptionType.unknown:
        return ServerFailuer(
          message: dioException.message ?? 'Unexpected error occurred',
        );
      case DioExceptionType.transformTimeout:
        return ServerFailuer(
          message: 'Transform timeout with server',
        );
    }
  }

  factory ServerFailuer.fromBadResponse({
    required int? statusCode,
    required dynamic data,
  }) {
    final message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return ServerFailuer(
          message: message ?? 'Bad request',
        );

      case 401:
        return ServerFailuer(
          message: message ?? 'Unauthorized',
        );

      case 403:
        return ServerFailuer(
          message: message ?? 'Forbidden',
        );

      case 404:
        return ServerFailuer(
          message: message ?? 'Resource not found',
        );

      case 405:
        return ServerFailuer(
          message: message ?? 'Method not allowed',
        );

      case 408:
        return ServerFailuer(
          message: message ?? 'Request timeout',
        );

      case 409:
        return ServerFailuer(
          message: message ?? 'Conflict occurred',
        );

      case 422:
        return ServerFailuer(
          message: message ?? 'Validation error',
        );

      case 429:
        return ServerFailuer(
          message: message ?? 'Too many requests',
        );

      case 500:
        return ServerFailuer(
          message: message ?? 'Internal server error',
        );

      case 502:
        return ServerFailuer(
          message: message ?? 'Bad gateway',
        );

      case 503:
        return ServerFailuer(
          message: message ?? 'Service unavailable',
        );

      case 504:
        return ServerFailuer(
          message: message ?? 'Gateway timeout',
        );

      default:
        return ServerFailuer(
          message: message ?? 'Something went wrong, please try later',
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is! Map<String, dynamic>) {
      return null;
    }

    // {
    //   "message": "Invalid credentials"
    // }
    if (data['message'] is String) {
      return data['message'];
    }

    // {
    //   "error": {
    //     "message": "Invalid credentials"
    //   }
    // }
    final error = data['error'];

    if (error is Map<String, dynamic> && error['message'] is String) {
      return error['message'];
    }

    return null;
  }
}