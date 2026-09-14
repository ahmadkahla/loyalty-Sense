// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'OrderModel.dart';
//
// class OrderDetailsScreen extends StatelessWidget {
//   final OrderModel order;
//
//   const OrderDetailsScreen({super.key, required this.order});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           'Invoice Details',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             color: theme.textTheme.titleLarge?.color,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
//         child: Column(
//           children: [
//             _buildOrderInformation(context),
//             const SizedBox(height: 14),
//             _buildReceipt(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ORDER INFORMATION
//   // ============================================================
//
//   Widget _buildOrderInformation(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.10) : Colors.grey.shade200,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.18 : 0.04),
//             blurRadius: 15,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Icon(
//                   order.transactionType.toLowerCase() == 'return'
//                       ? Icons.assignment_return_outlined
//                       : Icons.receipt_long_outlined,
//                   color: primaryColor,
//                   size: 25,
//                 ),
//               ),
//
//               const SizedBox(width: 13),
//
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       order.transactionType,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//
//                     const SizedBox(height: 3),
//
//                     Text(
//                       order.transactionNumber,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: isDark ? Colors.white70 : Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 18),
//
//           _infoRow(context, label: 'Branch', value: order.branchName),
//
//           const SizedBox(height: 10),
//
//           _infoRow(context, label: 'Date', value: order.date),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType,
//             valueColor: primaryColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // INFO ROW
//   // ============================================================
//
//   Widget _infoRow(
//     BuildContext context, {
//     required String label,
//     required String value,
//     Color? valueColor,
//   }) {
//     final theme = Theme.of(context);
//
//     return Row(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white70
//                 : Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const Spacer(),
//
//         Flexible(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontSize: 13,
//               color: valueColor ?? theme.textTheme.bodyLarge?.color,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // RECEIPT
//   // ============================================================
//
//   Widget _buildReceipt(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final bool isReturn =
//         order.transactionType.toLowerCase().trim() == 'return';
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14, top: 8),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.30 : 0.14),
//             offset: const Offset(0, 10),
//             blurRadius: 20,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: ClipPath(
//         clipper: const _ReceiptTornClipper(),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
//           decoration: BoxDecoration(
//             color: theme.cardColor,
//             border: Border.all(
//               color: isDark
//                   ? Colors.white.withOpacity(0.18)
//                   : const Color(0xFFB8B8B8),
//               width: 1.2,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     const Text(
//                       'SENSE',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                         letterSpacing: 2,
//                         color: primaryColor,
//                       ),
//                     ),
//
//                     const SizedBox(height: 5),
//
//                     Text(
//                       isReturn ? 'RETURN RECEIPT' : 'SALES RECEIPT',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w800,
//                         color: isDark ? Colors.white70 : Colors.grey.shade700,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 14),
//
//               _receiptKeyValue(
//                 context,
//                 'Transaction No.',
//                 order.transactionNumber,
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', order.date),
//
//               const SizedBox(height: 14),
//
//               Text(
//                 'Items',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: theme.textTheme.bodyLarge?.color,
//                 ),
//               ),
//
//               const SizedBox(height: 7),
//
//               for (final item in order.items) ...[
//                 Divider(
//                   color: isDark ? Colors.white24 : Colors.grey.shade300,
//                   height: 1,
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Return = strike through product
//                 _buildItem(context, item, isReturn: isReturn),
//
//                 const SizedBox(height: 10),
//               ],
//
//               const SizedBox(height: 2),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               _receiptMoneyRow(context, 'Subtotal', order.subtotal),
//
//               if (order.discount > 0) ...[
//                 const SizedBox(height: 8),
//
//                 _receiptMoneyRow(
//                   context,
//                   'Discount',
//                   order.discount,
//                   valueColor: isDark
//                       ? Colors.green.shade300
//                       : Colors.green.shade700,
//                   prefix: '-',
//                 ),
//               ],
//
//               const SizedBox(height: 12),
//
//               Divider(
//                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               _receiptMoneyRow(context, 'Total', order.total, large: true),
//
//               const SizedBox(height: 18),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 18),
//
//               _buildBarcodeSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // RECEIPT KEY VALUE
//   // ============================================================
//
//   Widget _receiptKeyValue(BuildContext context, String key, String value) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           key,
//           style: TextStyle(
//             fontSize: 13,
//             color: isDark ? Colors.white70 : Colors.grey.shade700,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const Spacer(),
//
//         Flexible(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w700,
//               color: theme.textTheme.bodyLarge?.color,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // PRODUCT ITEM
//   // ============================================================
//
//   Widget _buildItem(
//     BuildContext context,
//     OrderItemModel item, {
//     required bool isReturn,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final TextStyle itemStyle = TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w600,
//       color: theme.textTheme.bodyLarge?.color,
//       decoration: isReturn ? TextDecoration.lineThrough : TextDecoration.none,
//       decorationColor: isDark ? Colors.white54 : Colors.grey.shade500,
//       decorationThickness: 4,
//     );
//
//     final TextStyle detailsStyle = TextStyle(
//       fontSize: 12,
//       color: isDark ? Colors.white70 : Colors.grey.shade600,
//       decoration: isReturn ? TextDecoration.lineThrough : TextDecoration.none,
//       decorationColor: isDark ? Colors.white54 : Colors.grey.shade500,
//       decorationThickness: 4,
//     );
//
//     final TextStyle priceStyle = TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w700,
//       color: theme.textTheme.bodyLarge?.color,
//       decoration: isReturn ? TextDecoration.lineThrough : TextDecoration.none,
//       decorationColor: isDark ? Colors.white54 : Colors.grey.shade500,
//       decorationThickness: 4,
//     );
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(item.name, style: itemStyle),
//
//               const SizedBox(height: 4),
//
//               Text(
//                 '${item.quantity} × '
//                 '${item.price.toStringAsFixed(2)} JD',
//                 style: detailsStyle,
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(width: 10),
//
//         Text('${item.total.toStringAsFixed(2)} JD', style: priceStyle),
//       ],
//     );
//   }
//
//   // ============================================================
//   // RECEIPT MONEY ROW
//   // ============================================================
//
//   Widget _receiptMoneyRow(
//     BuildContext context,
//     String label,
//     double value, {
//     bool large = false,
//     String prefix = '',
//     Color? valueColor,
//   }) {
//     final theme = Theme.of(context);
//
//     return Row(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: large ? 16 : 14,
//             fontWeight: large ? FontWeight.w800 : FontWeight.w500,
//             color: theme.textTheme.bodyLarge?.color,
//           ),
//         ),
//
//         const Spacer(),
//
//         Text(
//           '$prefix${value.toStringAsFixed(2)} JD',
//           style: TextStyle(
//             fontSize: large ? 17 : 14,
//             fontWeight: FontWeight.w800,
//             color: valueColor ?? theme.textTheme.bodyLarge?.color,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ============================================================
//   // BARCODE SECTION
//   // ============================================================
//
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         Center(
//           child: Text(
//             'Transaction Barcode',
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: theme.textTheme.bodyLarge?.color,
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 12),
//
//         GestureDetector(
//           onTap: () {
//             Clipboard.setData(ClipboardData(text: order.barcode));
//           },
//           child: SizedBox(
//             height: 75,
//             width: double.infinity,
//             child: CustomPaint(painter: _BarcodePainter(value: order.barcode)),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           order.barcode,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 1.5,
//             color: theme.textTheme.bodyLarge?.color,
//           ),
//         ),
//
//         const SizedBox(height: 4),
//
//         Text(
//           'Tap barcode to copy',
//           style: TextStyle(
//             fontSize: 10,
//             color: isDark ? Colors.white38 : Colors.grey.shade500,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ============================================================
// // RECEIPT TORN EDGE
// // ============================================================
//
// class _ReceiptTornClipper extends CustomClipper<Path> {
//   const _ReceiptTornClipper();
//
//   @override
//   Path getClip(Size size) {
//     const topBase = 8.0;
//     const bottomBase = 8.0;
//     const segment = 14.0;
//
//     const topPattern = [5.0, 2.0, 6.0, 3.0, 7.0, 2.5, 6.5, 3.5];
//
//     const bottomPattern = [4.0, 7.0, 3.0, 6.0, 2.0, 6.5, 3.0, 5.0];
//
//     final path = Path();
//
//     path.moveTo(0, topBase + topPattern.first);
//
//     var x = 0.0;
//     var i = 0;
//
//     while (x < size.width) {
//       final nextX = (x + segment).clamp(0.0, size.width);
//
//       final y = topBase + topPattern[i % topPattern.length];
//
//       path.lineTo(nextX, y);
//
//       x = nextX;
//       i++;
//     }
//
//     path.lineTo(size.width, size.height - (bottomBase + bottomPattern.first));
//
//     x = size.width;
//     i = 0;
//
//     while (x > 0) {
//       final nextX = (x - segment).clamp(0.0, size.width);
//
//       final y =
//           size.height - (bottomBase + bottomPattern[i % bottomPattern.length]);
//
//       path.lineTo(nextX, y);
//
//       x = nextX;
//       i++;
//     }
//
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
// // ============================================================
// // BARCODE
// // ============================================================
//
// class _BarcodePainter extends CustomPainter {
//   final String value;
//
//   const _BarcodePainter({required this.value});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     if (value.isEmpty) {
//       return;
//     }
//
//     final int hash = value.codeUnits.fold(
//       0,
//       (previous, element) => previous * 31 + element,
//     );
//
//     double x = 0;
//
//     int seed = hash.abs();
//
//     while (x < size.width) {
//       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
//
//       final width = 1.0 + (seed % 3).toDouble();
//
//       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
//
//       final gap = 1.0 + (seed % 3).toDouble();
//
//       canvas.drawRect(Rect.fromLTWH(x, 2, width, size.height - 4), paint);
//
//       x += width + gap;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _BarcodePainter oldDelegate) {
//     return oldDelegate.value != value;
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // import 'order.dart';
// //
// // class OrderDetailsScreen extends StatelessWidget {
// //   final Order order;
// //
// //   const OrderDetailsScreen({super.key, required this.order});
// //
// //   static const Color primaryColor = Color(0xFFA5005A);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Scaffold(
// //       backgroundColor: theme.scaffoldBackgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: Text(
// //           'Invoice Details',
// //           style: TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w700,
// //             color: theme.textTheme.titleLarge?.color,
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
// //         child: Column(
// //           children: [
// //             _buildOrderInformation(context),
// //             const SizedBox(height: 14),
// //             _buildReceipt(context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ============================================================
// //   // ORDER INFORMATION
// //   // ============================================================
// //   Widget _buildOrderInformation(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         color: theme.cardColor,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(
// //           color: isDark ? Colors.white.withOpacity(0.10) : Colors.grey.shade200,
// //         ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(isDark ? 0.18 : 0.04),
// //             blurRadius: 15,
// //             offset: const Offset(0, 6),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                 width: 48,
// //                 height: 48,
// //                 decoration: BoxDecoration(
// //                   color: primaryColor.withOpacity(0.10),
// //                   borderRadius: BorderRadius.circular(14),
// //                 ),
// //                 child: Icon(
// //                   order.isReturn
// //                       ? Icons.assignment_return_outlined
// //                       : Icons.receipt_long_outlined,
// //                   color: primaryColor,
// //                   size: 25,
// //                 ),
// //               ),
// //
// //               const SizedBox(width: 13),
// //
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       order.transactionType,
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w800,
// //                         color: theme.textTheme.bodyLarge?.color,
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 3),
// //
// //                     Text(
// //                       '#${order.orderNo}',
// //                       style: TextStyle(
// //                         fontSize: 13,
// //                         color: isDark ? Colors.white70 : Colors.grey.shade600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //           const SizedBox(height: 18),
// //
// //           _infoRow(context, label: 'Branch', value: order.branchName),
// //
// //           const SizedBox(height: 10),
// //
// //           _infoRow(context, label: 'Date', value: _formatDate(order.dateTime)),
// //
// //           const SizedBox(height: 10),
// //
// //           _infoRow(
// //             context,
// //             label: 'Transaction Type',
// //             value: order.transactionType,
// //             valueColor: primaryColor,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ============================================================
// //   // INFO ROW
// //   // ============================================================
// //   Widget _infoRow(
// //     BuildContext context, {
// //     required String label,
// //     required String value,
// //     Color? valueColor,
// //   }) {
// //     final theme = Theme.of(context);
// //
// //     return Row(
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: 13,
// //             color: Theme.of(context).brightness == Brightness.dark
// //                 ? Colors.white70
// //                 : Colors.grey.shade600,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //
// //         const Spacer(),
// //
// //         Flexible(
// //           child: Text(
// //             value,
// //             textAlign: TextAlign.end,
// //             style: TextStyle(
// //               fontSize: 13,
// //               color: valueColor ?? theme.textTheme.bodyLarge?.color,
// //               fontWeight: FontWeight.w700,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ============================================================
// //   // RECEIPT
// //   // ============================================================
// //   Widget _buildReceipt(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     final bool isReturn = order.isReturn;
// //
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 14, top: 8),
// //       decoration: BoxDecoration(
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(isDark ? 0.30 : 0.14),
// //             offset: const Offset(0, 10),
// //             blurRadius: 20,
// //             spreadRadius: 1,
// //           ),
// //         ],
// //       ),
// //       child: ClipPath(
// //         clipper: const _ReceiptTornClipper(),
// //         child: Container(
// //           width: double.infinity,
// //           padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
// //           decoration: BoxDecoration(
// //             color: theme.cardColor,
// //             border: Border.all(
// //               color: isDark
// //                   ? Colors.white.withOpacity(0.18)
// //                   : const Color(0xFFB8B8B8),
// //               width: 1.2,
// //             ),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Center(
// //                 child: Column(
// //                   children: [
// //                     const Text(
// //                       'SENSE',
// //                       style: TextStyle(
// //                         fontSize: 25,
// //                         fontWeight: FontWeight.w900,
// //                         letterSpacing: 2,
// //                         color: primaryColor,
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 5),
// //
// //                     Text(
// //                       isReturn ? 'RETURN RECEIPT' : 'SALES RECEIPT',
// //                       style: TextStyle(
// //                         fontSize: 13,
// //                         fontWeight: FontWeight.w800,
// //                         color: isDark ? Colors.white70 : Colors.grey.shade700,
// //                         letterSpacing: 1,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 14),
// //
// //               Divider(
// //                 color: isDark ? Colors.white24 : Colors.grey.shade300,
// //                 height: 1,
// //               ),
// //
// //               const SizedBox(height: 14),
// //
// //               _receiptKeyValue(context, 'Transaction No.', '#${order.orderNo}'),
// //
// //               const SizedBox(height: 7),
// //
// //               _receiptKeyValue(context, 'Branch', order.branchName),
// //
// //               const SizedBox(height: 7),
// //
// //               _receiptKeyValue(context, 'Date', _formatDate(order.dateTime)),
// //
// //               // ملاحظات الأوردر (لو موجودة)
// //               if (order.orderNotes.isNotEmpty) ...[
// //                 const SizedBox(height: 7),
// //                 _receiptKeyValue(context, 'Notes', order.orderNotes),
// //               ],
// //
// //               // طريقة الدفع (لو موجودة)
// //               if (order.paymentMethod != null &&
// //                   order.paymentMethod!.isNotEmpty) ...[
// //                 const SizedBox(height: 7),
// //                 _receiptKeyValue(context, 'Payment', order.paymentMethod!),
// //               ],
// //
// //               const SizedBox(height: 14),
// //
// //               // ⚠️ ملاحظة: `Order` ما فيه items
// //               // إذا بدك تعرض الـ items، لازم نجيبها من API تاني
// //               // (GetInvPOSTransactionsDetailsCallCenterParam)
// //               Divider(
// //                 color: isDark ? Colors.white24 : Colors.grey.shade300,
// //                 height: 1,
// //               ),
// //
// //               const SizedBox(height: 12),
// //
// //               _receiptMoneyRow(context, 'Subtotal', order.subtotal.toDouble()),
// //
// //               if (order.discount > 0) ...[
// //                 const SizedBox(height: 8),
// //
// //                 _receiptMoneyRow(
// //                   context,
// //                   'Discount',
// //                   order.discount.toDouble(),
// //                   valueColor: isDark
// //                       ? Colors.green.shade300
// //                       : Colors.green.shade700,
// //                   prefix: '-',
// //                 ),
// //               ],
// //
// //               const SizedBox(height: 12),
// //
// //               Divider(
// //                 color: isDark ? Colors.white38 : Colors.grey.shade400,
// //                 height: 1,
// //               ),
// //
// //               const SizedBox(height: 12),
// //
// //               _receiptMoneyRow(
// //                 context,
// //                 'Total',
// //                 order.total.toDouble(),
// //                 large: true,
// //               ),
// //
// //               const SizedBox(height: 18),
// //
// //               Divider(
// //                 color: isDark ? Colors.white24 : Colors.grey.shade300,
// //                 height: 1,
// //               ),
// //
// //               const SizedBox(height: 18),
// //
// //               _buildBarcodeSection(context),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ============================================================
// //   // RECEIPT KEY VALUE
// //   // ============================================================
// //   Widget _receiptKeyValue(BuildContext context, String key, String value) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           key,
// //           style: TextStyle(
// //             fontSize: 13,
// //             color: isDark ? Colors.white70 : Colors.grey.shade700,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //
// //         const Spacer(),
// //
// //         Flexible(
// //           child: Text(
// //             value,
// //             textAlign: TextAlign.end,
// //             style: TextStyle(
// //               fontSize: 13,
// //               fontWeight: FontWeight.w700,
// //               color: theme.textTheme.bodyLarge?.color,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ============================================================
// //   // RECEIPT MONEY ROW
// //   // ============================================================
// //   Widget _receiptMoneyRow(
// //     BuildContext context,
// //     String label,
// //     double value, {
// //     bool large = false,
// //     String prefix = '',
// //     Color? valueColor,
// //   }) {
// //     final theme = Theme.of(context);
// //
// //     return Row(
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: large ? 16 : 14,
// //             fontWeight: large ? FontWeight.w800 : FontWeight.w500,
// //             color: theme.textTheme.bodyLarge?.color,
// //           ),
// //         ),
// //
// //         const Spacer(),
// //
// //         Text(
// //           '$prefix${value.toStringAsFixed(2)} JD',
// //           style: TextStyle(
// //             fontSize: large ? 17 : 14,
// //             fontWeight: FontWeight.w800,
// //             color: valueColor ?? theme.textTheme.bodyLarge?.color,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ============================================================
// //   // BARCODE SECTION
// //   // ============================================================
// //   Widget _buildBarcodeSection(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     // ✅ نستخدم orderNo كـ barcode
// //     final barcodeValue = order.orderNo.toString();
// //
// //     return Column(
// //       children: [
// //         Center(
// //           child: Text(
// //             'Transaction Barcode',
// //             style: TextStyle(
// //               fontSize: 13,
// //               fontWeight: FontWeight.w600,
// //               color: theme.textTheme.bodyLarge?.color,
// //             ),
// //           ),
// //         ),
// //
// //         const SizedBox(height: 12),
// //
// //         GestureDetector(
// //           onTap: () {
// //             Clipboard.setData(ClipboardData(text: barcodeValue));
// //           },
// //           child: SizedBox(
// //             height: 75,
// //             width: double.infinity,
// //             child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
// //           ),
// //         ),
// //
// //         const SizedBox(height: 10),
// //
// //         Text(
// //           barcodeValue,
// //           style: TextStyle(
// //             fontSize: 13,
// //             fontWeight: FontWeight.w600,
// //             letterSpacing: 1.5,
// //             color: theme.textTheme.bodyLarge?.color,
// //           ),
// //         ),
// //
// //         const SizedBox(height: 4),
// //
// //         Text(
// //           'Tap barcode to copy',
// //           style: TextStyle(
// //             fontSize: 10,
// //             color: isDark ? Colors.white38 : Colors.grey.shade500,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ============================================================
// //   // FORMAT DATE
// //   // ============================================================
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
// //
// // // ============================================================
// // // RECEIPT TORN EDGE
// // // ============================================================
// // class _ReceiptTornClipper extends CustomClipper<Path> {
// //   const _ReceiptTornClipper();
// //
// //   @override
// //   Path getClip(Size size) {
// //     const topBase = 8.0;
// //     const bottomBase = 8.0;
// //     const segment = 14.0;
// //
// //     const topPattern = [5.0, 2.0, 6.0, 3.0, 7.0, 2.5, 6.5, 3.5];
// //     const bottomPattern = [4.0, 7.0, 3.0, 6.0, 2.0, 6.5, 3.0, 5.0];
// //
// //     final path = Path();
// //
// //     path.moveTo(0, topBase + topPattern.first);
// //
// //     var x = 0.0;
// //     var i = 0;
// //
// //     while (x < size.width) {
// //       final nextX = (x + segment).clamp(0.0, size.width);
// //       final y = topBase + topPattern[i % topPattern.length];
// //       path.lineTo(nextX, y);
// //       x = nextX;
// //       i++;
// //     }
// //
// //     path.lineTo(size.width, size.height - (bottomBase + bottomPattern.first));
// //
// //     x = size.width;
// //     i = 0;
// //
// //     while (x > 0) {
// //       final nextX = (x - segment).clamp(0.0, size.width);
// //       final y =
// //           size.height - (bottomBase + bottomPattern[i % bottomPattern.length]);
// //       path.lineTo(nextX, y);
// //       x = nextX;
// //       i++;
// //     }
// //
// //     path.close();
// //
// //     return path;
// //   }
// //
// //   @override
// //   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
// //     return false;
// //   }
// // }
// //
// // // ============================================================
// // // BARCODE PAINTER
// // // ============================================================
// // class _BarcodePainter extends CustomPainter {
// //   final String value;
// //
// //   const _BarcodePainter({required this.value});
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()
// //       ..color = Colors.black
// //       ..style = PaintingStyle.fill;
// //
// //     if (value.isEmpty) return;
// //
// //     final int hash = value.codeUnits.fold(
// //       0,
// //       (previous, element) => previous * 31 + element,
// //     );
// //
// //     double x = 0;
// //     int seed = hash.abs();
// //
// //     while (x < size.width) {
// //       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
// //       final width = 1.0 + (seed % 3).toDouble();
// //
// //       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
// //       final gap = 1.0 + (seed % 3).toDouble();
// //
// //       canvas.drawRect(Rect.fromLTWH(x, 2, width, size.height - 4), paint);
// //
// //       x += width + gap;
// //     }
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant _BarcodePainter oldDelegate) {
// //     return oldDelegate.value != value;
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Invoice Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: Column(
          children: [
            _buildOrderInformation(context),
            const SizedBox(height: 14),
            _buildReceipt(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ORDER INFORMATION
  // ============================================================
  Widget _buildOrderInformation(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.10) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.18 : 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  order.isReturn
                      ? Icons.assignment_return_outlined
                      : Icons.receipt_long_outlined,
                  color: primaryColor,
                  size: 25,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.transactionType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '#${order.orderNo}',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _infoRow(context, label: 'Branch', value: order.branchName),

          const SizedBox(height: 10),

          _infoRow(context, label: 'Date', value: _formatDate(order.dateTime)),

          const SizedBox(height: 10),

          _infoRow(
            context,
            label: 'Transaction Type',
            value: order.transactionType,
            valueColor: primaryColor,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================
  Widget _infoRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RECEIPT
  // ============================================================
  Widget _buildReceipt(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool isReturn = order.isReturn;

    return Container(
      margin: const EdgeInsets.only(bottom: 14, top: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.30 : 0.14),
            offset: const Offset(0, 10),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipPath(
        clipper: const _ReceiptTornClipper(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.18)
                  : const Color(0xFFB8B8B8),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      'SENSE',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      isReturn ? 'RETURN RECEIPT' : 'SALES RECEIPT',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 14),

              _receiptKeyValue(context, 'Transaction No.', '#${order.orderNo}'),

              const SizedBox(height: 7),

              _receiptKeyValue(context, 'Branch', order.branchName),

              const SizedBox(height: 7),

              _receiptKeyValue(context, 'Date', _formatDate(order.dateTime)),

              if (order.orderNotes.isNotEmpty) ...[
                const SizedBox(height: 7),
                _receiptKeyValue(context, 'Notes', order.orderNotes),
              ],

              if (order.paymentMethod != null &&
                  order.paymentMethod!.isNotEmpty) ...[
                const SizedBox(height: 7),
                _receiptKeyValue(context, 'Payment', order.paymentMethod!),
              ],

              const SizedBox(height: 14),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 12),

              _receiptMoneyRow(context, 'Subtotal', order.subtotal.toDouble()),

              if (order.discount > 0) ...[
                const SizedBox(height: 8),
                _receiptMoneyRow(
                  context,
                  'Discount',
                  order.discount.toDouble(),
                  valueColor: isDark
                      ? Colors.green.shade300
                      : Colors.green.shade700,
                  prefix: '-',
                ),
              ],

              const SizedBox(height: 12),

              Divider(
                color: isDark ? Colors.white38 : Colors.grey.shade400,
                height: 1,
              ),

              const SizedBox(height: 12),

              _receiptMoneyRow(
                context,
                'Total',
                order.total.toDouble(),
                large: true,
              ),

              const SizedBox(height: 18),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 18),

              _buildBarcodeSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // RECEIPT KEY VALUE
  // ============================================================
  Widget _receiptKeyValue(BuildContext context, String key, String value) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white70 : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RECEIPT MONEY ROW
  // ============================================================
  Widget _receiptMoneyRow(
    BuildContext context,
    String label,
    double value, {
    bool large = false,
    String prefix = '',
    Color? valueColor,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: large ? 16 : 14,
            fontWeight: large ? FontWeight.w800 : FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const Spacer(),

        Text(
          '$prefix${value.toStringAsFixed(2)} JD',
          style: TextStyle(
            fontSize: large ? 17 : 14,
            fontWeight: FontWeight.w800,
            color: valueColor ?? theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BARCODE SECTION
  // ============================================================
  Widget _buildBarcodeSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final barcodeValue = order.orderNo.toString();

    return Column(
      children: [
        Center(
          child: Text(
            'Transaction Barcode',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),

        const SizedBox(height: 12),

        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: barcodeValue));
          },
          child: SizedBox(
            height: 75,
            width: double.infinity,
            child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          barcodeValue,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Tap barcode to copy',
          style: TextStyle(
            fontSize: 10,
            color: isDark ? Colors.white38 : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FORMAT DATE
  // ============================================================
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

    return '${months[date.month - 1]} ${date.day}, ${date.year} • '
        '$hour:$minute $period';
  }
}

// ============================================================
// RECEIPT TORN EDGE
// ============================================================
class _ReceiptTornClipper extends CustomClipper<Path> {
  const _ReceiptTornClipper();

  @override
  Path getClip(Size size) {
    const topBase = 8.0;
    const bottomBase = 8.0;
    const segment = 14.0;

    const topPattern = [5.0, 2.0, 6.0, 3.0, 7.0, 2.5, 6.5, 3.5];
    const bottomPattern = [4.0, 7.0, 3.0, 6.0, 2.0, 6.5, 3.0, 5.0];

    final path = Path();

    path.moveTo(0, topBase + topPattern.first);

    var x = 0.0;
    var i = 0;

    while (x < size.width) {
      final nextX = (x + segment).clamp(0.0, size.width);
      final y = topBase + topPattern[i % topPattern.length];
      path.lineTo(nextX, y);
      x = nextX;
      i++;
    }

    path.lineTo(size.width, size.height - (bottomBase + bottomPattern.first));

    x = size.width;
    i = 0;

    while (x > 0) {
      final nextX = (x - segment).clamp(0.0, size.width);
      final y =
          size.height - (bottomBase + bottomPattern[i % bottomPattern.length]);
      path.lineTo(nextX, y);
      x = nextX;
      i++;
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ============================================================
// BARCODE PAINTER
// ============================================================
class _BarcodePainter extends CustomPainter {
  final String value;

  const _BarcodePainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    if (value.isEmpty) return;

    final int hash = value.codeUnits.fold(
      0,
      (previous, element) => previous * 31 + element,
    );

    double x = 0;
    int seed = hash.abs();

    while (x < size.width) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      final width = 1.0 + (seed % 3).toDouble();

      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      final gap = 1.0 + (seed % 3).toDouble();

      canvas.drawRect(Rect.fromLTWH(x, 2, width, size.height - 4), paint);

      x += width + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _BarcodePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
