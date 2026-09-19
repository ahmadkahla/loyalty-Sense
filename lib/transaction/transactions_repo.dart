// import '../../app_all/BaseRepo.dart';
// import 'loyalty_transaction.dart';
//
// class TransactionsRepo extends BaseRepo {
//   // ============================================================
//   // ⚠️ مؤقتاً: CustomerId ثابت للاختبار
//   // لاحقاً: اقرأه من SharedPreferences بعد تسجيل الدخول
//   // ============================================================
//   static const int customerId = 1;
//
//   /// جلب معاملات الولاء الخاصة بالعميل
//   Future<List<LoyaltyTransaction>> fetchTransactions() async {
//     final response = await getRequest(
//       path: '/GetLoyaltyTransactionsByCustomerNo',
//       queryParams: {'Loyalty_Customer_No': customerId},
//     );
//
//     if (!isOk(response)) {
//       throw Exception('Failed to fetch transactions');
//     }
//
//     final data = decodeResponse(response);
//     if (data == null) return [];
//
//     return parseList<LoyaltyTransaction>(
//       data,
//       (e) => LoyaltyTransaction.fromJson(e),
//     );
//   }
// }

// import '../../app_all/ApiClient.dart';
// import 'loyalty_transaction.dart';
//
// class TransactionsRepo {
//   final ApiClient _apiClient;
//
//   TransactionsRepo({ApiClient? apiClient})
//     : _apiClient = apiClient ?? ApiClient();
//
//   static const int customerId = 1;
//
//   Future<List<LoyaltyTransaction>> fetchTransactions() async {
//     final response = await _apiClient.getRequest(
//       path: '/GetLoyaltyTransactionsByCustomerNo',
//       queryParams: {'Loyalty_Customer_No': customerId},
//     );
//
//     if (!_apiClient.isOk(response)) {
//       throw Exception('Failed to fetch transactions');
//     }
//
//     final data = _apiClient.decodeResponse(response);
//     if (data == null) return [];
//
//     return _apiClient.parseList<LoyaltyTransaction>(
//       data,
//       (e) => LoyaltyTransaction.fromJson(e),
//     );
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../app_all/ApiClient.dart';
// import 'loyalty_transaction.dart';
//
// class TransactionsRepo {
//   final ApiClient _apiClient;
//
//   TransactionsRepo({ApiClient? apiClient})
//     : _apiClient = apiClient ?? ApiClient();
//
//   // ============================================================
//   // ✅ Helper: يجيب الـ customerNo من SharedPreferences
//   // ============================================================
//   Future<int> _getCustomerId() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final customerNo =
//         prefs.getString('user_customer_no') ??
//         prefs.getString('user_Customer_No') ??
//         prefs.getString('user_id');
//
//     return int.tryParse(customerNo ?? '') ?? 1;
//   }
//
//   // ============================================================
//   // ✅ جلب معاملات الولاء من API (بيانات حقيقية)
//   // ============================================================
//   Future<List<LoyaltyTransaction>> fetchTransactions() async {
//     final customerId = await _getCustomerId();
//
//     final response = await _apiClient.getRequest(
//       path: '/GetLoyaltyTransactionsByCustomerNo',
//       queryParams: {'Loyalty_Customer_No': customerId},
//     );
//
//     if (!_apiClient.isOk(response)) {
//       throw Exception('Failed to fetch transactions');
//     }
//
//     final data = _apiClient.decodeResponse(response);
//     if (data == null) return [];
//
//     return _apiClient.parseList<LoyaltyTransaction>(
//       data,
//       (e) => LoyaltyTransaction.fromJson(e),
//     );
//   }
// }

import 'package:flutter/foundation.dart';

import '../../app_all/ApiClient.dart';
import 'loyalty_transaction.dart';

class TransactionsRepo {
  final ApiClient _apiClient;
  final String customerNo;

  TransactionsRepo({required this.customerNo, ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<List<LoyaltyTransaction>> fetchTransactions() async {
    final customerId = int.tryParse(customerNo.trim());

    if (customerId == null || customerId <= 0) {
      throw Exception('Invalid customer ID');
    }

    debugPrint(
      '🌐 [TransactionsRepo] '
      'customerNo = $customerId',
    );

    final response = await _apiClient.getRequest(
      path: '/GetLoyaltyTransactionsByCustomerNo',
      queryParams: {'Loyalty_Customer_No': customerId},
    );

    if (!_apiClient.isOk(response)) {
      throw Exception('Failed to fetch transactions');
    }

    final data = _apiClient.decodeResponse(response);

    if (data == null) return [];

    return _apiClient.parseList<LoyaltyTransaction>(
      data,
      (e) => LoyaltyTransaction.fromJson(e),
    );
  }
}
