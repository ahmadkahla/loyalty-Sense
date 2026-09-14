// // import 'package:flutter/material.dart';
// //
// // class TransactionsScreen extends StatelessWidget {
// //   const TransactionsScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     return Scaffold(
// //       backgroundColor: theme.scaffoldBackgroundColor,
// //
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: Text(
// //           'Transactions',
// //           style: TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.w700,
// //             color: theme.textTheme.titleLarge?.color,
// //           ),
// //         ),
// //       ),
// //
// //       body: ListView(
// //         padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
// //         children: const [
// //           _TransactionItem(
// //             title: 'Purchase',
// //             date: '2026-09-06 15:30',
// //             points: '+120',
// //             incoming: true,
// //           ),
// //
// //           SizedBox(height: 12),
// //
// //           _TransactionItem(
// //             title: 'Purchase',
// //             date: '2026-09-05 18:20',
// //             points: '+80',
// //             incoming: true,
// //           ),
// //
// //           SizedBox(height: 12),
// //
// //           _TransactionItem(
// //             title: 'Reward Redeemed',
// //             date: '2026-09-04 12:15',
// //             points: '-200',
// //             incoming: false,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class _TransactionItem extends StatelessWidget {
// //   final String title;
// //   final String date;
// //   final String points;
// //   final bool incoming;
// //
// //   const _TransactionItem({
// //     required this.title,
// //     required this.date,
// //     required this.points,
// //     required this.incoming,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;
// //
// //     final Color color = incoming
// //         ? (isDark ? const Color(0xFF66BB6A) : Colors.green)
// //         : (isDark ? const Color(0xFFEF6C6C) : Colors.red);
// //
// //     final Color borderColor = isDark
// //         ? Colors.white.withOpacity(0.08)
// //         : Colors.grey.shade200;
// //
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: theme.cardColor,
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: borderColor),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
// //             blurRadius: 12,
// //             offset: const Offset(0, 5),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             width: 46,
// //             height: 46,
// //             decoration: BoxDecoration(
// //               color: color.withOpacity(isDark ? 0.16 : 0.10),
// //               shape: BoxShape.circle,
// //             ),
// //             child: Icon(
// //               incoming ? Icons.add_circle_outline : Icons.remove_circle_outline,
// //               color: color,
// //               size: 23,
// //             ),
// //           ),
// //
// //           const SizedBox(width: 14),
// //
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.w700,
// //                     color: theme.textTheme.bodyLarge?.color,
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 5),
// //
// //                 Text(
// //                   date,
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: isDark ? Colors.white54 : Colors.grey.shade500,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //
// //           Text(
// //             points,
// //             style: TextStyle(
// //               color: color,
// //               fontSize: 16,
// //               fontWeight: FontWeight.w800,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class TransactionsScreen extends StatelessWidget {
//   const TransactionsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     // 👈 بدون Scaffold وبدون AppBar
//     return ListView(
//       padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
//       children: const [
//         _TransactionItem(
//           title: 'Purchase',
//           date: '2026-09-06 15:30',
//           points: '+120',
//           incoming: true,
//         ),
//
//         SizedBox(height: 12),
//
//         _TransactionItem(
//           title: 'Purchase',
//           date: '2026-09-05 18:20',
//           points: '+80',
//           incoming: true,
//         ),
//
//         SizedBox(height: 12),
//
//         _TransactionItem(
//           title: 'Reward Redeemed',
//           date: '2026-09-04 12:15',
//           points: '-200',
//           incoming: false,
//         ),
//       ],
//     );
//   }
// }
//
// class _TransactionItem extends StatelessWidget {
//   final String title;
//   final String date;
//   final String points;
//   final bool incoming;
//
//   const _TransactionItem({
//     required this.title,
//     required this.date,
//     required this.points,
//     required this.incoming,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     final Color color = incoming
//         ? (isDark ? const Color(0xFF66BB6A) : Colors.green)
//         : (isDark ? const Color(0xFFEF6C6C) : Colors.red);
//
//     final Color borderColor = isDark
//         ? Colors.white.withOpacity(0.08)
//         : Colors.grey.shade200;
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: borderColor),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.20 : 0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 46,
//             height: 46,
//             decoration: BoxDecoration(
//               color: color.withOpacity(isDark ? 0.16 : 0.10),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               incoming ? Icons.add_circle_outline : Icons.remove_circle_outline,
//               color: color,
//               size: 23,
//             ),
//           ),
//
//           const SizedBox(width: 14),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: theme.textTheme.bodyLarge?.color,
//                   ),
//                 ),
//
//                 const SizedBox(height: 5),
//
//                 Text(
//                   date,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: isDark ? Colors.white54 : Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Text(
//             points,
//             style: TextStyle(
//               color: color,
//               fontSize: 16,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
