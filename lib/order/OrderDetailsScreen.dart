// lib/order/OrderDetailsScreen.dart

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
//   Widget _buildOrderInformation(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final isReturn = order.transType == 2;
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
//                   isReturn
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
//                       order.transactionType.isNotEmpty
//                           ? order.transactionType
//                           : (isReturn ? 'مرتجع' : 'فاتورة'),
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
//                       '#${order.transactionNumber}',
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
//           _infoRow(context, label: 'Date', value: _formatDate(order.date)),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType.isNotEmpty
//                 ? order.transactionType
//                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//             valueColor: primaryColor,
//           ),
//
//           if (order.barcode.isNotEmpty) ...[
//             const SizedBox(height: 10),
//             _infoRow(context, label: 'Barcode', value: order.barcode),
//           ],
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // INFO ROW
//   // ============================================================
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
//   Widget _buildReceipt(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final bool isReturn = order.transType == 2;
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
//                 '#${order.transactionNumber}',
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', _formatDate(order.date)),
//
//               const SizedBox(height: 14),
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
//   // RECEIPT MONEY ROW
//   // ============================================================
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
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     // نستخدم barcode إن وُجد، وإلا رقم العملية
//     final barcodeValue = order.barcode.isNotEmpty
//         ? order.barcode
//         : order.transactionNumber;
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
//             Clipboard.setData(ClipboardData(text: barcodeValue));
//           },
//           child: SizedBox(
//             height: 75,
//             width: double.infinity,
//             child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           barcodeValue,
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
//
//   // ============================================================
//   // FORMAT DATE (String → String)
//   // ============================================================
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     final parsed = DateTime.tryParse(raw);
//     if (parsed == null) return raw;
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
//     final period = parsed.hour >= 12 ? 'PM' : 'AM';
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     return '${months[parsed.month - 1]} ${parsed.day}, ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }
//
// // ============================================================
// // RECEIPT TORN EDGE
// // ============================================================
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
//       final y = topBase + topPattern[i % topPattern.length];
//       path.lineTo(nextX, y);
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
//       final y =
//           size.height - (bottomBase + bottomPattern[i % bottomPattern.length]);
//       path.lineTo(nextX, y);
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
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
//
// // ============================================================
// // BARCODE PAINTER
// // ============================================================
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
//     if (value.isEmpty) return;
//
//     final int hash = value.codeUnits.fold(
//       0,
//       (previous, element) => previous * 31 + element,
//     );
//
//     double x = 0;
//     int seed = hash.abs();
//
//     while (x < size.width) {
//       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
//       final width = 1.0 + (seed % 3).toDouble();
//
//       seed = (seed * 1103515245 + 12345) & 0x7fffffff;
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'OrderModel.dart';
// import 'order_item.dart';
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
//     final isReturn = order.transType == 2;
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
//                   isReturn
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
//                       order.transactionType.isNotEmpty
//                           ? order.transactionType
//                           : (isReturn ? 'مرتجع' : 'فاتورة'),
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
//                       '#${order.transactionNumber}',
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
//           _infoRow(context, label: 'Date', value: _formatDate(order.date)),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType.isNotEmpty
//                 ? order.transactionType
//                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//             valueColor: primaryColor,
//           ),
//
//           if (order.barcode.isNotEmpty) ...[
//             const SizedBox(height: 10),
//             _infoRow(context, label: 'Barcode', value: order.barcode),
//           ],
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
//             color: theme.brightness == Brightness.dark
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
//     final bool isReturn = order.transType == 2;
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
//               // ==================================================
//               // SENSE
//               // ==================================================
//
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
//               // ==================================================
//               // TRANSACTION INFORMATION
//               // ==================================================
//               _receiptKeyValue(
//                 context,
//                 'Transaction No.',
//                 '#${order.transactionNumber}',
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', _formatDate(order.date)),
//
//               const SizedBox(height: 14),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 16),
//
//               // ==================================================
//               // SOLD ITEMS
//               // ==================================================
//               _buildItemsSection(context),
//
//               const SizedBox(height: 16),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // SUBTOTAL
//               // ==================================================
//               _receiptMoneyRow(context, 'Subtotal', order.subtotal),
//
//               // ==================================================
//               // DISCOUNT
//               // ==================================================
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
//               const SizedBox(height: 8),
//
//               _receiptMoneyRow(context, 'Tax', order.tax),
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
//               Divider(
//                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // TOTAL
//               // ==================================================
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
//               // ==================================================
//               // BARCODE
//               // ==================================================
//               _buildBarcodeSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEMS SECTION
//   // ============================================================
//
//   Widget _buildItemsSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final List<OrderItem> items = order.items;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // --------------------------------------------------------
//         // ITEMS TITLE
//         // --------------------------------------------------------
//
//         Row(
//           children: [
//             const Icon(
//               Icons.shopping_bag_outlined,
//               size: 20,
//               color: primaryColor,
//             ),
//
//             const SizedBox(width: 8),
//
//             Text(
//               'Items',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: theme.textTheme.bodyLarge?.color,
//               ),
//             ),
//
//             const Spacer(),
//
//             if (items.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '${items.length}',
//                   style: const TextStyle(
//                     color: primaryColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//
//         const SizedBox(height: 12),
//
//         // --------------------------------------------------------
//         // EMPTY
//         // --------------------------------------------------------
//         if (items.isEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.04)
//                   : Colors.grey.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withOpacity(0.08)
//                     : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.inventory_2_outlined,
//                   size: 28,
//                   color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 Text(
//                   'No items found',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         // --------------------------------------------------------
//         // ITEMS LIST
//         // --------------------------------------------------------
//         else
//           ...List.generate(items.length, (index) {
//             final item = items[index];
//
//             return Padding(
//               padding: EdgeInsets.only(
//                 bottom: index == items.length - 1 ? 0 : 10,
//               ),
//               child: _buildOrderItem(context, item),
//             );
//           }),
//       ],
//     );
//   }
//
//   // ============================================================
//   // SINGLE ORDER ITEM
//   // ============================================================
//
//   Widget _buildOrderItem(BuildContext context, OrderItem item) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.white.withOpacity(0.045)
//             : Colors.grey.withOpacity(0.045),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           // ======================================================
//           // ITEM NAME + TOTAL
//           // ======================================================
//
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu_outlined,
//                   color: primaryColor,
//                   size: 19,
//                 ),
//               ),
//
//               const SizedBox(width: 10),
//
//               Expanded(
//                 child: Text(
//                   item.name.isNotEmpty ? item.name : 'Unknown Item',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Text(
//                 '${item.total.toStringAsFixed(2)} JD',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           // ======================================================
//           // UNIT PRICE + QUANTITY
//           // ======================================================
//           Row(
//             children: [
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.sell_outlined,
//                   label: 'Unit Price',
//                   value: '${item.price.toStringAsFixed(2)} JD',
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.numbers_outlined,
//                   label: 'Quantity',
//                   value: '${item.quantity}',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEM SMALL INFO
//   // ============================================================
//
//   Widget _itemSmallInfo(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.black.withOpacity(0.10)
//             : Colors.white.withOpacity(0.70),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: isDark ? Colors.white54 : Colors.grey.shade600,
//           ),
//
//           const SizedBox(width: 6),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//
//                 const SizedBox(height: 2),
//
//                 Text(
//                   value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: theme.textTheme.bodyLarge?.color,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
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
//   // MONEY ROW
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
//   // BARCODE
//   // ============================================================
//
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final barcodeValue = order.barcode.isNotEmpty
//         ? order.barcode
//         : order.transactionNumber;
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
//             Clipboard.setData(ClipboardData(text: barcodeValue));
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Barcode copied'),
//                 duration: Duration(seconds: 1),
//               ),
//             );
//           },
//           child: SizedBox(
//             height: 75,
//             width: double.infinity,
//             child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           barcodeValue,
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
//
//   // ============================================================
//   // FORMAT DATE
//   // ============================================================
//
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     final parsed = DateTime.tryParse(raw);
//
//     if (parsed == null) return raw;
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
//
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     return '${months[parsed.month - 1]} '
//         '${parsed.day}, ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }
//
// // ============================================================
// // RECEIPT TORN CLIPPER
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
// // BARCODE PAINTER
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
//     if (value.isEmpty) return;
//
//     final int hash = value.codeUnits.fold(
//       0,
//       (previous, element) => previous * 31 + element,
//     );
//
//     double x = 0;
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'OrderModel.dart';
// import 'order_item.dart';
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
//     final isReturn = order.transType == 2;
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
//                   isReturn
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
//                       order.transactionType.isNotEmpty
//                           ? order.transactionType
//                           : (isReturn ? 'مرتجع' : 'فاتورة'),
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
//                       '#${order.transactionNumber}',
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
//           _infoRow(context, label: 'Date', value: _formatDate(order.date)),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType.isNotEmpty
//                 ? order.transactionType
//                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//             valueColor: primaryColor,
//           ),
//
//           if (order.barcode.isNotEmpty) ...[
//             const SizedBox(height: 10),
//             _infoRow(context, label: 'Barcode', value: order.barcode),
//           ],
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // INFO ROW  (✅ معدّلة: maxLines + Expanded)
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
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: theme.brightness == Brightness.dark
//                 ? Colors.white70
//                 : Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const SizedBox(width: 12),
//
//         // ✅ Expanded بدل Flexible + maxLines: 1
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//     final bool isReturn = order.transType == 2;
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
//               // ==================================================
//               // SENSE
//               // ==================================================
//
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
//               // ==================================================
//               // TRANSACTION INFORMATION
//               // ==================================================
//               _receiptKeyValue(
//                 context,
//                 'Transaction No.',
//                 '#${order.transactionNumber}',
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', _formatDate(order.date)),
//
//               const SizedBox(height: 14),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 16),
//
//               // ==================================================
//               // SOLD ITEMS
//               // ==================================================
//               _buildItemsSection(context),
//
//               const SizedBox(height: 16),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // SUBTOTAL
//               // ==================================================
//               _receiptMoneyRow(context, 'Subtotal', order.subtotal),
//
//               // ==================================================
//               // DISCOUNT
//               // ==================================================
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
//               const SizedBox(height: 8),
//
//               _receiptMoneyRow(context, 'Tax', order.tax),
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
//               Divider(
//                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // TOTAL
//               // ==================================================
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
//               // ==================================================
//               // BARCODE
//               // ==================================================
//               _buildBarcodeSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEMS SECTION
//   // ============================================================
//
//   // Widget _buildItemsSection(BuildContext context) {
//   //   final theme = Theme.of(context);
//   //   final isDark = theme.brightness == Brightness.dark;
//   //
//   //   final List<OrderItem> items = order.items;
//   //
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       // --------------------------------------------------------
//   //       // ITEMS TITLE
//   //       // --------------------------------------------------------
//   //
//   //       Row(
//   //         children: [
//   //           const Icon(
//   //             Icons.shopping_bag_outlined,
//   //             size: 20,
//   //             color: primaryColor,
//   //           ),
//   //
//   //           const SizedBox(width: 8),
//   //
//   //           Text(
//   //             'Items',
//   //             style: TextStyle(
//   //               fontSize: 16,
//   //               fontWeight: FontWeight.w800,
//   //               color: theme.textTheme.bodyLarge?.color,
//   //             ),
//   //           ),
//   //
//   //           const Spacer(),
//   //
//   //           if (items.isNotEmpty)
//   //             Container(
//   //               padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//   //               decoration: BoxDecoration(
//   //                 color: primaryColor.withOpacity(0.10),
//   //                 borderRadius: BorderRadius.circular(20),
//   //               ),
//   //               child: Text(
//   //                 '${items.length}',
//   //                 style: const TextStyle(
//   //                   color: primaryColor,
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.w800,
//   //                 ),
//   //               ),
//   //             ),
//   //         ],
//   //       ),
//   //
//   //       const SizedBox(height: 12),
//   //
//   //       // --------------------------------------------------------
//   //       // EMPTY
//   //       // --------------------------------------------------------
//   //       if (items.isEmpty)
//   //         Container(
//   //           width: double.infinity,
//   //           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//   //           decoration: BoxDecoration(
//   //             color: isDark
//   //                 ? Colors.white.withOpacity(0.04)
//   //                 : Colors.grey.withOpacity(0.06),
//   //             borderRadius: BorderRadius.circular(14),
//   //             border: Border.all(
//   //               color: isDark
//   //                   ? Colors.white.withOpacity(0.08)
//   //                   : Colors.grey.shade200,
//   //             ),
//   //           ),
//   //           child: Column(
//   //             children: [
//   //               Icon(
//   //                 Icons.inventory_2_outlined,
//   //                 size: 28,
//   //                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//   //               ),
//   //
//   //               const SizedBox(height: 8),
//   //
//   //               Text(
//   //                 'No items found',
//   //                 style: TextStyle(
//   //                   fontSize: 13,
//   //                   fontWeight: FontWeight.w600,
//   //                   color: isDark ? Colors.white54 : Colors.grey.shade500,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         )
//   //       // --------------------------------------------------------
//   //       // ITEMS LIST
//   //       // --------------------------------------------------------
//   //       else
//   //         ...List.generate(items.length, (index) {
//   //           final item = items[index];
//   //
//   //           return Padding(
//   //             padding: EdgeInsets.only(
//   //               bottom: index == items.length - 1 ? 0 : 10,
//   //             ),
//   //             child: _buildOrderItem(context, item),
//   //           );
//   //         }),
//   //     ],
//   //   );
//   // }
//   // ============================================================
//   // ITEMS SECTION - TABLE FORMAT
//   // ============================================================
//
//   Widget _buildItemsSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final List<OrderItem> items = order.items;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // --------------------------------------------------------
//         // ITEMS TITLE
//         // --------------------------------------------------------
//
//         Row(
//           children: [
//             const Icon(
//               Icons.shopping_bag_outlined,
//               size: 20,
//               color: primaryColor,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Items',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: theme.textTheme.bodyLarge?.color,
//               ),
//             ),
//             const Spacer(),
//             if (items.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '${items.length}',
//                   style: const TextStyle(
//                     color: primaryColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//
//         const SizedBox(height: 12),
//
//         // --------------------------------------------------------
//         // EMPTY
//         // --------------------------------------------------------
//         if (items.isEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.04)
//                   : Colors.grey.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withOpacity(0.08)
//                     : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.inventory_2_outlined,
//                   size: 28,
//                   color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No items found',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         // --------------------------------------------------------
//         // ITEMS TABLE
//         // --------------------------------------------------------
//         else
//           _buildItemsTable(context, items),
//       ],
//     );
//   }
//
//   // ============================================================
//   // ITEMS TABLE
//   // ============================================================
//
//   Widget _buildItemsTable(BuildContext context, List<OrderItem> items) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final borderColor = isDark
//         ? Colors.white.withOpacity(0.10)
//         : Colors.grey.shade300;
//     final headerColor = isDark
//         ? Colors.white.withOpacity(0.06)
//         : Colors.grey.shade100;
//     final rowAltColor = isDark
//         ? Colors.white.withOpacity(0.02)
//         : Colors.grey.shade50;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: borderColor),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           children: [
//             // ======================================================
//             // TABLE HEADER
//             // ======================================================
//             Container(
//               color: headerColor,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Row(
//                 children: [
//                   // Item name
//                   Expanded(
//                     flex: 5,
//                     child: Text(
//                       'Item',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Quantity
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Qty',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Unit Price
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Price',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Total
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Total',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ======================================================
//             // TABLE ROWS
//             // ======================================================
//             ...List.generate(items.length, (index) {
//               final item = items[index];
//               final isLast = index == items.length - 1;
//
//               return Container(
//                 color: index.isOdd ? rowAltColor : Colors.transparent,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Item name
//                     Expanded(
//                       flex: 5,
//                       child: Text(
//                         item.name.isNotEmpty ? item.name : 'Unknown Item',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//                     // Quantity
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         '${item.quantity}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//                     // Unit Price
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '${item.price.toStringAsFixed(2)}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//                     // Total
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '${item.total.toStringAsFixed(2)} JD',
//                         textAlign: TextAlign.end,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w800,
//                           color: primaryColor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//   // ============================================================
//   // SINGLE ORDER ITEM
//   // ============================================================
//
//   Widget _buildOrderItem(BuildContext context, OrderItem item) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.white.withOpacity(0.045)
//             : Colors.grey.withOpacity(0.045),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           // ======================================================
//           // ITEM NAME + TOTAL
//           // ======================================================
//
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu_outlined,
//                   color: primaryColor,
//                   size: 19,
//                 ),
//               ),
//
//               const SizedBox(width: 10),
//
//               Expanded(
//                 child: Text(
//                   item.name.isNotEmpty ? item.name : 'Unknown Item',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Text(
//                 '${item.total.toStringAsFixed(2)} JD',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           // ======================================================
//           // UNIT PRICE + QUANTITY
//           // ======================================================
//           Row(
//             children: [
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.sell_outlined,
//                   label: 'Unit Price',
//                   value: '${item.price.toStringAsFixed(2)} JD',
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.numbers_outlined,
//                   label: 'Quantity',
//                   value: '${item.quantity}',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEM SMALL INFO
//   // ============================================================
//
//   Widget _itemSmallInfo(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.black.withOpacity(0.10)
//             : Colors.white.withOpacity(0.70),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: isDark ? Colors.white54 : Colors.grey.shade600,
//           ),
//
//           const SizedBox(width: 6),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//
//                 const SizedBox(height: 2),
//
//                 Text(
//                   value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: theme.textTheme.bodyLarge?.color,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // RECEIPT KEY VALUE  (✅ معدّلة: maxLines + Expanded)
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
//         const SizedBox(width: 12),
//
//         // ✅ Expanded + maxLines: 1
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//   // MONEY ROW
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
//   // BARCODE
//   // ============================================================
//
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final isDark = theme.brightness == Brightness.dark;
//
//     // final barcodeValue = order.barcode.isNotEmpty
//     //     ? order.barcode
//     //     : order.transactionNumber;
//     final barcodeValue = order.compositeBarcode;
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
//             Clipboard.setData(ClipboardData(text: barcodeValue));
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Barcode copied'),
//                 duration: Duration(seconds: 1),
//               ),
//             );
//           },
//           child: SizedBox(
//             height: 75,
//             width: double.infinity,
//             child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           barcodeValue,
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
//
//   // ============================================================
//   // FORMAT DATE  (✅ صيغة مختصرة: 6 Nov 2025 • 3:27 PM)
//   // ============================================================
//
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     final parsed = DateTime.tryParse(raw);
//
//     if (parsed == null) return raw;
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
//
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     // ✅ صيغة مختصرة (اليوم قبل الشهر)
//     return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }
//
// // ============================================================
// // RECEIPT TORN CLIPPER
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
// // BARCODE PAINTER
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
//     if (value.isEmpty) return;
//
//     final int hash = value.codeUnits.fold(
//       0,
//       (previous, element) => previous * 31 + element,
//     );
//
//     double x = 0;
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'OrderModel.dart';
// import 'order_item.dart';
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
//     final isReturn = order.transType == 2;
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
//                   isReturn
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
//                       order.transactionType.isNotEmpty
//                           ? order.transactionType
//                           : (isReturn ? 'مرتجع' : 'فاتورة'),
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
//                       '#${order.transactionNumber}',
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
//           _infoRow(context, label: 'Date', value: _formatDate(order.date)),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType.isNotEmpty
//                 ? order.transactionType
//                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//             valueColor: primaryColor,
//           ),
//
//           if (order.barcode.isNotEmpty) ...[
//             const SizedBox(height: 10),
//             _infoRow(context, label: 'Barcode', value: order.barcode),
//           ],
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
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: theme.brightness == Brightness.dark
//                 ? Colors.white70
//                 : Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const SizedBox(width: 12),
//
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//     final bool isReturn = order.transType == 2;
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
//               // ==================================================
//               // SENSE
//               // ==================================================
//
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
//               // ==================================================
//               // TRANSACTION INFORMATION
//               // ==================================================
//               _receiptKeyValue(
//                 context,
//                 'Transaction No.',
//                 '#${order.transactionNumber}',
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', _formatDate(order.date)),
//
//               const SizedBox(height: 14),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 16),
//
//               // ==================================================
//               // SOLD ITEMS
//               // ==================================================
//               _buildItemsSection(context),
//
//               const SizedBox(height: 16),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // SUBTOTAL
//               // ==================================================
//               _receiptMoneyRow(context, 'Subtotal', order.subtotal),
//
//               // ==================================================
//               // DISCOUNT
//               // ==================================================
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
//               const SizedBox(height: 8),
//
//               _receiptMoneyRow(context, 'Tax', order.tax),
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
//               Divider(
//                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // TOTAL
//               // ==================================================
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
//               // ==================================================
//               // BARCODE
//               // ==================================================
//               _buildBarcodeSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEMS SECTION - TABLE FORMAT
//   // ============================================================
//
//   Widget _buildItemsSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final List<OrderItem> items = order.items;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // --------------------------------------------------------
//         // ITEMS TITLE
//         // --------------------------------------------------------
//
//         Row(
//           children: [
//             const Icon(
//               Icons.shopping_bag_outlined,
//               size: 20,
//               color: primaryColor,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Items',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: theme.textTheme.bodyLarge?.color,
//               ),
//             ),
//             const Spacer(),
//             if (items.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '${items.length}',
//                   style: const TextStyle(
//                     color: primaryColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//
//         const SizedBox(height: 12),
//
//         // --------------------------------------------------------
//         // EMPTY
//         // --------------------------------------------------------
//         if (items.isEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.04)
//                   : Colors.grey.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withOpacity(0.08)
//                     : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.inventory_2_outlined,
//                   size: 28,
//                   color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No items found',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         // --------------------------------------------------------
//         // ITEMS TABLE
//         // --------------------------------------------------------
//         else
//           _buildItemsTable(context, items),
//       ],
//     );
//   }
//
//   // ============================================================
//   // ITEMS TABLE
//   // ============================================================
//
//   Widget _buildItemsTable(BuildContext context, List<OrderItem> items) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final borderColor = isDark
//         ? Colors.white.withOpacity(0.10)
//         : Colors.grey.shade300;
//     final headerColor = isDark
//         ? Colors.white.withOpacity(0.06)
//         : Colors.grey.shade100;
//     final rowAltColor = isDark
//         ? Colors.white.withOpacity(0.02)
//         : Colors.grey.shade50;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: borderColor),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           children: [
//             // ======================================================
//             // TABLE HEADER
//             // ======================================================
//             Container(
//               color: headerColor,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Row(
//                 children: [
//                   // Item name
//                   Expanded(
//                     flex: 5,
//                     child: Text(
//                       'Description',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Quantity
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Qty',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Unit Price
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Price',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   // Total
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Total',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ======================================================
//             // TABLE ROWS
//             // ======================================================
//             ...List.generate(items.length, (index) {
//               final item = items[index];
//
//               // السعر الأصلي قبل الخصم
//               final double originalTotal = item.price * item.quantity;
//
//               // السعر النهائي بعد الخصم
//               final double finalTotal = item.total;
//
//               // هل يوجد خصم على هذا العنصر؟
//               final bool hasDiscount = originalTotal > finalTotal + 0.001;
//
//               return Container(
//                 color: index.isOdd ? rowAltColor : Colors.transparent,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ------------------------------------------------
//                     // ITEM NAME
//                     // ------------------------------------------------
//                     Expanded(
//                       flex: 5,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.name.isNotEmpty ? item.name : 'Unknown Item',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: theme.textTheme.bodyLarge?.color,
//                             ),
//                           ),
//
//                           // شارة الخصم
//                           if (hasDiscount) ...[
//                             const SizedBox(height: 3),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                                 vertical: 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.withOpacity(0.12),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'Discounted',
//                                 style: TextStyle(
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.w700,
//                                   color: isDark
//                                       ? Colors.green.shade300
//                                       : Colors.green.shade700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//
//                     // ------------------------------------------------
//                     // QUANTITY
//                     // ------------------------------------------------
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         '${item.quantity}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//
//                     // ------------------------------------------------
//                     // UNIT PRICE
//                     // ------------------------------------------------
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '${item.price.toStringAsFixed(3)}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//
//                     // ------------------------------------------------
//                     // TOTAL - مع السعر الأصلي مشطوب
//                     // ------------------------------------------------
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // السعر الأصلي مشطوب (فقط لو فيه خصم)
//                           if (hasDiscount)
//                             Text(
//                               '${originalTotal.toStringAsFixed(3)}',
//                               textAlign: TextAlign.end,
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: isDark
//                                     ? Colors.white38
//                                     : Colors.grey.shade500,
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationColor: isDark
//                                     ? Colors.white38
//                                     : Colors.grey.shade500,
//                                 decorationThickness: 1.5,
//                               ),
//                             ),
//
//                           // السعر النهائي
//                           Text(
//                             '${finalTotal.toStringAsFixed(3)} JD',
//                             textAlign: TextAlign.end,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w800,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // SINGLE ORDER ITEM (غير مستخدمة الآن - محتفظ بها للرجوع)
//   // ============================================================
//
//   Widget _buildOrderItem(BuildContext context, OrderItem item) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.white.withOpacity(0.045)
//             : Colors.grey.withOpacity(0.045),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu_outlined,
//                   color: primaryColor,
//                   size: 19,
//                 ),
//               ),
//
//               const SizedBox(width: 10),
//
//               Expanded(
//                 child: Text(
//                   item.name.isNotEmpty ? item.name : 'Unknown Item',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Text(
//                 '${item.total.toStringAsFixed(3)} JD',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           Row(
//             children: [
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.sell_outlined,
//                   label: 'Unit Price',
//                   value: '${item.price.toStringAsFixed(3)} JD',
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.numbers_outlined,
//                   label: 'Quantity',
//                   value: '${item.quantity}',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEM SMALL INFO
//   // ============================================================
//
//   Widget _itemSmallInfo(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.black.withOpacity(0.10)
//             : Colors.white.withOpacity(0.70),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: isDark ? Colors.white54 : Colors.grey.shade600,
//           ),
//
//           const SizedBox(width: 6),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//
//                 const SizedBox(height: 2),
//
//                 Text(
//                   value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: theme.textTheme.bodyLarge?.color,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
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
//         const SizedBox(width: 12),
//
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//   // MONEY ROW
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
//           '$prefix${value.toStringAsFixed(3)} JD',
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
//   // BARCODE
//   // ============================================================
//
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final isDark = theme.brightness == Brightness.dark;
//
//     final barcodeValue = order.compositeBarcode;
//
//     return Column(
//       children: [
//         // Center(
//         //   child:
//         //   Text(
//         //     'Transaction Barcode',
//         //     style: TextStyle(
//         //       fontSize: 13,
//         //       fontWeight: FontWeight.w600,
//         //       color: theme.textTheme.bodyLarge?.color,
//         //     ),
//         //   ),
//         // ),
//
//         const SizedBox(height: 12),
//
//         GestureDetector(
//           onTap: () {
//             Clipboard.setData(ClipboardData(text: barcodeValue));
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Barcode copied'),
//                 duration: Duration(seconds: 1),
//               ),
//             );
//           },
//           child: SizedBox(
//             height: 75,
//             width: double.infinity,
//             child: CustomPaint(painter: _BarcodePainter(value: barcodeValue)),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           barcodeValue,
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
//
//   // ============================================================
//   // FORMAT DATE
//   // ============================================================
//
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     final parsed = DateTime.tryParse(raw);
//
//     if (parsed == null) return raw;
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
//
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }
//
// // ============================================================
// // RECEIPT TORN CLIPPER
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
// // BARCODE PAINTER
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
//     if (value.isEmpty) return;
//
//     final int hash = value.codeUnits.fold(
//       0,
//       (previous, element) => previous * 31 + element,
//     );
//
//     double x = 0;
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

// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'OrderModel.dart';
// import 'order_item.dart';
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
//     final isReturn = order.transType == 2;
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
//                   isReturn
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
//                       order.transactionType.isNotEmpty
//                           ? order.transactionType
//                           : (isReturn ? 'مرتجع' : 'فاتورة'),
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
//                       '#${order.transactionNumber}',
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
//           _infoRow(context, label: 'Date', value: _formatDate(order.date)),
//
//           const SizedBox(height: 10),
//
//           _infoRow(
//             context,
//             label: 'Transaction Type',
//             value: order.transactionType.isNotEmpty
//                 ? order.transactionType
//                 : (isReturn ? 'مرتجع' : 'فاتورة'),
//             valueColor: primaryColor,
//           ),
//
//           if (order.barcode.isNotEmpty) ...[
//             const SizedBox(height: 10),
//             _infoRow(context, label: 'Barcode', value: order.barcode),
//           ],
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
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: theme.brightness == Brightness.dark
//                 ? Colors.white70
//                 : Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const SizedBox(width: 12),
//
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//     final bool isReturn = order.transType == 2;
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
//               // ==================================================
//               // SENSE
//               // ==================================================
//
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
//               // ==================================================
//               // TRANSACTION INFORMATION
//               // ==================================================
//               _receiptKeyValue(
//                 context,
//                 'Transaction No.',
//                 '#${order.transactionNumber}',
//               ),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Branch', order.branchName),
//
//               const SizedBox(height: 7),
//
//               _receiptKeyValue(context, 'Date', _formatDate(order.date)),
//
//               const SizedBox(height: 14),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 16),
//
//               // ==================================================
//               // SOLD ITEMS
//               // ==================================================
//               _buildItemsSection(context),
//
//               const SizedBox(height: 16),
//
//               Divider(
//                 color: isDark ? Colors.white24 : Colors.grey.shade300,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // SUBTOTAL
//               // ==================================================
//               _receiptMoneyRow(context, 'Subtotal', order.subtotal),
//
//               // ==================================================
//               // DISCOUNT
//               // ==================================================
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
//               const SizedBox(height: 8),
//
//               _receiptMoneyRow(context, 'Tax', order.tax),
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
//               Divider(
//                 color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 height: 1,
//               ),
//
//               const SizedBox(height: 12),
//
//               // ==================================================
//               // TOTAL
//               // ==================================================
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
//               // ==================================================
//               // BARCODE
//               // ==================================================
//               _buildBarcodeSection(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEMS SECTION - TABLE FORMAT
//   // ============================================================
//
//   Widget _buildItemsSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final List<OrderItem> items = order.items;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // --------------------------------------------------------
//         // ITEMS TITLE
//         // --------------------------------------------------------
//
//         Row(
//           children: [
//             const Icon(
//               Icons.shopping_bag_outlined,
//               size: 20,
//               color: primaryColor,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Items',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 color: theme.textTheme.bodyLarge?.color,
//               ),
//             ),
//             const Spacer(),
//             if (items.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '${items.length}',
//                   style: const TextStyle(
//                     color: primaryColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//
//         const SizedBox(height: 12),
//
//         // --------------------------------------------------------
//         // EMPTY
//         // --------------------------------------------------------
//         if (items.isEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.04)
//                   : Colors.grey.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withOpacity(0.08)
//                     : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.inventory_2_outlined,
//                   size: 28,
//                   color: isDark ? Colors.white38 : Colors.grey.shade400,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No items found',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         // --------------------------------------------------------
//         // ITEMS TABLE
//         // --------------------------------------------------------
//         else
//           _buildItemsTable(context, items),
//       ],
//     );
//   }
//
//   // ============================================================
//   // ITEMS TABLE
//   // ============================================================
//
//   Widget _buildItemsTable(BuildContext context, List<OrderItem> items) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final borderColor = isDark
//         ? Colors.white.withOpacity(0.10)
//         : Colors.grey.shade300;
//     final headerColor = isDark
//         ? Colors.white.withOpacity(0.06)
//         : Colors.grey.shade100;
//     final rowAltColor = isDark
//         ? Colors.white.withOpacity(0.02)
//         : Colors.grey.shade50;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: borderColor),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Column(
//           children: [
//             // ======================================================
//             // TABLE HEADER
//             // ======================================================
//             Container(
//               color: headerColor,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: Text(
//                       'Description',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Qty',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Price',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       'Total',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         color: theme.textTheme.bodyLarge?.color,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // ======================================================
//             // TABLE ROWS
//             // ======================================================
//             ...List.generate(items.length, (index) {
//               final item = items[index];
//
//               final double originalTotal = item.price * item.quantity;
//
//               final double finalTotal = item.total;
//
//               final bool hasDiscount = originalTotal > finalTotal + 0.001;
//
//               return Container(
//                 color: index.isOdd ? rowAltColor : Colors.transparent,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 5,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.name.isNotEmpty ? item.name : 'Unknown Item',
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: theme.textTheme.bodyLarge?.color,
//                             ),
//                           ),
//
//                           if (hasDiscount) ...[
//                             const SizedBox(height: 3),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                                 vertical: 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.withOpacity(0.12),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'Discounted',
//                                 style: TextStyle(
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.w700,
//                                   color: isDark
//                                       ? Colors.green.shade300
//                                       : Colors.green.shade700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         '${item.quantity}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '${item.price.toStringAsFixed(3)}',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: theme.textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ),
//
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           if (hasDiscount)
//                             Text(
//                               '${originalTotal.toStringAsFixed(3)}',
//                               textAlign: TextAlign.end,
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: isDark
//                                     ? Colors.white38
//                                     : Colors.grey.shade500,
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationColor: isDark
//                                     ? Colors.white38
//                                     : Colors.grey.shade500,
//                                 decorationThickness: 1.5,
//                               ),
//                             ),
//
//                           Text(
//                             '${finalTotal.toStringAsFixed(3)} JD',
//                             textAlign: TextAlign.end,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w800,
//                               color: primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ============================================================
//   // SINGLE ORDER ITEM (غير مستخدمة الآن - محتفظ بها للرجوع)
//   // ============================================================
//
//   Widget _buildOrderItem(BuildContext context, OrderItem item) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.white.withOpacity(0.045)
//             : Colors.grey.withOpacity(0.045),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: primaryColor.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu_outlined,
//                   color: primaryColor,
//                   size: 19,
//                 ),
//               ),
//
//               const SizedBox(width: 10),
//
//               Expanded(
//                 child: Text(
//                   item.name.isNotEmpty ? item.name : 'Unknown Item',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w800,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Text(
//                 '${item.total.toStringAsFixed(3)} JD',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900,
//                   color: primaryColor,
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           Row(
//             children: [
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.sell_outlined,
//                   label: 'Unit Price',
//                   value: '${item.price.toStringAsFixed(3)} JD',
//                 ),
//               ),
//
//               const SizedBox(width: 8),
//
//               Expanded(
//                 child: _itemSmallInfo(
//                   context,
//                   icon: Icons.numbers_outlined,
//                   label: 'Quantity',
//                   value: '${item.quantity}',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ============================================================
//   // ITEM SMALL INFO
//   // ============================================================
//
//   Widget _itemSmallInfo(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
//       decoration: BoxDecoration(
//         color: isDark
//             ? Colors.black.withOpacity(0.10)
//             : Colors.white.withOpacity(0.70),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 14,
//             color: isDark ? Colors.white54 : Colors.grey.shade600,
//           ),
//
//           const SizedBox(width: 6),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//
//                 const SizedBox(height: 2),
//
//                 Text(
//                   value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: theme.textTheme.bodyLarge?.color,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
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
//         const SizedBox(width: 12),
//
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             maxLines: 1,
//             softWrap: false,
//             overflow: TextOverflow.ellipsis,
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
//   // MONEY ROW
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
//           '$prefix${value.toStringAsFixed(3)} JD',
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
//   // BARCODE  ✅ قابل للمسح (Code128) + يأخذ القيمة من الـ API
//   // ============================================================
//
//   Widget _buildBarcodeSection(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     // ✅ نستخدم اللي جاي من الـ API مباشرة
//     final barcodeValue = order.barcode;
//
//     if (barcodeValue.trim().isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Column(
//       children: [
//         const SizedBox(height: 12),
//
//         GestureDetector(
//           onTap: () {
//             Clipboard.setData(ClipboardData(text: barcodeValue));
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Barcode copied'),
//                 duration: Duration(seconds: 1),
//               ),
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
//             decoration: BoxDecoration(
//               color: Colors.white, // ✅ خلفية بيضاء ضرورية للمسح
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: BarcodeWidget(
//               barcode: Barcode.code128(), // ✅ معيار حقيقي قابل للمسح
//               data: barcodeValue,
//               width: double.infinity,
//               height: 75,
//               drawText: false,
//               color: Colors.black,
//               backgroundColor: Colors.white,
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 10),
//
//         Text(
//           barcodeValue,
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
//
//   // ============================================================
//   // FORMAT DATE
//   // ============================================================
//
//   String _formatDate(String raw) {
//     if (raw.trim().isEmpty) return '';
//
//     final parsed = DateTime.tryParse(raw);
//
//     if (parsed == null) return raw;
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
//
//     final minute = parsed.minute.toString().padLeft(2, '0');
//
//     return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year} • '
//         '$hour:$minute $period';
//   }
// }
//
// // ============================================================
// // RECEIPT TORN CLIPPER
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

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'OrderModel.dart';
import 'order_item.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

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
    final isReturn = order.transType == 2;

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
                  isReturn
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
                      order.transactionType.isNotEmpty
                          ? order.transactionType
                          : (isReturn ? 'مرتجع' : 'فاتورة'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '#${order.transactionNumber}',
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

          _infoRow(context, label: 'Date', value: _formatDate(order.date)),

          const SizedBox(height: 10),

          _infoRow(
            context,
            label: 'Transaction Type',
            value: order.transactionType.isNotEmpty
                ? order.transactionType
                : (isReturn ? 'مرتجع' : 'فاتورة'),
            valueColor: primaryColor,
          ),

          if (order.barcode.isNotEmpty) ...[
            const SizedBox(height: 10),
            _infoRow(context, label: 'Barcode', value: order.barcode),
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: theme.brightness == Brightness.dark
                ? Colors.white70
                : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
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
    final bool isReturn = order.transType == 2;

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
              // ==================================================
              // SENSE
              // ==================================================

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

              // ==================================================
              // TRANSACTION INFORMATION
              // ==================================================
              _receiptKeyValue(
                context,
                'Transaction No.',
                '#${order.transactionNumber}',
              ),

              const SizedBox(height: 7),

              _receiptKeyValue(context, 'Branch', order.branchName),

              const SizedBox(height: 7),

              _receiptKeyValue(context, 'Date', _formatDate(order.date)),

              const SizedBox(height: 14),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 16),

              // ==================================================
              // SOLD ITEMS
              // ==================================================
              _buildItemsSection(context),

              const SizedBox(height: 16),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 12),

              // ==================================================
              // SUBTOTAL
              // ==================================================
              _receiptMoneyRow(context, 'Subtotal', order.subtotal),

              // ==================================================
              // DISCOUNT
              // ==================================================
              if (order.discount > 0) ...[
                const SizedBox(height: 8),

                _receiptMoneyRow(
                  context,
                  'Discount',
                  order.discount,
                  valueColor: isDark
                      ? Colors.green.shade300
                      : Colors.green.shade700,
                  prefix: '-',
                ),
              ],
              const SizedBox(height: 8),

              _receiptMoneyRow(context, 'Tax', order.tax),

              const SizedBox(height: 12),

              Divider(
                color: isDark ? Colors.white38 : Colors.grey.shade400,
                height: 1,
              ),

              const SizedBox(height: 12),

              Divider(
                color: isDark ? Colors.white38 : Colors.grey.shade400,
                height: 1,
              ),

              const SizedBox(height: 12),

              // ==================================================
              // TOTAL
              // ==================================================
              _receiptMoneyRow(context, 'Total', order.total, large: true),

              const SizedBox(height: 18),

              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                height: 1,
              ),

              const SizedBox(height: 18),

              // ==================================================
              // BARCODE
              // ==================================================
              _buildBarcodeSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ITEMS SECTION - TABLE FORMAT
  // ============================================================

  Widget _buildItemsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<OrderItem> items = order.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------
        // ITEMS TITLE
        // --------------------------------------------------------

        Row(
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 20,
              color: primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const Spacer(),
            if (items.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${items.length}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 12),

        // --------------------------------------------------------
        // EMPTY
        // --------------------------------------------------------
        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.04)
                  : Colors.grey.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.grey.shade200,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 28,
                  color: isDark ? Colors.white38 : Colors.grey.shade400,
                ),
                const SizedBox(height: 8),
                Text(
                  'No items found',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          )
        // --------------------------------------------------------
        // ITEMS TABLE
        // --------------------------------------------------------
        else
          _buildItemsTable(context, items),
      ],
    );
  }

  // ============================================================
  // ITEMS TABLE
  // ============================================================

  Widget _buildItemsTable(BuildContext context, List<OrderItem> items) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor = isDark
        ? Colors.white.withOpacity(0.10)
        : Colors.grey.shade300;
    final headerColor = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.grey.shade100;
    final rowAltColor = isDark
        ? Colors.white.withOpacity(0.02)
        : Colors.grey.shade50;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // ======================================================
            // TABLE HEADER
            // ======================================================
            Container(
              color: headerColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Qty',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Price',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Total',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ======================================================
            // TABLE ROWS
            // ======================================================
            ...List.generate(items.length, (index) {
              final item = items[index];

              final double originalTotal = item.price * item.quantity;

              final double finalTotal = item.total;

              final bool hasDiscount = originalTotal > finalTotal + 0.001;

              return Container(
                color: index.isOdd ? rowAltColor : Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name.isNotEmpty ? item.name : 'Unknown Item',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),

                          if (hasDiscount) ...[
                            const SizedBox(height: 3),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Discounted',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.green.shade300
                                      : Colors.green.shade700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Text(
                        '${item.quantity}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Text(
                        '${item.price.toStringAsFixed(3)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (hasDiscount)
                            Text(
                              '${originalTotal.toStringAsFixed(3)}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: isDark
                                    ? Colors.white38
                                    : Colors.grey.shade500,
                                decorationThickness: 1.5,
                              ),
                            ),

                          Text(
                            '${finalTotal.toStringAsFixed(3)} JD',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SINGLE ORDER ITEM (غير مستخدمة الآن - محتفظ بها للرجوع)
  // ============================================================

  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.045)
            : Colors.grey.withOpacity(0.045),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.restaurant_menu_outlined,
                  color: primaryColor,
                  size: 19,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  item.name.isNotEmpty ? item.name : 'Unknown Item',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Text(
                '${item.total.toStringAsFixed(3)} JD',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _itemSmallInfo(
                  context,
                  icon: Icons.sell_outlined,
                  label: 'Unit Price',
                  value: '${item.price.toStringAsFixed(3)} JD',
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _itemSmallInfo(
                  context,
                  icon: Icons.numbers_outlined,
                  label: 'Quantity',
                  value: '${item.quantity}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ITEM SMALL INFO
  // ============================================================

  Widget _itemSmallInfo(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.black.withOpacity(0.10)
            : Colors.white.withOpacity(0.70),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: isDark ? Colors.white54 : Colors.grey.shade600,
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9,
                    color: isDark ? Colors.white54 : Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
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

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
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
  // MONEY ROW
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
          '$prefix${value.toStringAsFixed(3)} JD',
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
  // BARCODE SECTION ✅ عند الضغط يظهر Dialog بحجم أكبر
  // ============================================================

  Widget _buildBarcodeSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final barcodeValue = order.barcode;

    if (barcodeValue.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => _showBarcodeDialog(context, barcodeValue),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white, // خلفية بيضاء ضرورية للمسح
              borderRadius: BorderRadius.circular(8),
            ),
            child: BarcodeWidget(
              barcode: Barcode.code128(),
              data: barcodeValue,
              width: double.infinity,
              height: 75,
              drawText: false,
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
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
          'Tap barcode to enlarge',
          style: TextStyle(
            fontSize: 10,
            color: isDark ? Colors.white38 : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BARCODE DIALOG
  // ============================================================

  void _showBarcodeDialog(BuildContext context, String barcodeValue) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ==============================
                // TITLE
                // ==============================
                Row(
                  children: [
                    const Icon(Icons.qr_code_2, color: primaryColor, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Barcode',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white70 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Divider(
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                  height: 1,
                ),

                const SizedBox(height: 20),

                // ==============================
                // BIG BARCODE
                // ==============================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.15)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: barcodeValue,
                    width: double.infinity,
                    height: 140,
                    drawText: false,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                // ==============================
                // BARCODE VALUE
                // ==============================
                SelectableText(
                  barcodeValue,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.5,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),

                const SizedBox(height: 20),

                // ==============================
                // COPY BUTTON
                // ==============================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: barcodeValue));
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Barcode copied'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text(
                      'Copy Barcode',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // FORMAT DATE
  // ============================================================

  String _formatDate(String raw) {
    if (raw.trim().isEmpty) return '';

    final parsed = DateTime.tryParse(raw);

    if (parsed == null) return raw;

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

    return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year} • '
        '$hour:$minute $period';
  }
}

// ============================================================
// RECEIPT TORN CLIPPER
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
