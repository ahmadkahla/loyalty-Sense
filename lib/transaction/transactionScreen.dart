import 'package:flutter/material.dart';
import 'package:loyalty/transaction/transaction_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'transactions_controller.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late final TransactionsController controller;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    controller = TransactionsController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadTransactions();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // ============================================================
        // LOADING
        // ============================================================
        if (controller.isLoading && controller.transactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // ============================================================
        // ERROR
        // ============================================================
        if (controller.error != null && controller.transactions.isEmpty) {
          return _buildError(context, controller);
        }

        // ============================================================
        // EMPTY
        // ============================================================
        if (controller.transactions.isEmpty) {
          return _buildEmpty();
        }

        // ============================================================
        // LIST
        // ============================================================
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () async {
            await controller.refresh();
            _refreshController.refreshCompleted();
          },
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            itemCount: controller.transactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return TransactionCell(
                transaction: controller.transactions[index],
              );
            },
          ),
        );
      },
    );
  }

  // ============================================================
  // ERROR
  // ============================================================
  Widget _buildError(BuildContext context, TransactionsController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(controller.error ?? 'Error', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.loadTransactions(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
