// import 'package:dio/dio.dart';
//
// import 'ApiClient.dart';
//
// abstract class BaseRepo {
//   final Dio client = ApiClient().dio;
//
//   Future<Response<dynamic>> getRequest({
//     required String path,
//     Map<String, dynamic> queryParams = const {},
//   }) async {
//     return await client.get(_fixPath(path), queryParameters: queryParams);
//   }
//
//   Future<Response<dynamic>> postRequest({
//     required String path,
//     Map<String, dynamic> queryParams = const {},
//     dynamic body,
//   }) async {
//     return await client.post(
//       _fixPath(path),
//       queryParameters: queryParams,
//       data: body,
//     );
//   }
//
//   bool isOk(Response<dynamic>? response) {
//     final statusCode = response?.statusCode ?? 400;
//     return statusCode >= 200 && statusCode <= 299;
//   }
//
//   dynamic decodeResponse(Response<dynamic>? response) {
//     return response?.data;
//   }
//
//   List<T> parseList<T>(dynamic data, T Function(Map<String, dynamic>) mapper) {
//     final result = <T>[];
//
//     if (data == null) {
//       return result;
//     }
//
//     if (data is! List) {
//       return result;
//     }
//
//     for (final item in data) {
//       if (item is! Map) {
//         continue;
//       }
//
//       try {
//         result.add(mapper(Map<String, dynamic>.from(item)));
//       } catch (e) {
//         print('Parsing error: $e');
//         print('JSON: $item');
//       }
//     }
//
//     return result;
//   }
//
//   String _fixPath(String path) {
//     if (path.startsWith('/')) {
//       return path;
//     }
//
//     return '/$path';
//   }
// }

import 'package:dio/dio.dart';

import 'ApiClient.dart';

class BaseRepo {
  final ApiClient _apiClient = ApiClient();

  Future<Response> getRequest({
    required String path,
    Map<String, dynamic>? queryParams,
  }) => _apiClient.getRequest(path: path, queryParams: queryParams);

  Future<Response> postRequest({
    required String path,
    Map<String, dynamic>? body,
  }) => _apiClient.postRequest(path: path, body: body);

  Future<Response> putRequest({
    required String path,
    Map<String, dynamic>? body,
  }) => _apiClient.putRequest(path: path, body: body);

  bool isOk(Response response) => _apiClient.isOk(response);

  dynamic decodeResponse(Response response) =>
      _apiClient.decodeResponse(response);

  List<T> parseList<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) => _apiClient.parseList(json, fromJson);
}
