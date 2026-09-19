// import 'package:flutter/material.dart';
//
// import 'OrderDetailsScreen.dart';
// import 'OrderModel.dart';
//
// class MyOrdersScreen extends StatefulWidget {
//   const MyOrdersScreen({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// }
//
// class _MyOrdersScreenState extends State<MyOrdersScreen> {
//   bool showPrevious = false;
//
//   final List<OrderModel> orders = const [
//     OrderModel(
//       transactionNumber: '#1001',
//       branchName: 'SENSE Abdali',
//       date: 'Sep 7, 2026 • 10:30 AM',
//       transactionType: 'Invoice',
//       subtotal: 25.00,
//       discount: 0.00,
//       total: 25.00,
//       barcode: '1001000001',
//       items: [
//         OrderItemModel(name: 'Product A', price: 10.00, quantity: 1),
//         OrderItemModel(name: 'Product B', price: 7.50, quantity: 2),
//       ],
//     ),
//     OrderModel(
//       transactionNumber: '#1002',
//       branchName: 'SENSE Mecca Mall',
//       date: 'Sep 5, 2026 • 06:20 PM',
//       transactionType: 'Return',
//       subtotal: 10.00,
//       discount: 0.00,
//       total: 10.00,
//       barcode: '1002000002',
//       items: [OrderItemModel(name: 'Product C', price: 10.00, quantity: 1)],
//     ),
//     OrderModel(
//       transactionNumber: '#1003',
//       branchName: 'SENSE Abdali',
//       date: 'Aug 30, 2026 • 02:15 PM',
//       transactionType: 'Invoice',
//       subtotal: 42.50,
//       discount: 2.50,
//       total: 40.00,
//       barcode: '1003000003',
//       items: [
//         OrderItemModel(name: 'Product D', price: 20.00, quantity: 1),
//         OrderItemModel(name: 'Product E', price: 7.50, quantity: 3),
//       ],
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final currentOrders = orders.where((order) {
//       return order.transactionType == 'Invoice';
//     }).toList();
//
//     final previousOrders = orders.where((order) {
//       return order.transactionType == 'Return';
//     }).toList();
//
//     final visibleOrders = showPrevious ? previousOrders : currentOrders;
//
//     // 👈 بدون Scaffold وبدون AppBar
//     return Column(
//       children: [
//         const SizedBox(height: 4),
//
//         _buildSegmentedControl(context),
//
//         const SizedBox(height: 14),
//
//         Expanded(
//           child: visibleOrders.isEmpty
//               ? _buildEmptyState(context)
//               : ListView.separated(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(20, 4, 20, 25),
//                   itemCount: visibleOrders.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 14),
//                   itemBuilder: (context, index) {
//                     return _OrderCard(
//                       order: visibleOrders[index],
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) =>
//                                 OrderDetailsScreen(order: visibleOrders[index]),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
//
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
//                 title: 'Invoice',
//                 selected: !showPrevious,
//                 onTap: () {
//                   setState(() {
//                     showPrevious = false;
//                   });
//                 },
//               ),
//             ),
//             Expanded(
//               child: _segmentButton(
//                 context: context,
//                 title: 'Return Invoice',
//                 selected: showPrevious,
//                 onTap: () {
//                   setState(() {
//                     showPrevious = true;
//                   });
//                 },
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
//     final bool isReturn = order.transactionType.toLowerCase() == 'return';
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
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           order.transactionType,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
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
//                             order.transactionNumber,
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
//                       order.date,
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
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${isReturn ? '-' : ''}${order.total.toStringAsFixed(2)} JD',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                       color: isReturn
//                           ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
//                           : theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
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
// }
//
// // import 'package:flutter/material.dart';
// //
// // import 'OrderDetailsScreen.dart';
// // import 'order.dart';
// // import 'orders_repo.dart';
// //
// // class MyOrdersScreen extends StatefulWidget {
// //   const MyOrdersScreen({super.key});
// //
// //   static const Color primaryColor = Color(0xFFA5005A);
// //
// //   @override
// //   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// // }
// //
// // class _MyOrdersScreenState extends State<MyOrdersScreen> {
// //   final OrdersRepo _repo = OrdersRepo();
// //
// //   List<Order> _orders = [];
// //   bool _isLoading = true;
// //   String? _error;
// //   bool showPrevious = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadOrders();
// //   }
// //
// //   // ============================================================
// //   // ✅ تحميل الأوردرات من الـ API
// //   // ============================================================
// //   Future<void> _loadOrders() async {
// //     setState(() {
// //       _isLoading = true;
// //       _error = null;
// //     });
// //
// //     // final result = await _repo.fetchOrders();
// //     final result = await _repo.fetchOrders(isCompleted: true);
// //
// //     if (!mounted) return;
// //
// //     // ✅ نفس نمط Result / Success / Failure تبع OrdersRepo
// //     if (result is Success<List<Order>, Exception>) {
// //       setState(() {
// //         _orders = result.data;
// //         _isLoading = false;
// //       });
// //     } else if (result is Failure<List<Order>, Exception>) {
// //       setState(() {
// //         _error = result.error.toString();
// //         _isLoading = false;
// //       });
// //     }
// //   }
// //
// //   Future<void> _onRefresh() async {
// //     await _loadOrders();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     // تقسيم الأوردرات حسب النوع
// //     final currentOrders = _orders.where((o) => !o.isReturn).toList();
// //     final previousOrders = _orders.where((o) => o.isReturn).toList();
// //     final visibleOrders = showPrevious ? previousOrders : currentOrders;
// //
// //     // 👈 بدون Scaffold وبدون AppBar
// //     return Column(
// //       children: [
// //         const SizedBox(height: 4),
// //
// //         _buildSegmentedControl(context),
// //
// //         const SizedBox(height: 14),
// //
// //         Expanded(child: _buildBody(context, visibleOrders, isDark)),
// //       ],
// //     );
// //   }
// //
// //   // ============================================================
// //   // BODY (Loading / Error / Empty / List)
// //   // ============================================================
// //   Widget _buildBody(
// //     BuildContext context,
// //     List<Order> visibleOrders,
// //     bool isDark,
// //   ) {
// //     // Loading
// //     if (_isLoading) {
// //       return const Center(child: CircularProgressIndicator());
// //     }
// //
// //     // Error
// //     if (_error != null) {
// //       return Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(24),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(
// //                 Icons.error_outline_rounded,
// //                 size: 55,
// //                 color: Colors.red.shade300,
// //               ),
// //               const SizedBox(height: 12),
// //               Text(
// //                 'تعذر تحميل الطلبات',
// //                 style: TextStyle(
// //                   fontSize: 15,
// //                   fontWeight: FontWeight.w600,
// //                   color: isDark ? Colors.white70 : Colors.grey.shade700,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 _error!,
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: isDark ? Colors.white54 : Colors.grey.shade500,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               TextButton.icon(
// //                 onPressed: _loadOrders,
// //                 icon: const Icon(Icons.refresh_rounded),
// //                 label: const Text('إعادة المحاولة'),
// //                 style: TextButton.styleFrom(
// //                   foregroundColor: MyOrdersScreen.primaryColor,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     }
// //
// //     // Empty
// //     if (visibleOrders.isEmpty) {
// //       return _buildEmptyState(context);
// //     }
// //
// //     // List
// //     return RefreshIndicator(
// //       onRefresh: _onRefresh,
// //       color: MyOrdersScreen.primaryColor,
// //       child: ListView.separated(
// //         physics: const AlwaysScrollableScrollPhysics(
// //           parent: BouncingScrollPhysics(),
// //         ),
// //         padding: const EdgeInsets.fromLTRB(20, 4, 20, 25),
// //         itemCount: visibleOrders.length,
// //         separatorBuilder: (_, __) => const SizedBox(height: 14),
// //         itemBuilder: (context, index) {
// //           final order = visibleOrders[index];
// //           return _OrderCard(
// //             order: order,
// //             onTap: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(
// //                   builder: (_) => OrderDetailsScreen(order: order),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSegmentedControl(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Container(
// //         height: 48,
// //         padding: const EdgeInsets.all(4),
// //         decoration: BoxDecoration(
// //           color: isDark
// //               ? theme.cardColor.withOpacity(0.75)
// //               : Colors.grey.shade200,
// //           borderRadius: BorderRadius.circular(14),
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: _segmentButton(
// //                 context: context,
// //                 title: 'Invoice',
// //                 selected: !showPrevious,
// //                 onTap: () => setState(() => showPrevious = false),
// //               ),
// //             ),
// //             Expanded(
// //               child: _segmentButton(
// //                 context: context,
// //                 title: 'Return Invoice',
// //                 selected: showPrevious,
// //                 onTap: () => setState(() => showPrevious = true),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _segmentButton({
// //     required BuildContext context,
// //     required String title,
// //     required bool selected,
// //     required VoidCallback onTap,
// //   }) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 200),
// //         alignment: Alignment.center,
// //         decoration: BoxDecoration(
// //           color: selected ? theme.cardColor : Colors.transparent,
// //           borderRadius: BorderRadius.circular(11),
// //           boxShadow: selected
// //               ? [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.06),
// //                     blurRadius: 5,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ]
// //               : null,
// //         ),
// //         child: Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 14,
// //             fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
// //             color: selected
// //                 ? MyOrdersScreen.primaryColor
// //                 : (isDark ? Colors.white70 : Colors.grey.shade600),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildEmptyState(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(
// //             Icons.receipt_long_outlined,
// //             size: 55,
// //             color: isDark ? Colors.white38 : Colors.grey.shade400,
// //           ),
// //           const SizedBox(height: 12),
// //           Text(
// //             'No orders found',
// //             style: TextStyle(
// //               fontSize: 15,
// //               fontWeight: FontWeight.w600,
// //               color: isDark ? Colors.white70 : Colors.grey.shade600,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ============================================================
// // // ORDER CARD
// // // ============================================================
// // class _OrderCard extends StatelessWidget {
// //   final Order order;
// //   final VoidCallback onTap;
// //
// //   const _OrderCard({required this.order, required this.onTap});
// //
// //   static const Color primaryColor = Color(0xFFA5005A);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //     final bool isReturn = order.isReturn;
// //
// //     return Material(
// //       color: Colors.transparent,
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(20),
// //         child: Container(
// //           padding: const EdgeInsets.all(18),
// //           decoration: BoxDecoration(
// //             color: theme.cardColor,
// //             borderRadius: BorderRadius.circular(20),
// //             border: Border.all(
// //               color: isDark
// //                   ? Colors.white.withOpacity(0.10)
// //                   : Colors.grey.shade200,
// //             ),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.04),
// //                 blurRadius: 15,
// //                 offset: const Offset(0, 6),
// //               ),
// //             ],
// //           ),
// //           child: Row(
// //             children: [
// //               Container(
// //                 width: 52,
// //                 height: 52,
// //                 decoration: BoxDecoration(
// //                   color: primaryColor.withOpacity(0.10),
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //                 child: Icon(
// //                   isReturn
// //                       ? Icons.assignment_return_outlined
// //                       : Icons.receipt_long_outlined,
// //                   color: primaryColor,
// //                   size: 25,
// //                 ),
// //               ),
// //
// //               const SizedBox(width: 14),
// //
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Text(
// //                           order.transactionType,
// //                           style: const TextStyle(
// //                             fontSize: 15,
// //                             fontWeight: FontWeight.w800,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 7),
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 7,
// //                             vertical: 3,
// //                           ),
// //                           decoration: BoxDecoration(
// //                             color: primaryColor.withOpacity(0.08),
// //                             borderRadius: BorderRadius.circular(6),
// //                           ),
// //                           child: Text(
// //                             '#${order.orderNo}',
// //                             style: const TextStyle(
// //                               fontSize: 10,
// //                               fontWeight: FontWeight.w700,
// //                               color: primaryColor,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //
// //                     const SizedBox(height: 6),
// //
// //                     Text(
// //                       order.branchName,
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: isDark ? Colors.white70 : Colors.grey.shade700,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 4),
// //
// //                     Text(
// //                       _formatDate(order.dateTime),
// //                       style: TextStyle(
// //                         fontSize: 11,
// //                         color: isDark ? Colors.white54 : Colors.grey.shade500,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //
// //               const SizedBox(width: 8),
// //
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   Text(
// //                     '${isReturn ? '-' : ''}${order.total.toStringAsFixed(2)} JD',
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w800,
// //                       color: isReturn
// //                           ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
// //                           : theme.textTheme.bodyLarge?.color,
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 8),
// //
// //                   Icon(
// //                     Icons.chevron_right,
// //                     size: 20,
// //                     color: isDark ? Colors.white38 : Colors.grey.shade400,
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ✅ تنسيق التاريخ
// //   String _formatDate(DateTime date) {
// //     final months = [
// //       'Jan',
// //       'Feb',
// //       'Mar',
// //       'Apr',
// //       'May',
// //       'Jun',
// //       'Jul',
// //       'Aug',
// //       'Sep',
// //       'Oct',
// //       'Nov',
// //       'Dec',
// //     ];
// //
// //     final hour = date.hour > 12
// //         ? date.hour - 12
// //         : (date.hour == 0 ? 12 : date.hour);
// //     final period = date.hour >= 12 ? 'PM' : 'AM';
// //     final minute = date.minute.toString().padLeft(2, '0');
// //
// //     return '${months[date.month - 1]} ${date.day}, ${date.year} • '
// //         '$hour:$minute $period';
// //   }
// // }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import 'OrderDetailsScreen.dart';
// import 'order.dart';
// import 'orders_repo.dart';
//
// class MyOrdersScreen extends StatefulWidget {
//   const MyOrdersScreen({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   State<MyOrdersScreen> createState() => _MyOrdersScreenState();
// }
//
// class _MyOrdersScreenState extends State<MyOrdersScreen> {
//   final OrdersRepo _repo = OrdersRepo();
//
//   List<Order> _orders = [];
//   bool _isLoading = true;
//   String? _error;
//   bool showPrevious = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadOrders();
//   }
//
//   // ============================================================
//   // ✅ تحميل الأوردرات من الـ API
//   // ============================================================
//   Future<void> _loadOrders() async {
//     setState(() {
//       _isLoading = true;
//       _error = null;
//     });
//
//     final result = await _repo.fetchOrders();
//
//     if (!mounted) return;
//
//     result.fold(
//       (orders) {
//         setState(() {
//           _orders = orders;
//           _isLoading = false;
//         });
//       },
//       (error) {
//         setState(() {
//           _error = error.toString();
//           _isLoading = false;
//         });
//       },
//     );
//   }
//
//   Future<void> _onRefresh() async {
//     await _loadOrders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     // تقسيم الأوردرات حسب النوع
//     final currentOrders = _orders.where((o) => !o.isReturn).toList();
//     final previousOrders = _orders.where((o) => o.isReturn).toList();
//     final visibleOrders = showPrevious ? previousOrders : currentOrders;
//
//     return Column(
//       children: [
//         const SizedBox(height: 4),
//
//         _buildSegmentedControl(context),
//
//         const SizedBox(height: 14),
//
//         Expanded(child: _buildBody(context, visibleOrders, isDark)),
//       ],
//     );
//   }
//
//   // ============================================================
//   // BODY (Loading / Error / Empty / List)
//   // ============================================================
//   Widget _buildBody(
//     BuildContext context,
//     List<Order> visibleOrders,
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
//                 selected: !showPrevious,
//                 onTap: () => setState(() => showPrevious = false),
//               ),
//             ),
//             Expanded(
//               child: _segmentButton(
//                 context: context,
//                 title: 'Return Invoice'.tr(),
//                 selected: showPrevious,
//                 onTap: () => setState(() => showPrevious = true),
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
//   final Order order;
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
//     final bool isReturn = order.isReturn;
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
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           order.transactionType,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w800,
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
//                             '#${order.orderNo}',
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
//                       _formatDate(order.dateTime),
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
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${isReturn ? '-' : ''}${order.total.toStringAsFixed(2)} JD',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w800,
//                       color: isReturn
//                           ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
//                           : theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
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
//   String _formatDate(DateTime date) {
//     final months = [
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
//     final hour = date.hour > 12
//         ? date.hour - 12
//         : (date.hour == 0 ? 12 : date.hour);
//     final period = date.hour >= 12 ? 'PM' : 'AM';
//     final minute = date.minute.toString().padLeft(2, '0');
//
//     return '${months[date.month - 1]} ${date.day}, ${date.year} • '
//         '$hour:$minute $period';
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'OrderDetailsScreen.dart';
import 'order.dart';
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

  List<Order> _orders = [];
  bool _isLoading = true;
  String? _error;
  bool showPrevious = false;

  @override
  void initState() {
    super.initState();

    _repo = OrdersRepo(customerNo: widget.customerNo);

    _loadOrders();
  }

  Future<void> _loadOrders() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await _repo.fetchOrders();

    if (!mounted) return;

    result.fold(
      (orders) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      },
      (error) {
        setState(() {
          _error = error.toString();
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _onRefresh() async {
    await _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentOrders = _orders.where((o) => !o.isReturn).toList();

    final previousOrders = _orders.where((o) => o.isReturn).toList();

    final visibleOrders = showPrevious ? previousOrders : currentOrders;

    return Column(
      children: [
        const SizedBox(height: 4),

        _buildSegmentedControl(context),

        const SizedBox(height: 14),

        Expanded(child: _buildBody(context, visibleOrders, isDark)),
      ],
    );
  }

  Widget _buildBody(
    BuildContext context,
    List<Order> visibleOrders,
    bool isDark,
  ) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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

    if (visibleOrders.isEmpty) {
      return _buildEmptyState(context);
    }

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(order: order),
                ),
              );
            },
          );
        },
      ),
    );
  }

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
                selected: !showPrevious,
                onTap: () {
                  setState(() => showPrevious = false);
                },
              ),
            ),

            Expanded(
              child: _segmentButton(
                context: context,
                title: 'Return Invoice'.tr(),
                selected: showPrevious,
                onTap: () {
                  setState(() => showPrevious = true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const _OrderCard({required this.order, required this.onTap});

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final bool isReturn = order.isReturn;

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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order.transactionType,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
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
                            '#${order.orderNo}',
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
                      _formatDate(order.dateTime),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white54 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

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

  String _formatDate(DateTime date) {
    final months = [
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

    final hour = date.hour > 12
        ? date.hour - 12
        : (date.hour == 0 ? 12 : date.hour);

    final period = date.hour >= 12 ? 'PM' : 'AM';

    final minute = date.minute.toString().padLeft(2, '0');

    return '${months[date.month - 1]} '
        '${date.day}, ${date.year} • '
        '$hour:$minute $period';
  }
}
