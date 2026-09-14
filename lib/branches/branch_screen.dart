import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'branch_cell.dart';
import 'controller.dart';

class BranchScreen extends StatefulWidget {
  static const String routeName = '/branches';

  const BranchScreen({super.key});

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  late final BranchesController controller;

  @override
  void initState() {
    super.initState();

    controller = BranchesController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBranches();
    });
  }

  Future<void> _loadBranches() async {
    await controller.loadBranches(languageCode: _getLanguageCode());
  }

  int _getLanguageCode() {
    final languageCode = Localizations.localeOf(context).languageCode;

    return languageCode == 'en' ? 2 : 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BranchesController>.value(
      value: controller,
      child: Consumer<BranchesController>(
        builder: (context, controller, child) {
          // ============================================================
          // LOADING
          // ============================================================
          if (controller.isLoading && controller.branches.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // ============================================================
          // ERROR
          // ============================================================
          if (controller.error != null && controller.branches.isEmpty) {
            return _buildError(context, controller.error!);
          }

          // ============================================================
          // EMPTY
          // ============================================================
          if (controller.branches.isEmpty) {
            return _buildEmpty();
          }

          // ============================================================
          // BRANCHES
          // ============================================================
          return RefreshIndicator(
            color: const Color(0xFFA5005A),
            onRefresh: () {
              return controller.refresh(languageCode: _getLanguageCode());
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: controller.branches.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14);
              },
              itemBuilder: (context, index) {
                final branch = controller.branches[index];

                return BranchCell(branch: branch);
              },
            ),
          );
        },
      ),
    );
  }

  // ================================================================
  // ERROR
  // ================================================================

  Widget _buildError(BuildContext context, String error) {
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

            const Text(
              'Could not load branches',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(error, textAlign: TextAlign.center),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _loadBranches,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmpty() {
    return const Center(
      child: Text('No branches found', style: TextStyle(fontSize: 16)),
    );
  }
}
