// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'ApiClient.dart';
// import 'ApiResul.dart';
// import 'api_failure.dart';
//
// class AuthRepo {
//   final ApiClient _apiClient;
//
//   AuthRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();
//
//   // ============================================================
//   // SEND OTP
//   // ============================================================
//   Future<ApiResult<bool>> sendOTP({
//     required String mobile,
//     required String countryCode,
//     String lang = 'ar',
//   }) async {
//     try {
//       final response = await _apiClient.dio.post(
//         '/PostERPOTP',
//         data: {
//           'Id': 1,
//           'PhoneNumber': mobile,
//           'CountryCode': countryCode,
//           'OTPCode': 0,
//           'ExpiryDate': '01-01-2026 00:00:00',
//           'IsUsed': false,
//           'CreatedDate': '01-01-2026 00:00:00',
//           'Lang': lang,
//           'OperNo': 1,
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map && data['success'] == true) {
//         return const Success(true);
//       }
//
//       return Failure(
//         APIFailure(
//           message:
//               (data is Map
//                       ? (data['message'] ??
//                             data['Message'] ??
//                             'Failed to send OTP')
//                       : 'Failed to send OTP')
//                   .toString(),
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // GET USER BY PHONE
//   // ============================================================
//   Future<ApiResult<Map<String, dynamic>>> getUserByPhone({
//     required String mobile,
//     required String countryCode,
//   }) async {
//     try {
//       final response = await _apiClient.dio.get(
//         '/GetInvPOSCustomersSearchByPhone',
//         queryParameters: {'Search': mobile, 'CountryCode': countryCode},
//       );
//
//       final data = response.data;
//
//       if (data is List && data.isNotEmpty && data.first is Map) {
//         return Success(Map<String, dynamic>.from(data.first));
//       }
//
//       if (data is Map<String, dynamic>) {
//         return Success(data);
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'No customer found with this phone number',
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // ✍️ REGISTER — إنشاء عميل جديد
//   // ============================================================
//   Future<ApiResult<bool>> register({
//     required String name,
//     required String mobile,
//     required String countryCode,
//     DateTime? birthdate,
//     String? email,
//     String? gender,
//     bool? receiveSMS,
//   }) async {
//     try {
//       final response = await _apiClient.dio.post(
//         '/PostInvPOSCustomers',
//         data: {
//           'TransCustomer': {
//             'Customer_Arabic_Name': name.trim(),
//             'Customer_Phone1': mobile,
//             if (gender != null) 'Customer_Gender': gender,
//             if (birthdate != null)
//               'Customer_Birthday': _formatBackendDate(birthdate),
//             'Customer_ReciveSMS': receiveSMS ?? true,
//             if (email != null && email.trim().isNotEmpty)
//               'Customer_Email': email.trim(),
//             // 👈 مهم: Lang هنا int مو String (حسب الـ API)
//             'Lang': 1,
//             'OperNo': 1,
//           },
//         },
//       );
//
//       final data = response.data;
//
//       debugPrint('📥 [register] statusCode: ${response.statusCode}');
//       debugPrint('📥 [register] data: $data');
//       debugPrint('📥 [register] data type: ${data.runtimeType}');
//
//       // 1️⃣ رقم (ID العميل الجديد)
//       if (data is num) {
//         return Success(data > 0);
//       }
//
//       // 2️⃣ Map فيه success
//       if (data is Map && data['success'] is bool) {
//         return Success(data['success'] as bool);
//       }
//
//       // 3️⃣ Map فيه Id أو Customer_No
//       if (data is Map) {
//         final id = data['Id'] ?? data['Customer_No'] ?? data['CustomerNo'];
//         if (id is num && id > 0) return const Success(true);
//       }
//
//       // 4️⃣ نص
//       if (data is String) {
//         final lower = data.toLowerCase();
//         return Success(lower.contains('ok') || lower.contains('success'));
//       }
//
//       return const Success(false);
//     } on DioException catch (e) {
//       debugPrint('🔴 [register] DioException: ${e.message}');
//       debugPrint('🔴 [register] response: ${e.response?.data}');
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       debugPrint('🔴 [register] Exception: $e');
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // ✏️ UPDATE PROFILE
//   // ============================================================
//   Future<ApiResult<bool>> updateProfile({
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
//       final response = await _apiClient.dio.put(
//         '/PutInvPOSCustomers',
//         data: {
//           'TransCustomer': {
//             'Customer_No': id,
//             'Customer_Arabic_Name': name.trim(),
//             'Customer_Phone1': mobile,
//             if (gender != null) 'Customer_Gender': gender,
//             if (birthdate != null)
//               'Customer_Birthday': _formatBackendDate(birthdate),
//             'Customer_ReciveSMS': receiveSMS ?? true,
//             if (email != null) 'Customer_Email': email,
//             'Lang': 1,
//             'OperNo': 1,
//           },
//         },
//       );
//
//       final data = response.data;
//
//       debugPrint('📥 [updateProfile] statusCode: ${response.statusCode}');
//       debugPrint('📥 [updateProfile] data: $data');
//
//       if (data is num) return Success(data > 0);
//       if (data is Map && data['success'] == true) return const Success(true);
//
//       return const Success(false);
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // GET LOYALTY CARD
//   // ============================================================
//   Future<ApiResult<Map<String, dynamic>>> getLoyaltyCard({
//     required String customerNo,
//   }) async {
//     try {
//       final response = await _apiClient.dio.get(
//         '/GetLoyaltyCardsByCustomerNo',
//         queryParameters: {'Loyalty_Customer_No': customerNo},
//       );
//
//       final data = response.data;
//
//       if (data is List && data.isNotEmpty && data.first is Map) {
//         return Success(Map<String, dynamic>.from(data.first));
//       }
//
//       if (data is Map<String, dynamic>) {
//         return Success(data);
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'No loyalty card found',
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // 🎁 REDEEM EXTRA POINTS (Daily Reward)
//   // ============================================================
//   Future<ApiResult<bool>> redeemExtraPoints({
//     required String customerNo,
//     required String pointsId,
//   }) async {
//     try {
//       final response = await _apiClient.dio.post(
//         '/PostDailyReward',
//         data: {
//           'BodyParam': {
//             'Loyalty_Customer_No': customerNo,
//             'Trans_Type': pointsId,
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
//       if (data is bool) {
//         return Success(data);
//       }
//
//       if (data is Map && data['success'] is bool) {
//         return Success(data['success'] as bool);
//       }
//
//       return const Success(false);
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
//
//   // ============================================================
//   // 🛠 HELPER — Format Date للـ Backend
//   // ============================================================
//   String _formatBackendDate(DateTime date) {
//     final month = date.month.toString().padLeft(2, '0');
//     final day = date.day.toString().padLeft(2, '0');
//     final year = date.year;
//     return '$month-$day-$year';
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'ApiClient.dart';
import 'ApiResul.dart';
import 'api_failure.dart';

class AuthRepo {
  final ApiClient _apiClient;

  AuthRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  // ============================================================
  // SEND OTP
  // ============================================================
  Future<ApiResult<bool>> sendOTP({
    required String mobile,
    required String countryCode,
    String lang = 'ar',
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/PostERPOTP',
        data: {
          'Id': 1,
          'PhoneNumber': mobile,
          'CountryCode': countryCode,
          'OTPCode': 0,
          'ExpiryDate': '01-01-2026 00:00:00',
          'IsUsed': false,
          'CreatedDate': '01-01-2026 00:00:00',
          'Lang': lang,
          'OperNo': 1,
        },
      );

      final data = response.data;

      if (data is Map && data['success'] == true) {
        return const Success(true);
      }

      return Failure(
        APIFailure(
          message:
              (data is Map
                      ? (data['message'] ??
                            data['Message'] ??
                            'Failed to send OTP')
                      : 'Failed to send OTP')
                  .toString(),
          statusCode: response.statusCode,
          rawData: data,
        ),
      );
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // GET USER BY PHONE
  // ============================================================
  Future<ApiResult<Map<String, dynamic>>> getUserByPhone({
    required String mobile,
    required String countryCode,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/GetInvPOSCustomersSearchByPhone',
        queryParameters: {'Search': mobile, 'CountryCode': countryCode},
      );

      final data = response.data;

      if (data is List && data.isNotEmpty && data.first is Map) {
        return Success(Map<String, dynamic>.from(data.first));
      }

      if (data is Map<String, dynamic>) {
        return Success(data);
      }

      return Failure(
        APIFailure(
          message: 'No customer found with this phone number',
          statusCode: response.statusCode,
          rawData: data,
        ),
      );
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // ✍️ REGISTER — إنشاء عميل جديد
  // ============================================================
  Future<ApiResult<bool>> register({
    required String name,
    required String mobile,
    required String countryCode,
    DateTime? birthdate,
    String? email,
    String? gender,
    bool? receiveSMS,
  }) async {
    try {
      // 🧹 إذا الإيميل فاضي → "" (نص فاضي، مو null)
      final cleanEmail = (email == null || email.trim().isEmpty)
          ? ''
          : email.trim();

      final body = {
        'TransCustomer': {
          'Customer_Arabic_Name': name.trim(),
          'Customer_Phone1': mobile,
          if (gender != null) 'Customer_Gender': gender,
          if (birthdate != null)
            'Customer_Birthday': _formatBackendDate(birthdate),
          'Customer_ReciveSMS': receiveSMS ?? true,
          'Customer_Email': cleanEmail,
          'Lang': 1,
          'OperNo': 1,
        },
      };

      debugPrint('🌐 [register] BODY: $body');

      final response = await _apiClient.dio.post(
        '/PostInvPOSCustomers',
        data: body,
      );

      final data = response.data;

      debugPrint('📥 [register] statusCode: ${response.statusCode}');
      debugPrint('📥 [register] data: $data');
      debugPrint('📥 [register] data type: ${data.runtimeType}');

      // 1️⃣ رقم (ID العميل الجديد)
      if (data is num) {
        return Success(data > 0);
      }

      // 2️⃣ Map
      if (data is Map) {
        if (data['success'] == false) {
          return Failure(
            APIFailure(
              message:
                  (data['message'] ??
                          data['Message'] ??
                          'Failed to create your profile')
                      .toString(),
              statusCode: response.statusCode,
              rawData: data,
            ),
          );
        }

        if (data['success'] == true) return const Success(true);

        final id = data['Id'] ?? data['Customer_No'] ?? data['CustomerNo'];
        if (id is num && id > 0) return const Success(true);
      }

      // 3️⃣ نص
      if (data is String) {
        final lower = data.toLowerCase();
        if (lower.contains('ok') || lower.contains('success')) {
          return const Success(true);
        }
        return Failure(
          APIFailure(
            message: data,
            statusCode: response.statusCode,
            rawData: data,
          ),
        );
      }

      return Failure(
        APIFailure(
          message: 'Failed to create your profile',
          statusCode: response.statusCode,
          rawData: data,
        ),
      );
    } on DioException catch (e) {
      debugPrint('🔴 [register] DioException: ${e.message}');
      debugPrint('🔴 [register] response: ${e.response?.data}');
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      debugPrint('🔴 [register] Exception: $e');
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // ✏️ UPDATE PROFILE
  // ============================================================
  Future<ApiResult<bool>> updateProfile({
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
      final cleanEmail = (email == null || email.trim().isEmpty)
          ? ''
          : email.trim();

      final body = {
        'TransCustomer': {
          'Customer_No': id,
          'Customer_Arabic_Name': name.trim(),
          'Customer_Phone1': mobile,
          if (gender != null) 'Customer_Gender': gender,
          if (birthdate != null)
            'Customer_Birthday': _formatBackendDate(birthdate),
          'Customer_ReciveSMS': receiveSMS ?? true,
          'Customer_Email': cleanEmail,
          'Lang': 1,
          'OperNo': 1,
        },
      };

      debugPrint('🌐 [updateProfile] BODY: $body');

      final response = await _apiClient.dio.put(
        '/PutInvPOSCustomers',
        data: body,
      );

      final data = response.data;

      debugPrint('📥 [updateProfile] statusCode: ${response.statusCode}');
      debugPrint('📥 [updateProfile] data: $data');

      if (data is num) return Success(data > 0);

      if (data is Map) {
        if (data['success'] == false) {
          return Failure(
            APIFailure(
              message:
                  (data['message'] ??
                          data['Message'] ??
                          'Failed to update profile')
                      .toString(),
              statusCode: response.statusCode,
              rawData: data,
            ),
          );
        }
        if (data['success'] == true) return const Success(true);
      }

      return const Success(false);
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // GET LOYALTY CARD
  // ============================================================
  Future<ApiResult<Map<String, dynamic>>> getLoyaltyCard({
    required String customerNo,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/GetLoyaltyCardsByCustomerNo',
        queryParameters: {'Loyalty_Customer_No': customerNo},
      );

      final data = response.data;

      if (data is List && data.isNotEmpty && data.first is Map) {
        return Success(Map<String, dynamic>.from(data.first));
      }

      if (data is Map<String, dynamic>) {
        return Success(data);
      }

      return Failure(
        APIFailure(
          message: 'No loyalty card found',
          statusCode: response.statusCode,
          rawData: data,
        ),
      );
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // 🎁 REDEEM EXTRA POINTS (Daily Reward)
  // ============================================================
  Future<ApiResult<bool>> redeemExtraPoints({
    required String customerNo,
    required String pointsId,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/PostDailyReward',
        data: {
          'BodyParam': {
            'Loyalty_Customer_No': customerNo,
            'Trans_Type': pointsId,
          },
        },
      );

      final data = response.data;

      if (data is num) {
        return Success(data > 0);
      }

      if (data is bool) {
        return Success(data);
      }

      if (data is Map && data['success'] is bool) {
        return Success(data['success'] as bool);
      }

      return const Success(false);
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // 🛠 HELPER — Format Date للـ Backend
  // ============================================================
  String _formatBackendDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final year = date.year;
    return '$month-$day-$year';
  }
}
