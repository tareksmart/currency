import 'package:dio/dio.dart';

abstract class Failur {
  final String errorMessage;

  const Failur({required this.errorMessage});
}

class ServerFailur extends Failur {
  ServerFailur({required super.errorMessage});
  factory ServerFailur.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailur(errorMessage: 'connection time out with server');
      case DioExceptionType.badResponse:
        return ServerFailur(
            errorMessage: ServerFailur.badResponse(
                    dioException.response!.statusCode!, dioException.response)
                .errorMessage);
      case DioExceptionType.cancel:
        return ServerFailur(errorMessage: 'request is cancelled');
      default:
        return ServerFailur(
            errorMessage: 'Oops thre was an error please try again');
    }
  }
  factory ServerFailur.badResponse(int statusCode, dynamic response) {
    if (statusCode >= 400 && statusCode < 500 && statusCode != 401) {
      return ServerFailur(errorMessage: response['message']);
    } else if (statusCode == 401) {
      return ServerFailur(errorMessage: 'request not found');
    } else if (statusCode >= 500 && statusCode < 600) {
      return ServerFailur(
          errorMessage: 'Internal server error please try later');
    } else {
      return ServerFailur(
          errorMessage: 'Oops there is an error, Pleas try again');
    }
  }
}
