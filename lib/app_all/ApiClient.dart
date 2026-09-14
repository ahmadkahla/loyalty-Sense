//
//
// import 'package:dio/dio.dart';
//
// class ApiClient {
//   static const String baseUrl = 'http://185.80.24.159:150/api/values';
//
//   late final Dio dio;
//
//   ApiClient() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         connectTimeout: const Duration(seconds: 15),
//         sendTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic Q0lUOkNJVEAxOTky', // ✅ أضف هذا السطر
//         },
//       ),
//     );
//
//     dio.interceptors.add(
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//     );
//   }
// }

// import 'package:dio/dio.dart';
//
// class ApiClient {
//   static const String baseUrl = 'http://185.80.24.159:150/api/values';
//
//   late final Dio dio;
//
//   ApiClient() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         connectTimeout: const Duration(seconds: 15),
//         sendTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic Q0lUOkNJVEAxOTky',
//         },
//       ),
//     );
//
//     // 1) LogInterceptor الأصلي
//     dio.interceptors.add(
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//     );
//
//     // 2) Interceptor لطباعة cURL في سطر واحد
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           final buffer = StringBuffer();
//           buffer.write("curl --location '${options.uri}'");
//
//           // إضافة الهيدرز في نفس السطر
//           options.headers.forEach((key, value) {
//             buffer.write(" --header '$key: $value'");
//           });
//
//           // إضافة البيانات إذا كان الطلب POST/PUT (في نفس السطر)
//           if (options.data != null) {
//             buffer.write(" --data '${options.data}'");
//           }
//
//           print('*** cURL ***');
//           print(buffer.toString());
//           print('');
//
//           return handler.next(options);
//         },
//       ),
//     );
//   }
// }

// import 'package:dio/dio.dart';
//
// class ApiClient {
//   static const String baseUrl = 'http://185.80.24.159:150/api/values';
//
//   late final Dio dio;
//
//   ApiClient() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         connectTimeout: const Duration(seconds: 15),
//         sendTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic Q0lUOkNJVEAxOTky',
//         },
//       ),
//     );
//
//     // 1) LogInterceptor الأصلي
//     dio.interceptors.add(
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//     );
//
//     // 2) Interceptor لطباعة cURL بشكل منسق (مثل Chrome DevTools)
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           final buffer = StringBuffer();
//
//           // السطر الأول: curl -i \
//           buffer.write("curl -i \\\n");
//
//           // إضافة الهيدرز بتنسيق -H "Key: Value" \
//           options.headers.forEach((key, value) {
//             buffer.write("\t-H \"$key: $value\" \\\n");
//           });
//
//           // السطر الأخير: الرابط بين علامتي تنصيص
//           buffer.write("\t\"${options.uri}\"");
//
//           print('*** cURL ***');
//           print(buffer.toString());
//           print('');
//
//           return handler.next(options);
//         },
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl = 'http://185.80.24.159:150/api/values';

  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Basic Q0lUOkNJVEAxOTky',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final buffer = StringBuffer();
          buffer.write("curl -i \\\n");
          options.headers.forEach((key, value) {
            buffer.write("\t-H \"$key: $value\" \\\n");
          });
          buffer.write("\t\"${options.uri}\"");
          print('*** cURL ***');
          print(buffer.toString());
          print('');
          return handler.next(options);
        },
      ),
    );
  }

  // ============================================================
  // ✅ HELPERS (بدائل BaseRepo)
  // ============================================================

  Future<Response> getRequest({
    required String path,
    Map<String, dynamic>? queryParams,
  }) => dio.get(path, queryParameters: queryParams);

  Future<Response> postRequest({
    required String path,
    Map<String, dynamic>? body,
  }) => dio.post(path, data: body);

  Future<Response> putRequest({
    required String path,
    Map<String, dynamic>? body,
  }) => dio.put(path, data: body);

  bool isOk(Response response) =>
      response.statusCode != null &&
      response.statusCode! >= 200 &&
      response.statusCode! < 300;

  dynamic decodeResponse(Response response) => response.data;

  List<T> parseList<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (json is List) {
      return json
          .whereType<Map>()
          .map((e) => fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}
