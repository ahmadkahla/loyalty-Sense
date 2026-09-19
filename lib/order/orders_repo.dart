// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../app_all/ApiClient.dart';
// import 'order.dart';
// import 'order_details.dart';
// import 'order_item.dart';
//
// class OrdersRepo {
//   OrdersRepo();
//
//   // ✅ ApiClient واحد فقط لكل الـ requests
//   static final ApiClient _client = ApiClient();
//
//   // ✅ userId ديناميكي
//   Future<String> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('Customer_No') ?? '';
//   }
//
//   // ============================================================
//   // fetchOrderDetails ⭐
//   // ============================================================
//   Future<Result<OrderDetails, Exception>> fetchOrderDetails(
//     final int orderId,
//   ) async {
//     if (orderId <= 0) return Failure(Exception('Invalid order id'));
//
//     try {
//       final userId = await _getUserId();
//
//       final responses = await Future.wait([
//         _client.dio.get(
//           '/GetInvPOSTransactionsCallCenterOrderHistory',
//           queryParameters: {
//             'Customer_No': userId,
//             'TransId': orderId,
//             'TransStatus': -999,
//           },
//         ),
//         _client.dio.get(
//           '/GetInvPOSTransactionsDetailsCallCenterParam',
//           queryParameters: {'TransId': orderId},
//         ),
//       ]);
//
//       final headerJson = responses[0].data;
//       final detailsJson = responses[1].data;
//
//       // معالجة details
//       final List<Map<String, dynamic>> rows;
//       if (detailsJson is List) {
//         rows = detailsJson
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else if (detailsJson is Map && detailsJson['data'] is List) {
//         rows = (detailsJson['data'] as List)
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else {
//         rows = <Map<String, dynamic>>[];
//       }
//
//       if (rows.isEmpty) {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       final items = OrderItem.collectParents(rows);
//
//       // معالجة header
//       final Map<String, dynamic> headerMap;
//       if (headerJson is List) {
//         headerMap = headerJson.isNotEmpty
//             ? Map<String, dynamic>.from(headerJson.first as Map)
//             : <String, dynamic>{};
//       } else if (headerJson is Map && headerJson['data'] is List) {
//         final list = headerJson['data'] as List;
//         headerMap = list.isNotEmpty
//             ? Map<String, dynamic>.from(list.first as Map)
//             : <String, dynamic>{};
//       } else if (headerJson is Map) {
//         headerMap = Map<String, dynamic>.from(headerJson);
//       } else {
//         headerMap = <String, dynamic>{};
//       }
//
//       return Success(
//         OrderDetails(order: Order.fromJson(headerMap), items: items),
//       );
//     } on DioException catch (e) {
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
//
//   // ============================================================
//   // fetchOrders
//   // ============================================================
//   Future<Result<List<Order>, Exception>> fetchOrders() async {
//     try {
//       final userId = await _getUserId();
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': -999,
//           'TransStatus': -999,
//         },
//       );
//
//       final data = response.data;
//       final List<Map<String, dynamic>> rows;
//       if (data is List) {
//         rows = data
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else if (data is Map && data['data'] is List) {
//         rows = (data['data'] as List)
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else {
//         rows = [];
//       }
//
//       return Success(rows.map(Order.fromJson).toList());
//     } on DioException catch (e) {
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
// }
//
// // ============================================================
// // Result / Success / Failure
// // ============================================================
// sealed class Result<T, E extends Exception> {
//   const Result();
// }
//
// class Success<T, E extends Exception> extends Result<T, E> {
//   final T data;
//   const Success(this.data);
// }
//
// class Failure<T, E extends Exception> extends Result<T, E> {
//   final E error;
//   const Failure(this.error);
// }

// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../app_all/ApiClient.dart';
// import 'order.dart';
//
// class OrdersRepo {
//   OrdersRepo();
//
//   static final ApiClient _client = ApiClient();
//
//   // ============================================================
//   // ✅ userId من SharedPreferences
//   // ============================================================
//   Future<String> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     return prefs.getString('user_customer_no') ??
//         prefs.getString('user_Customer_No') ??
//         prefs.getString('user_id') ??
//         prefs.getString('Customer_No') ??
//         '';
//   }
//
//   // ============================================================
//   // ✅ fetchOrders — يجيب كل الأوردرات (فواتير + مرتجعات)
//   // ============================================================
//   Future<Result<List<Order>, Exception>> fetchOrders({
//     final bool? isCompleted,
//   }) async {
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': -999,
//           'TransStatus': isCompleted == true ? '-999' : '3',
//         },
//       );
//
//       final data = response.data;
//
//       final List<Map<String, dynamic>> rows;
//       if (data is List) {
//         rows = data
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else if (data is Map && data['data'] is List) {
//         rows = (data['data'] as List)
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else {
//         rows = <Map<String, dynamic>>[];
//       }
//
//       return Success(rows.map(Order.fromJson).toList());
//     } on DioException catch (e) {
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
//
//   // ============================================================
//   // ✅ fetchOrderDetails — يجيب تفاصيل أوردر واحد
//   // ============================================================
//   Future<Result<Order, Exception>> fetchOrderDetails(final int orderId) async {
//     if (orderId <= 0) return Failure(Exception('Invalid order id'));
//
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': orderId,
//           'TransStatus': -999,
//         },
//       );
//
//       final data = response.data;
//
//       final Map<String, dynamic> headerMap;
//       if (data is List && data.isNotEmpty) {
//         headerMap = Map<String, dynamic>.from(data.first as Map);
//       } else if (data is Map<String, dynamic>) {
//         headerMap = data;
//       } else {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       return Success(Order.fromJson(headerMap));
//     } on DioException catch (e) {
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
// }
//
// // ============================================================
// // Result / Success / Failure
// // ============================================================
// sealed class Result<T, E extends Exception> {
//   const Result();
// }
//
// class Success<T, E extends Exception> extends Result<T, E> {
//   final T data;
//   const Success(this.data);
// }
//
// class Failure<T, E extends Exception> extends Result<T, E> {
//   final E error;
//   const Failure(this.error);
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart'; // ← أضف هاد
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../app_all/ApiClient.dart';
// import 'order.dart';
//
// class OrdersRepo {
//   OrdersRepo();
//
//   static final ApiClient _client = ApiClient();
//
//   Future<String> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final userId =
//         prefs.getString('user_customer_no') ??
//         prefs.getString('user_Customer_No') ??
//         prefs.getString('user_id') ??
//         prefs.getString('Customer_No') ??
//         '';
//
//     debugPrint('👤 [OrdersRepo] userId = "$userId"');
//     return userId;
//   }
//
//   Future<Result<List<Order>, Exception>> fetchOrders({
//     final bool? isCompleted,
//   }) async {
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       // ✅ غيّر هاد السطر — خليها دايماً -999
//       const transStatus = '-999';
//
//       debugPrint('🌐 [fetchOrders] Requesting with:');
//       debugPrint('   Customer_No = $userId');
//       debugPrint('   TransId     = -999');
//       debugPrint('   TransStatus = $transStatus');
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': -999,
//           'TransStatus': transStatus,
//         },
//       );
//
//       debugPrint('📊 [fetchOrders] Status: ${response.statusCode}');
//       debugPrint('📦 [fetchOrders] Data: ${response.data}');
//
//       // ✅ لو الـ API رجّع null → قائمة فاضية
//       if (response.data == null) {
//         debugPrint('⚠️ [fetchOrders] API returned NULL — no orders');
//         return const Success([]);
//       }
//
//       final data = response.data;
//
//       final List<Map<String, dynamic>> rows;
//       if (data is List) {
//         rows = data
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else if (data is Map && data['data'] is List) {
//         rows = (data['data'] as List)
//             .whereType<Map>()
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList();
//       } else {
//         rows = <Map<String, dynamic>>[];
//       }
//
//       debugPrint('✅ [fetchOrders] Parsed ${rows.length} orders');
//
//       return Success(rows.map(Order.fromJson).toList());
//     } on DioException catch (e) {
//       debugPrint('❌ [fetchOrders] DioException: ${e.message}');
//       debugPrint('   Response: ${e.response?.data}');
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       debugPrint('❌ [fetchOrders] Error: $e');
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
//
//   Future<Result<Order, Exception>> fetchOrderDetails(final int orderId) async {
//     if (orderId <= 0) return Failure(Exception('Invalid order id'));
//
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       debugPrint('🌐 [fetchOrderDetails] Requesting order: $orderId');
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': orderId,
//           'TransStatus': -999,
//         },
//       );
//
//       debugPrint('📊 [fetchOrderDetails] Status: ${response.statusCode}');
//       debugPrint('📦 [fetchOrderDetails] Data: ${response.data}');
//
//       if (response.data == null) {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       final data = response.data;
//
//       final Map<String, dynamic> headerMap;
//       if (data is List && data.isNotEmpty) {
//         headerMap = Map<String, dynamic>.from(data.first as Map);
//       } else if (data is Map) {
//         headerMap = Map<String, dynamic>.from(data);
//       } else {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       return Success(Order.fromJson(headerMap));
//     } on DioException catch (e) {
//       debugPrint('❌ [fetchOrderDetails] DioException: ${e.message}');
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       debugPrint('❌ [fetchOrderDetails] Error: $e');
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
// }
//
// // ============================================================
// // Result / Success / Failure
// // ============================================================
// sealed class Result<T, E extends Exception> {
//   const Result();
// }
//
// class Success<T, E extends Exception> extends Result<T, E> {
//   final T data;
//   const Success(this.data);
// }
//
// class Failure<T, E extends Exception> extends Result<T, E> {
//   final E error;
//   const Failure(this.error);
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../app_all/ApiClient.dart';
// import 'order.dart';
//
// class OrdersRepo {
//   OrdersRepo();
//
//   static final ApiClient _client = ApiClient();
//
//   // ============================================================
//   // ✅ userId من SharedPreferences
//   // ============================================================
//   Future<String> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final userId =
//         prefs.getString('user_customer_no') ??
//         prefs.getString('user_Customer_No') ??
//         prefs.getString('user_id') ??
//         prefs.getString('Customer_No') ??
//         '';
//
//     debugPrint('👤 [OrdersRepo] userId = "$userId"');
//     return userId;
//   }
//
//   // ============================================================
//   // ✅ fetchOrders — يجيب كل الأوردرات (فواتير + مرتجعات)
//   // ============================================================
//   Future<Result<List<Order>, Exception>> fetchOrders() async {
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       debugPrint('🌐 [fetchOrders] Requesting orders for: $userId');
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': -999,
//           'TransStatus': -999,
//         },
//       );
//
//       debugPrint('📊 [fetchOrders] Status: ${response.statusCode}');
//       debugPrint('📦 [fetchOrders] Data: ${response.data}');
//
//       // ✅ لو الـ API رجّع null → قائمة فاضية
//       if (response.data == null) {
//         debugPrint('⚠️ [fetchOrders] API returned NULL — no orders');
//         return const Success([]);
//       }
//
//       final rows = _extractRows(response.data);
//
//       debugPrint('✅ [fetchOrders] Parsed ${rows.length} orders');
//
//       return Success(rows.map(Order.fromJson).toList());
//     } on DioException catch (e) {
//       debugPrint('❌ [fetchOrders] DioException: ${e.message}');
//       debugPrint('   Response: ${e.response?.data}');
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       debugPrint('❌ [fetchOrders] Error: $e');
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
//
//   // ============================================================
//   // ✅ fetchOrderDetails — يجيب تفاصيل أوردر واحد
//   // ============================================================
//   Future<Result<Order, Exception>> fetchOrderDetails(final int orderId) async {
//     if (orderId <= 0) return Failure(Exception('Invalid order id'));
//
//     try {
//       final userId = await _getUserId();
//
//       if (userId.isEmpty) {
//         return Failure(Exception('No customer ID found'));
//       }
//
//       debugPrint('🌐 [fetchOrderDetails] Requesting order: $orderId');
//
//       final response = await _client.dio.get(
//         '/GetInvPOSTransactionsCallCenterOrderHistory',
//         queryParameters: {
//           'Customer_No': userId,
//           'TransId': orderId,
//           'TransStatus': -999,
//         },
//       );
//
//       debugPrint('📊 [fetchOrderDetails] Status: ${response.statusCode}');
//       debugPrint('📦 [fetchOrderDetails] Data: ${response.data}');
//
//       if (response.data == null) {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       final data = response.data;
//
//       final Map<String, dynamic> headerMap;
//       if (data is List && data.isNotEmpty) {
//         headerMap = Map<String, dynamic>.from(data.first as Map);
//       } else if (data is Map) {
//         headerMap = Map<String, dynamic>.from(data);
//       } else {
//         return Failure(Exception('No details found for order $orderId'));
//       }
//
//       return Success(Order.fromJson(headerMap));
//     } on DioException catch (e) {
//       debugPrint('❌ [fetchOrderDetails] DioException: ${e.message}');
//       return Failure(Exception('Network error: ${e.message}'));
//     } catch (e) {
//       debugPrint('❌ [fetchOrderDetails] Error: $e');
//       return Failure(e is Exception ? e : Exception(e.toString()));
//     }
//   }
//
//   // ============================================================
//   // ✅ Helper — استخراج rows من أي شكل response
//   // ============================================================
//   List<Map<String, dynamic>> _extractRows(dynamic data) {
//     if (data == null) return [];
//
//     // 1. List مباشرة
//     if (data is List) {
//       return data
//           .whereType<Map>()
//           .map((e) => Map<String, dynamic>.from(e))
//           .toList();
//     }
//
//     // 2. Map
//     if (data is Map) {
//       for (final key in ['data', 'result', 'items', 'orders', 'Data']) {
//         final value = data[key];
//         if (value is List) {
//           return value
//               .whereType<Map>()
//               .map((e) => Map<String, dynamic>.from(e))
//               .toList();
//         }
//       }
//
//       // 3. Map مباشرة (أوردر واحد)
//       if (data.containsKey('Trans_ID') || data.containsKey('Trans_OrderNo')) {
//         return [Map<String, dynamic>.from(data)];
//       }
//     }
//
//     return [];
//   }
// }
//
// // ============================================================
// // Result / Success / Failure
// // ============================================================
// sealed class Result<T, E extends Exception> {
//   const Result();
//
//   R fold<R>(R Function(T data) onSuccess, R Function(E error) onFailure) {
//     final self = this;
//     if (self is Success<T, E>) {
//       return onSuccess(self.data);
//     } else if (self is Failure<T, E>) {
//       return onFailure(self.error);
//     }
//     throw StateError('Unknown Result type: $self');
//   }
// }
//
// class Success<T, E extends Exception> extends Result<T, E> {
//   final T data;
//   const Success(this.data);
// }
//
// class Failure<T, E extends Exception> extends Result<T, E> {
//   final E error;
//   const Failure(this.error);
// }

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app_all/ApiClient.dart';
import 'order.dart';

class OrdersRepo {
  final String customerNo;

  OrdersRepo({required this.customerNo});

  static final ApiClient _client = ApiClient();

  // ============================================================
  // FETCH ORDERS
  // ============================================================

  Future<Result<List<Order>, Exception>> fetchOrders() async {
    try {
      final userId = customerNo.trim();

      if (userId.isEmpty) {
        return Failure(Exception('No customer ID found'));
      }

      debugPrint('🌐 [fetchOrders] Requesting orders for: $userId');

      final response = await _client.dio.get(
        '/GetInvPOSTransactionsCallCenterOrderHistory',
        queryParameters: {
          'Customer_No': userId,
          'TransId': -999,
          'TransStatus': -999,
        },
      );

      debugPrint('📊 [fetchOrders] Status: ${response.statusCode}');

      debugPrint('📦 [fetchOrders] Data: ${response.data}');

      if (response.data == null) {
        debugPrint('⚠️ [fetchOrders] API returned NULL');

        return const Success([]);
      }

      final rows = _extractRows(response.data);

      debugPrint('✅ [fetchOrders] Parsed ${rows.length} orders');

      return Success(rows.map(Order.fromJson).toList());
    } on DioException catch (e) {
      debugPrint('❌ [fetchOrders] DioException: ${e.message}');

      debugPrint('Response: ${e.response?.data}');

      return Failure(Exception('Network error: ${e.message}'));
    } catch (e) {
      debugPrint('❌ [fetchOrders] Error: $e');

      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  // ============================================================
  // FETCH ORDER DETAILS
  // ============================================================

  Future<Result<Order, Exception>> fetchOrderDetails(final int orderId) async {
    if (orderId <= 0) {
      return Failure(Exception('Invalid order id'));
    }

    try {
      final userId = customerNo.trim();

      if (userId.isEmpty) {
        return Failure(Exception('No customer ID found'));
      }

      debugPrint('🌐 [fetchOrderDetails] Requesting order: $orderId');

      final response = await _client.dio.get(
        '/GetInvPOSTransactionsCallCenterOrderHistory',
        queryParameters: {
          'Customer_No': userId,
          'TransId': orderId,
          'TransStatus': -999,
        },
      );

      debugPrint('📊 [fetchOrderDetails] Status: ${response.statusCode}');

      debugPrint('📦 [fetchOrderDetails] Data: ${response.data}');

      if (response.data == null) {
        return Failure(Exception('No details found for order $orderId'));
      }

      final data = response.data;

      final Map<String, dynamic> headerMap;

      if (data is List && data.isNotEmpty) {
        headerMap = Map<String, dynamic>.from(data.first as Map);
      } else if (data is Map) {
        headerMap = Map<String, dynamic>.from(data);
      } else {
        return Failure(Exception('No details found for order $orderId'));
      }

      return Success(Order.fromJson(headerMap));
    } on DioException catch (e) {
      return Failure(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  // ============================================================
  // EXTRACT ROWS
  // ============================================================

  List<Map<String, dynamic>> _extractRows(dynamic data) {
    if (data == null) return [];

    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }

    if (data is Map) {
      for (final key in ['data', 'result', 'items', 'orders', 'Data']) {
        final value = data[key];

        if (value is List) {
          return value
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
      }

      if (data.containsKey('Trans_ID') || data.containsKey('Trans_OrderNo')) {
        return [Map<String, dynamic>.from(data)];
      }
    }

    return [];
  }
}

// ============================================================
// RESULT
// ============================================================

sealed class Result<T, E extends Exception> {
  const Result();

  R fold<R>(R Function(T data) onSuccess, R Function(E error) onFailure) {
    final self = this;

    if (self is Success<T, E>) {
      return onSuccess(self.data);
    }

    if (self is Failure<T, E>) {
      return onFailure(self.error);
    }

    throw StateError('Unknown Result type: $self');
  }
}

class Success<T, E extends Exception> extends Result<T, E> {
  final T data;

  const Success(this.data);
}

class Failure<T, E extends Exception> extends Result<T, E> {
  final E error;

  const Failure(this.error);
}
