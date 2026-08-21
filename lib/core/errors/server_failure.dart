import 'package:dio/dio.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';

class ServerFailuer extends Failure {
  ServerFailuer({required super.message});
  factory ServerFailuer.fromDioError({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuer(message: "Connection Timeout with Server");
      case DioExceptionType.sendTimeout:
        return ServerFailuer(message: "Send Timeout with Server");
      case DioExceptionType.receiveTimeout:
        return ServerFailuer(message: "Receive Timeout with Server");
      case DioExceptionType.badResponse:
        return ServerFailuer.fromBadResponse(
          statusCode: dioException.response!.statusCode!,
          data: dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailuer(message: "Request to Server was Cancelled");
      case DioExceptionType.connectionError:
        return ServerFailuer(message: "No Internet Connection");
      case DioExceptionType.badCertificate:
        return ServerFailuer(message: "Bad Certificate from Server");
      case DioExceptionType.unknown:
        return ServerFailuer(message: "Unexpected Error occurred");
      default:
        return ServerFailuer(message: "Something went wrong, Please try later!");  
    }
  }
  factory ServerFailuer.fromBadResponse({
    required int statusCode,
    required dynamic data,
  }) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailuer(message: data['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailuer(
        message: "Your request not found, Please try later!",
      );
    } else {
      return ServerFailuer(message: "Something went wrong, Please try later!");
    }
  }
}