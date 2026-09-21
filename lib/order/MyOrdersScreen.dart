// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import 'OrderDetailsScreen.dart';
// import 'OrderModel.dart';
// import 'orders_repo.dart';
//
// class MyOrdersScreen extends StatefulWidget {
//   final String customerNo;
//
//   const MyOrdersScreen({super.key, required this.customerNo});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// }
//
// class _MyOrdersScreenState extends State<MyOrdersScreen> {
//   late final OrdersRepo _repo;
//
//   List<OrderModel> _invoices = [];
//   List<OrderModel> _returns = [];
//
//   bool _isLoading = true;
//   String? _error;
//
//   /// false = الفواتير، true = المرتجعات
//   bool _showReturns = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _repo = OrdersRepo(customerNo: widget.customerNo);
//     _loadOrders();
//   }
//
//   // ============================================================
//   // تحميل الطلبات (نوعان: فواتير + مرتجعات)
//   // ============================================================
//   Future<void> _loadOrders() async {
//     if (!mounted) return;
//
//     setState(() {
//       _isLoading = true;
//       _error = null;
//     });
//
//     // 1) الفواتير
//     final invoicesResult = await _repo.fetchOrders(type: TransType.invoice);
//     // 2) المرتجعات
//     final returnsResult = await _repo.fetchOrders(type: TransType.returnDoc);
//
//     if (!mounted) return;
//
//     // نتائج الفواتير
//     invoicesResult.fold(
//       (data) {
//         _invoices = data;
//       },
//       (error) {
//         _error = error.toString();
//       },
//     );
//
//     // نتائج المرتجعات
//     returnsResult.fold(
//       (data) {
//         _returns = data;
//       },
//       (error) {
//         _error ??= error.toString();
//       },
//     );
//
//     setState(() => _isLoading = false);
//   }
//
//   Future<void> _onRefresh() async {
//     await _loadOrders();
//   }
//
//   // ============================================================
//   // BUILD
//   // ============================================================
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final visibleOrders = _showReturns ? _returns : _invoices;
//
//     return Column(
//       children: [
//         const SizedBox(height: 4),
//         _buildSegmentedControl(context),
//         const SizedBox(height: 14),
//         Expanded(child: _buildBody(context, visibleOrders, isDark)),
//       ],
//     );
//   }
//
//   // ============================================================
//   // BODY
//   // ============================================================
//   Widget _buildBody(
//     BuildContext context,
//     List<OrderModel> visibleOrders,
//     bool isDark,
//   ) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (_error != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.error_outline_rounded,
//                 size: 55,
//                 color: Colors.red.shade300,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'تعذر تحميل الطلبات',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: isDark ? Colors.white70 : Colors.grey.shade700,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 _error!,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: isDark ? Colors.white54 : Colors.grey.shade500,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextButton.icon(
//                 onPressed: _loadOrders,
//                 icon: const Icon(Icons.refresh_rounded),
//                 label: const Text('إعادة المحاولة'),
//                 style: TextButton.styleFrom(
//                   foregroundColor: MyOrdersScreen.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (visibleOrders.isEmpty) {
//       return _buildEmptyState(context);
//     }
//
//     return RefreshIndicator(
//       onRefresh: _onRefresh,
//       color: MyOrdersScreen.primaryColor,
//       child: ListView.separated(
//         physics: const AlwaysScrollableScrollPhysics(
//           parent: BouncingScrollPhysics(),
//         ),
//         padding: const EdgeInsets.fromLTRB(20, 4, 20, 25),
//         itemCount: visibleOrders.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 14),
//         itemBuilder: (context, index) {
//           final order = visibleOrders[index];
//           return _OrderCard(
//             order: order,
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => OrderDetailsScreen(order: order),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // ============================================================
//   // SEGMENTED CONTROL
//   // ============================================================
//   Widget _buildSegmentedControl(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         height: 48,
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: isDark
//               ? theme.cardColor.withOpacity(0.75)
//               : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: _segmentButton(
//                 context: context,
//                 title: 'Invoice'.tr(),
//                 selected: !_showReturns,
//                 onTap: () => setState(() => _showReturns = false),
//               ),
//             ),
//             Expanded(
//               child: _segmentButton(
//                 context: context,
//                 title: 'Return Invoice'.tr(),
//                 selected: _showReturns,
//                 onTap: () => setState(() => _showReturns = true),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _segmentButton({
//     required BuildContext context,
//     required String title,
//     required bool selected,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: selected ? theme.cardColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(11),
//           boxShadow: selected
//               ? [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.06),
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                   ),
//                 ]
//               : null,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
//             color: selected
//                 ? MyOrdersScreen.primaryColor
//                 : (isDark ? Colors.white70 : Colors.grey.shade600),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // EMPTY STATE
//   // ============================================================
//   Widget _buildEmptyState(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 55,
//             color: isDark ? Colors.white38 : Colors.grey.shade400,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'No orders found',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: isDark ? Colors.white70 : Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ============================================================
// // ORDER CARD
// // ============================================================
// class _OrderCard extends StatelessWidget {
//   final OrderModel order;
//   final VoidCallback onTap;
//
//   const _OrderCard({required this.order, required this.onTap});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     // مرتجع إذا Trans_Type == 2
//     final bool isReturn = order.transType == 2;
//
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: theme.cardColor,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: isDark
//                   ? Colors.white.withOpacity(0.10)
//                   : Colors.grey.shade200,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 15,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               // أيقونة
//               Container(
//                 width: 52,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Icon(
//                   isReturn
//                       ? Icons.assignment_return_outlined
//                       : Icons.receipt_long_outlined,
//                   color: primaryColor,
//                   size: 25,
//                 ),
//               ),
//
//               const SizedBox(width: 14),
//
//               // معلومات
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Flexible(
//                           child: Text(
//                             order.transactionType.isNotEmpty
//                                 ? order.transactionType
//                                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w800,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(width: 7),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 7,
//                             vertical: 3,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primaryColor.withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             '#${order.transactionNumber}',
//                             style: const TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w700,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 6),
//
//                     Text(
//                       order.branchName,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: isDark ? Colors.white70 : Colors.grey.shade700,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//
//                     const SizedBox(height: 4),
//
//                     Text(
//                       _formatDate(order.date),
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: isDark ? Colors.white54 : Colors.grey.shade500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               // المبلغ + أيقونة
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${isReturn ? '-' : ''}'
//                     '${order.total.toStringAsFixed(2)} JD',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                       color: isReturn
//                           ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
//                           : theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Icon(
//                     Icons.chevron_right,
//                     size: 20,
//                     color: isDark ? Colors.white38 : Colors.grey.shade400,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // تنسيق التاريخ (يستقبل String من الـ API)
//   // ============================================================
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     // جرّب نحوّل النص إلى DateTime
//     final parsed = DateTime.tryParse(raw);
//     if (parsed == null) return raw; // إذا فشل، أعرضه كما هو
//
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//
//     final hour = parsed.hour > 12
//         ? parsed.hour - 12
//         : (parsed.hour == 0 ? 12 : parsed.hour);
//
//     final period = parsed.hour >= 12 ? 'PM' : 'AM';
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     return '${months[parsed.month - 1]} '
//         '${parsed.day}, ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'OrderDetailsScreen.dart';
import 'OrderModel.dart';
import 'orders_repo.dart';

class MyOrdersScreen extends StatefulWidget {
  final String customerNo;

  const MyOrdersScreen({super.key, required this.customerNo});

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late final OrdersRepo _repo;

  List<OrderModel> _invoices = [];
  List<OrderModel> _returns = [];

  bool _isLoading = true;
  String? _error;

  /// false = الفواتير
  /// true = المرتجعات
  bool _showReturns = false;

  @override
  void initState() {
    super.initState();

    _repo = OrdersRepo(customerNo: widget.customerNo);

    _loadOrders();
  }

  // ============================================================
  // LOAD ORDERS
  // ============================================================

  Future<void> _loadOrders() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    // ----------------------------------------------------------
    // 1) INVOICES
    // ----------------------------------------------------------

    final invoicesResult = await _repo.fetchOrders(type: TransType.invoice);

    // ----------------------------------------------------------
    // 2) RETURNS
    // ----------------------------------------------------------

    final returnsResult = await _repo.fetchOrders(type: TransType.returnDoc);

    if (!mounted) return;

    // ----------------------------------------------------------
    // INVOICES RESULT
    // ----------------------------------------------------------

    invoicesResult.fold(
      (data) {
        _invoices = data;
      },
      (error) {
        _error = error.toString();
      },
    );

    // ----------------------------------------------------------
    // RETURNS RESULT
    // ----------------------------------------------------------

    returnsResult.fold(
      (data) {
        _returns = data;
      },
      (error) {
        _error ??= error.toString();
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _onRefresh() async {
    await _loadOrders();
  }

  // ============================================================
  // OPEN ORDER DETAILS
  // ============================================================

  Future<void> _openOrderDetails(BuildContext context, OrderModel order) async {
    // ----------------------------------------------------------
    // Show loading dialog
    // ----------------------------------------------------------

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: MyOrdersScreen.primaryColor,
                  ),
                ),

                const SizedBox(width: 16),

                Flexible(
                  child: Text(
                    'Loading invoice details...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // ----------------------------------------------------------
    // Fetch invoice details
    // ----------------------------------------------------------

    final result = await _repo.fetchOrderDetails(order, lang: 1, operNo: 1);

    // ----------------------------------------------------------
    // Close loading dialog
    // ----------------------------------------------------------

    if (!mounted) return;

    Navigator.of(context).pop();

    // ----------------------------------------------------------
    // Handle result
    // ----------------------------------------------------------

    result.fold(
      (detailsOrder) {
        if (!mounted) return;

        // ------------------------------------------------------
        // Debug
        // ------------------------------------------------------

        debugPrint('✅ [MyOrdersScreen] Details loaded successfully');

        debugPrint('🧾 Trans_ID: ${detailsOrder.transId}');

        debugPrint('🍔 Items count: ${detailsOrder.items.length}');

        for (final item in detailsOrder.items) {
          debugPrint(
            '🍔 Item: '
            'id=${item.id}, '
            'name=${item.name}, '
            'qty=${item.quantity}, '
            'price=${item.price}, '
            'total=${item.total}',
          );
        }

        // ------------------------------------------------------
        // Open details screen WITH items
        // ------------------------------------------------------

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(order: detailsOrder),
          ),
        );
      },
      (error) {
        if (!mounted) return;

        debugPrint('❌ [MyOrdersScreen] Failed to load details: $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load invoice details: $error'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final visibleOrders = _showReturns ? _returns : _invoices;

    return Column(
      children: [
        const SizedBox(height: 4),

        _buildSegmentedControl(context),

        const SizedBox(height: 14),

        Expanded(child: _buildBody(context, visibleOrders, isDark)),
      ],
    );
  }

  // ============================================================
  // BODY
  // ============================================================

  Widget _buildBody(
    BuildContext context,
    List<OrderModel> visibleOrders,
    bool isDark,
  ) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: MyOrdersScreen.primaryColor),
      );
    }

    // ----------------------------------------------------------
    // ERROR
    // ----------------------------------------------------------

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 55,
                color: Colors.red.shade300,
              ),

              const SizedBox(height: 12),

              Text(
                'تعذر تحميل الطلبات',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white54 : Colors.grey.shade500,
                ),
              ),

              const SizedBox(height: 16),

              TextButton.icon(
                onPressed: _loadOrders,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('إعادة المحاولة'),
                style: TextButton.styleFrom(
                  foregroundColor: MyOrdersScreen.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ----------------------------------------------------------
    // EMPTY
    // ----------------------------------------------------------

    if (visibleOrders.isEmpty) {
      return _buildEmptyState(context);
    }

    // ----------------------------------------------------------
    // ORDERS
    // ----------------------------------------------------------

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: MyOrdersScreen.primaryColor,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 25),
        itemCount: visibleOrders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final order = visibleOrders[index];

          return _OrderCard(
            order: order,
            onTap: () {
              _openOrderDetails(context, order);
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // SEGMENTED CONTROL
  // ============================================================

  Widget _buildSegmentedControl(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? theme.cardColor.withOpacity(0.75)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: _segmentButton(
                context: context,
                title: 'Invoice'.tr(),
                selected: !_showReturns,
                onTap: () {
                  setState(() {
                    _showReturns = false;
                  });
                },
              ),
            ),

            Expanded(
              child: _segmentButton(
                context: context,
                title: 'Return Invoice'.tr(),
                selected: _showReturns,
                onTap: () {
                  setState(() {
                    _showReturns = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEGMENT BUTTON
  // ============================================================

  Widget _segmentButton({
    required BuildContext context,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? theme.cardColor : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? MyOrdersScreen.primaryColor
                : (isDark ? Colors.white70 : Colors.grey.shade600),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 55,
            color: isDark ? Colors.white38 : Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ORDER CARD
// ============================================================

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const _OrderCard({required this.order, required this.onTap});

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final bool isReturn = order.transType == 2;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.10)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==================================================
              // ICON
              // ==================================================

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  isReturn
                      ? Icons.assignment_return_outlined
                      : Icons.receipt_long_outlined,
                  color: primaryColor,
                  size: 25,
                ),
              ),

              const SizedBox(width: 14),

              // ==================================================
              // INFORMATION
              // ==================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            order.transactionType.isNotEmpty
                                ? order.transactionType
                                : (isReturn ? 'مرتجع' : 'فاتورة'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 7),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '#${order.transactionNumber}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      order.branchName,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      _formatDate(order.date),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white54 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ==================================================
              // TOTAL
              // ==================================================
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isReturn ? '-' : ''}'
                    '${order.total.toStringAsFixed(2)} JD',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isReturn
                          ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
                          : theme.textTheme.bodyLarge?.color,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: isDark ? Colors.white38 : Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FORMAT DATE
  // ============================================================

  String _formatDate(String raw) {
    if (raw.trim().isEmpty) {
      return '';
    }

    final parsed = DateTime.tryParse(raw);

    if (parsed == null) {
      return raw;
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour = parsed.hour > 12
        ? parsed.hour - 12
        : (parsed.hour == 0 ? 12 : parsed.hour);

    final period = parsed.hour >= 12 ? 'PM' : 'AM';

    final minute = parsed.minute.toString().padLeft(2, '0');

    return '${months[parsed.month - 1]} '
        '${parsed.day}, ${parsed.year} • '
        '$hour:$minute $period';
  }
}
