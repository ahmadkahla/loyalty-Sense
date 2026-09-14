import 'package:flutter/foundation.dart';

import '../app_all/ApiResul.dart';
import 'branch_model.dart';
import 'repo.dart';

class BranchesController extends ChangeNotifier {
  final BranchesRepo _repo = BranchesRepo();

  List<Branch> _branches = [];

  bool _isLoading = false;

  String? _error;

  List<Branch> get branches {
    return List.unmodifiable(_branches);
  }

  bool get isLoading {
    return _isLoading;
  }

  String? get error {
    return _error;
  }

  bool get hasBranches {
    return _branches.isNotEmpty;
  }

  Future<void> loadBranches({required int languageCode}) async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    final result = await _repo.fetchBranches(languageCode: languageCode);

    switch (result) {
      case Success<List<Branch>>():
        _branches = result.data;

        if (_branches.isEmpty) {
          _error = null;
        }

      case Failure<List<Branch>>():
        _error = result.exception.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<void> refresh({required int languageCode}) async {
    await loadBranches(languageCode: languageCode);
  }

  bool canOrderFromBranch(Branch branch) {
    if (branch.isOpen24) {
      return true;
    }

    final now = DateTime.now();

    final nowMinutes = now.hour * 60 + now.minute;

    final openMinutes =
        branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;

    final closeMinutes =
        branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;

    if (closeMinutes < openMinutes) {
      return nowMinutes >= openMinutes || nowMinutes < closeMinutes;
    }

    return nowMinutes >= openMinutes && nowMinutes < closeMinutes;
  }
}
