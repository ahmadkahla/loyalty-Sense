import 'package:flutter/material.dart';
import 'package:loyalty/transaction/transactions_repo.dart';

import 'loyalty_transaction.dart';

class TransactionsController extends ChangeNotifier {
  final TransactionsRepo _repo = TransactionsRepo();

  // ============================================================
  // STATE
  // ============================================================
  List<LoyaltyTransaction> _transactions = [];
  List<LoyaltyTransaction> get transactions => _transactions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // ============================================================
  // LOAD
  // ============================================================
  Future<void> loadTransactions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _repo.fetchTransactions();
    } catch (e) {
      _error = e.toString();
      _transactions = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // ============================================================
  // REFRESH
  // ============================================================
  Future<void> refresh() async {
    await loadTransactions();
  }
}
