// import 'package:dio/dio.dart';
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
//   // GET USER BY ID
//   // ============================================================
//   // ⚠️ عدّل الـ endpoint والـ params حسب الـ API الحقيقي عندك
//   // ============================================================
//   Future<ApiResult<Map<String, dynamic>>> getUserById({
//     required String id,
//   }) async {
//     try {
//       final response = await _apiClient.dio.get(
//         '/GetCustomerById', // ← عدّل هذا
//         queryParameters: {
//           'Id': id, // ← عدّل هذا
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map<String, dynamic>) {
//         // لو الـ API بيرجع { "success": true, "data": {...} }
//         if (data.containsKey('success') && data['success'] == true) {
//           final userData = data['data'] ?? data;
//           if (userData is Map<String, dynamic>) {
//             return Success(userData);
//           }
//         }
//
//         // لو الـ API بيرجع الكائن مباشرة
//         return Success(data);
//       }
//
//       if (data is List && data.isNotEmpty && data.first is Map) {
//         return Success(Map<String, dynamic>.from(data.first));
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'Invalid user data',
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
// }

// import 'package:dio/dio.dart';
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
//   // GET USER BY PHONE (بدل getUserById)
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
//       // الـ API بيرجع List
//       if (data is List && data.isNotEmpty && data.first is Map) {
//         return Success(Map<String, dynamic>.from(data.first));
//       }
//
//       // لو رجع Map مباشرة (احتياط)
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
//   // GET USER BY ID
//   // ============================================================
//   // ⚠️ الـ API ما بيرجع مستخدم بالـ ID مباشرة.
//   // الحل: نستخدم GetInvPOSCustomersSearchByPhone بالـ mobile،
//   // بس نحن بدنا نجيب بالـ ID.
//   // جرّب هذا الـ endpoint (احتمال يكون موجود):
//   // ============================================================
//   Future<ApiResult<Map<String, dynamic>>> getUserById({
//     required String id,
//   }) async {
//     try {
//       final response = await _apiClient.dio.get(
//         '/GetInvPOSCustomersSearchById', // ← جرّب هذا (احتمالي)
//         queryParameters: {'Id': id},
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
//           message: 'No customer found with this ID',
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
// }

// import 'package:dio/dio.dart';
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
//   // GET USER BY PHONE ✅
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
//   // ✅ GET LOYALTY CARD (جديد)
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
// }

import 'package:dio/dio.dart';

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

      // السيرفر يرجّع رقم (عدد النقاط أو 1/0)
      if (data is num) {
        return Success(data > 0);
      }

      // إذا رجّع bool
      if (data is bool) {
        return Success(data);
      }

      // إذا رجّع Map فيه success
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
}
