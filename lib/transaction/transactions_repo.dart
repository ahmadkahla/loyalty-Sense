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
