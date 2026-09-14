import 'package:dio/dio.dart';

class APIFailure implements Exception {
  final String message;
  final int? statusCode;
  final dynamic rawData;

  const APIFailure({required this.message, this.statusCode, this.rawData});

  factory APIFailure.fromJson(Map<String, dynamic> json) {
    return APIFailure(
      message: (json['message'] ?? json['Message'] ?? 'Unknown error')
          .toString(),
      statusCode: json['statusCode'] ?? json['StatusCode'],
      rawData: json,
    );
  }

  factory APIFailure.fromDio(DioException e) {
    String msg = 'Network error';
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      msg = 'Connection timeout';
    } else if (e.type == DioExceptionType.badResponse) {
      msg = 'Server error (${e.response?.statusCode})';
    } else if (e.type == DioExceptionType.connectionError) {
      msg = 'No internet connection';
    }

    return APIFailure(
      message: msg,
      statusCode: e.response?.statusCode,
      rawData: e.response?.data,
    );
  }

  @override
  String toString() => message;
}
