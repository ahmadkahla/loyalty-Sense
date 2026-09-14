// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'api_failure.dart';
//
// // ============================================================================
// // 🎯 USER REPO — إدارة عمليات المستخدم
// // ============================================================================
//
// class UserRepo {
//   UserRepo();
//
//   // ==========================================================
//   // ⚙️ CONFIG
//   // ==========================================================
//
//   static const String _baseUrl = 'http://185.80.24.159:150/api/values';
//
//   // 👈 عدّل هذا حسب ما تستخدمه في باقي مشروعك
//   static const String _basicAuth = 'Q0lUOkNJVEAxOTky';
//
//   Dio _getDio() {
//     return Dio(
//       BaseOptions(
//         baseUrl: _baseUrl,
//         connectTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic $_basicAuth',
//         },
//       ),
//     );
//   }
//
//   Future<String> _languageCode() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('language_code') ?? 'ar';
//   }
//
//   // ==========================================================
//   // 📥 GET USER INFO
//   // ==========================================================
//
//   Future<Result<Map<String, dynamic>?, Exception>> getUserInfo({
//     required String mobile,
//     required String countryCode,
//   }) async {
//     try {
//       final dio = _getDio();
//
//       final response = await dio.get(
//         '/GetInvPOSCustomersSearchByPhone',
//         queryParameters: {'Search': mobile, 'CountryCode': countryCode},
//       );
//
//       final data = response.data;
//
//       // List فيه عنصر
//       if (data is List && data.isNotEmpty && data.first is Map) {
//         return Success(Map<String, dynamic>.from(data.first));
//       }
//
//       // Map مباشر
//       if (data is Map) {
//         return Success(Map<String, dynamic>.from(data));
//       }
//
//       // فاضي / null
//       return const Success(null);
//     } on DioException catch (e) {
//       return Failure(
//         APIFailure(
//           message: e.message ?? 'Network error',
//           statusCode: e.response?.statusCode,
//         ),
//       );
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ==========================================================
//   // ✍️ REGISTER — إنشاء عميل جديد
//   // ==========================================================
//
//   Future<Result<bool, Exception>> register({
//     required String name,
//     required String mobile,
//     required String countryCode,
//     DateTime? birthdate,
//     String? email,
//     String? gender,
//     bool? receiveSMS,
//   }) async {
//     try {
//       final dio = _getDio();
//       final lang = await _languageCode();
//
//       final response = await dio.post(
//         '/PostInvPOSCustomers',
//         data: {
//           'TransCustomer': {
//             'Customer_Arabic_Name': name.trim(),
//             'Customer_Phone1': mobile,
//             if (gender != null) 'Customer_Gender': gender,
//             if (birthdate != null) 'Customer_Birthday': _formatDate(birthdate),
//             'Customer_ReciveSMS': receiveSMS ?? true,
//             if (email != null && email.trim().isNotEmpty)
//               'Customer_Email': email.trim(),
//             'Lang': lang,
//             'OperNo': 1,
//           },
//         },
//       );
//
//       final data = response.data;
//
//       if (data is num) {
//         return Success(data > 0);
//       }
//
//       if (data is Map && data['success'] == true) {
//         return const Success(true);
//       }
//
//       return const Success(false);
//     } on DioException catch (e) {
//       return Failure(
//         APIFailure(
//           message: e.message ?? 'Network error',
//           statusCode: e.response?.statusCode,
//           rawData: e.response?.data,
//         ),
//       );
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ==========================================================
//   // ✏️ UPDATE PROFILE
//   // ==========================================================
//
//   Future<Result<bool, Exception>> updateProfile({
//     required int id,
//     required String name,
//     required String mobile,
//     required String countryCode,
//     DateTime? birthdate,
//     String? email,
//     String? gender,
//     bool? receiveSMS,
//   }) async {
//     try {
//       final dio = _getDio();
//       final lang = await _languageCode();
//
//       final response = await dio.put(
//         '/PutInvPOSCustomers',
//         data: {
//           'TransCustomer': {
//             'Customer_No': id,
//             'Customer_Arabic_Name': name.trim(),
//             'Customer_Phone1': mobile,
//             if (gender != null) 'Customer_Gender': gender,
//             if (birthdate != null) 'Customer_Birthday': _formatDate(birthdate),
//             'Customer_ReciveSMS': receiveSMS ?? true,
//             if (email != null) 'Customer_Email': email,
//             'Lang': lang,
//             'OperNo': 1,
//           },
//         },
//       );
//
//       final data = response.data;
//
//       if (data is num) return Success(data > 0);
//       if (data is Map && data['success'] == true) return const Success(true);
//
//       return const Success(false);
//     } on DioException catch (e) {
//       return Failure(
//         APIFailure(
//           message: e.message ?? 'Network error',
//           statusCode: e.response?.statusCode,
//           rawData: e.response?.data,
//         ),
//       );
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ==========================================================
//   // 🛠 HELPERS
//   // ==========================================================
//
//   String _formatDate(DateTime date) {
//     final month = date.month.toString().padLeft(2, '0');
//     final day = date.day.toString().padLeft(2, '0');
//     final year = date.year;
//     return '$month-$day-$year';
//   }
// }
//
// // ============================================================================
// // 🎯 RESULT TYPE (إذا ما كان موجود عندك)
// // ============================================================================
//
// sealed class Result<T, E extends Exception> {
//   const Result();
//
//   R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure);
//
//   bool get isSuccess => this is Success<T, E>;
//   bool get isFailure => this is Failure<T, E>;
// }
//
// class Success<T, E extends Exception> extends Result<T, E> {
//   final T value;
//   const Success(this.value);
//
//   @override
//   R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure) {
//     return onSuccess(value);
//   }
// }
//
// class Failure<T, E extends Exception> extends Result<T, E> {
//   final E error;
//   const Failure(this.error);
//
//   @override
//   R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure) {
//     return onFailure(error);
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_failure.dart';

// ============================================================================
// 🎯 USER REPO — إدارة عمليات المستخدم
// ============================================================================

class UserRepo {
  UserRepo();

  // ==========================================================
  // ⚙️ CONFIG
  // ==========================================================

  static const String _baseUrl = 'http://185.80.24.159:150/api/values';

  // 👈 عدّل هذا حسب ما تستخدمه في باقي مشروعك
  static const String _basicAuth = 'Q0lUOkNJVEAxOTky';

  Dio _getDio() {
    return Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Basic $_basicAuth',
        },
      ),
    );
  }

  Future<String> _languageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_code') ?? 'ar';
  }

  // ==========================================================
  // 📥 GET USER INFO
  // ==========================================================

  Future<Result<Map<String, dynamic>?, Exception>> getUserInfo({
    required String mobile,
    required String countryCode,
  }) async {
    try {
      final dio = _getDio();

      final response = await dio.get(
        '/GetInvPOSCustomersSearchByPhone',
        queryParameters: {'Search': mobile, 'CountryCode': countryCode},
      );

      final data = response.data;

      // List فيه عنصر
      if (data is List && data.isNotEmpty && data.first is Map) {
        return Success(Map<String, dynamic>.from(data.first));
      }

      // Map مباشر
      if (data is Map) {
        return Success(Map<String, dynamic>.from(data));
      }

      // فاضي / null
      return const Success(null);
    } on DioException catch (e) {
      return Failure(
        APIFailure(
          message: e.message ?? 'Network error',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ==========================================================
  // ✍️ REGISTER — إنشاء عميل جديد
  // ==========================================================

  Future<Result<bool, Exception>> register({
    required String name,
    required String mobile,
    required String countryCode,
    DateTime? birthdate,
    String? email,
    String? gender,
    bool? receiveSMS,
  }) async {
    try {
      final dio = _getDio();
      final lang = await _languageCode();

      final body = {
        'TransCustomer': {
          'Customer_Arabic_Name': name.trim(),
          'Customer_Phone1': mobile,
          if (gender != null) 'Customer_Gender': gender,
          if (birthdate != null) 'Customer_Birthday': _formatDate(birthdate),
          'Customer_ReciveSMS': receiveSMS ?? true,
          if (email != null && email.trim().isNotEmpty)
            'Customer_Email': email.trim(),
          'Lang': lang,
          'OperNo': 1,
        },
      };

      // 🐛 DEBUG — الـ Request
      debugPrint('🌐 [register] URL: $_baseUrl/PostInvPOSCustomers');
      debugPrint('🌐 [register] BODY: $body');

      final response = await dio.post('/PostInvPOSCustomers', data: body);

      // 🐛 DEBUG — الـ Response
      debugPrint('📥 [register] statusCode: ${response.statusCode}');
      debugPrint('📥 [register] data: ${response.data}');
      debugPrint('📥 [register] data type: ${response.data.runtimeType}');

      final data = response.data;

      // ====================================================
      // 📌 معالجة كل أنواع الردود الممكنة
      // ====================================================

      // 1️⃣ رقم (مثلاً ID العميل الجديد)
      if (data is num) {
        final ok = data > 0;
        debugPrint('📥 [register] num response → $ok');
        return Success(ok);
      }

      // 2️⃣ نص (مثلاً "OK" أو "Error")
      if (data is String) {
        final ok =
            data.toLowerCase().contains('ok') ||
            data.toLowerCase().contains('success');
        debugPrint('📥 [register] string response → $ok');
        return Success(ok);
      }

      // 3️⃣ Map
      if (data is Map) {
        // success flag
        if (data['success'] == true) return const Success(true);
        if (data['success'] == false) return const Success(false);

        // ID / Customer_No
        if (data['Id'] != null && data['Id'] is num && data['Id'] > 0) {
          return const Success(true);
        }
        if (data['Customer_No'] != null &&
            data['Customer_No'] is num &&
            data['Customer_No'] > 0) {
          return const Success(true);
        }

        // إذا Map بس بدون رسالة خطأ → نعتبره نجاح
        return const Success(true);
      }

      // 4️⃣ List (نادراً)
      if (data is List && data.isNotEmpty) {
        return const Success(true);
      }

      return const Success(false);
    } on DioException catch (e) {
      debugPrint('🔴 [register] DioException: ${e.message}');
      debugPrint('🔴 [register] response: ${e.response?.data}');
      debugPrint('🔴 [register] statusCode: ${e.response?.statusCode}');

      return Failure(
        APIFailure(
          message: e.message ?? 'Network error',
          statusCode: e.response?.statusCode,
          rawData: e.response?.data,
        ),
      );
    } catch (e) {
      debugPrint('🔴 [register] Exception: $e');
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ==========================================================
  // ✏️ UPDATE PROFILE
  // ==========================================================

  Future<Result<bool, Exception>> updateProfile({
    required int id,
    required String name,
    required String mobile,
    required String countryCode,
    DateTime? birthdate,
    String? email,
    String? gender,
    bool? receiveSMS,
  }) async {
    try {
      final dio = _getDio();
      final lang = await _languageCode();

      final body = {
        'TransCustomer': {
          'Customer_No': id,
          'Customer_Arabic_Name': name.trim(),
          'Customer_Phone1': mobile,
          if (gender != null) 'Customer_Gender': gender,
          if (birthdate != null) 'Customer_Birthday': _formatDate(birthdate),
          'Customer_ReciveSMS': receiveSMS ?? true,
          if (email != null) 'Customer_Email': email,
          'Lang': lang,
          'OperNo': 1,
        },
      };

      debugPrint('🌐 [updateProfile] BODY: $body');

      final response = await dio.put('/PutInvPOSCustomers', data: body);

      debugPrint('📥 [updateProfile] statusCode: ${response.statusCode}');
      debugPrint('📥 [updateProfile] data: ${response.data}');

      final data = response.data;

      if (data is num) return Success(data > 0);
      if (data is Map && data['success'] == true) return const Success(true);

      return const Success(false);
    } on DioException catch (e) {
      return Failure(
        APIFailure(
          message: e.message ?? 'Network error',
          statusCode: e.response?.statusCode,
          rawData: e.response?.data,
        ),
      );
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ==========================================================
  // 🛠 HELPERS
  // ==========================================================

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year;
    return '$month-$day-$year';
  }
}

// ============================================================================
// 🎯 RESULT TYPE (إذا ما كان موجود عندك)
// ============================================================================

sealed class Result<T, E extends Exception> {
  const Result();

  R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure);

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;
}

class Success<T, E extends Exception> extends Result<T, E> {
  final T value;
  const Success(this.value);

  @override
  R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure) {
    return onSuccess(value);
  }
}

class Failure<T, E extends Exception> extends Result<T, E> {
  final E error;
  const Failure(this.error);

  @override
  R fold<R>(R Function(T value) onSuccess, R Function(E error) onFailure) {
    return onFailure(error);
  }
}
