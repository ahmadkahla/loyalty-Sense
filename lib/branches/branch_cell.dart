// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // import 'branch_model.dart';
// //
// // class BranchCell extends StatelessWidget {
// //   final Branch branch;
// //
// //   const BranchCell({super.key, required this.branch});
// //
// //   Future<void> _callPhone(String phone) async {
// //     if (phone.isEmpty) {
// //       return;
// //     }
// //
// //     final uri = Uri(scheme: 'tel', path: phone);
// //
// //     await launchUrl(uri);
// //   }
// //
// //   Future<void> _openMap() async {
// //     if (branch.latitude == 0 && branch.longitude == 0) {
// //       return;
// //     }
// //
// //     final uri = Uri.parse(
// //       'https://www.google.com/maps/search/?api=1'
// //       '&query=${branch.latitude},${branch.longitude}',
// //     );
// //
// //     await launchUrl(uri, mode: LaunchMode.externalApplication);
// //   }
// //
// //   Future<void> _openGoogleReview() async {
// //     if (branch.googleRateUrl.isEmpty) {
// //       return;
// //     }
// //
// //     final uri = Uri.parse(branch.googleRateUrl);
// //
// //     await launchUrl(uri, mode: LaunchMode.externalApplication);
// //   }
// //
// //   String _formatTime(TimeOfDay? time) {
// //     if (time == null) {
// //       return '--';
// //     }
// //
// //     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
// //
// //     final minute = time.minute.toString().padLeft(2, '0');
// //
// //     final period = time.period == DayPeriod.am ? 'AM' : 'PM';
// //
// //     return '$hour:$minute $period';
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //
// //     final phones = <String>[
// //       if (branch.phone1.isNotEmpty) branch.phone1,
// //       if (branch.phone2.isNotEmpty) branch.phone2,
// //     ];
// //
// //     return Card(
// //       margin: EdgeInsets.zero,
// //       elevation: 3,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(18),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Expanded(
// //                   child: Text(
// //                     branch.displayName.isEmpty ? 'Branch' : branch.displayName,
// //                     style: theme.textTheme.titleLarge?.copyWith(
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 10),
// //                 _buildOpenStatus(context),
// //               ],
// //             ),
// //
// //             const SizedBox(height: 18),
// //
// //             if (branch.isOpen24 ||
// //                 branch.openTime != null ||
// //                 branch.closeTime != null)
// //               _infoRow(
// //                 context,
// //                 Icons.access_time_rounded,
// //                 'Working hours',
// //                 branch.isOpen24
// //                     ? 'Open 24 Hours'
// //                     : '${_formatTime(branch.openTime)} - '
// //                           '${_formatTime(branch.closeTime)}',
// //               ),
// //
// //             if (branch.waitingTime > 0) ...[
// //               const SizedBox(height: 12),
// //               _infoRow(
// //                 context,
// //                 Icons.timer_outlined,
// //                 'Waiting time',
// //                 '${branch.waitingTime} minutes',
// //               ),
// //             ],
// //
// //             if (branch.latitude != 0 || branch.longitude != 0) ...[
// //               const SizedBox(height: 12),
// //               _infoRow(
// //                 context,
// //                 Icons.location_on_outlined,
// //                 'Location',
// //                 '${branch.latitude}, ${branch.longitude}',
// //               ),
// //             ],
// //
// //             if (phones.isNotEmpty) ...[
// //               const SizedBox(height: 16),
// //               const Divider(),
// //               const SizedBox(height: 8),
// //
// //               Text(
// //                 'Phone numbers',
// //                 style: theme.textTheme.titleMedium?.copyWith(
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 8),
// //
// //               for (final phone in phones) _buildPhoneRow(context, phone),
// //             ],
// //
// //             const SizedBox(height: 18),
// //
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: SizedBox(
// //                     height: 48,
// //                     child: OutlinedButton.icon(
// //                       onPressed: _openMap,
// //                       icon: const Icon(Icons.directions_rounded),
// //                       label: const Text('Get Directions'),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 if (branch.googleRateUrl.isNotEmpty) ...[
// //                   const SizedBox(width: 10),
// //                   SizedBox(
// //                     height: 48,
// //                     child: ElevatedButton(
// //                       onPressed: _openGoogleReview,
// //                       child: const Icon(Icons.star_rate_rounded),
// //                     ),
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildOpenStatus(BuildContext context) {
// //     final controllerTime = DateTime.now();
// //
// //     bool isOpen;
// //
// //     if (branch.isOpen24) {
// //       isOpen = true;
// //     } else {
// //       final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;
// //
// //       final openMinutes =
// //           branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;
// //
// //       final closeMinutes =
// //           branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;
// //
// //       if (closeMinutes < openMinutes) {
// //         isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
// //       } else {
// //         isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
// //       }
// //     }
// //
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(20),
// //         color: isOpen
// //             ? Colors.green.withValues(alpha: 0.12)
// //             : Colors.red.withValues(alpha: 0.12),
// //       ),
// //       child: Text(
// //         isOpen ? 'Open' : 'Closed',
// //         style: TextStyle(
// //           fontSize: 12,
// //           fontWeight: FontWeight.bold,
// //           color: isOpen ? Colors.green : Colors.red,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _infoRow(
// //     BuildContext context,
// //     IconData icon,
// //     String title,
// //     String value,
// //   ) {
// //     final theme = Theme.of(context);
// //
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(icon, size: 21, color: theme.colorScheme.primary),
// //         const SizedBox(width: 10),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: theme.textTheme.bodySmall?.copyWith(
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               const SizedBox(height: 2),
// //               Text(value, style: theme.textTheme.bodyMedium),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildPhoneRow(BuildContext context, String phone) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 5),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.phone_outlined, size: 20),
// //           const SizedBox(width: 10),
// //           Expanded(
// //             child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
// //           ),
// //           IconButton(
// //             tooltip: 'Call',
// //             onPressed: () => _callPhone(phone),
// //             icon: const Icon(Icons.call_rounded),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'branch_model.dart';
//
// class BranchCell extends StatelessWidget {
//   final Branch branch;
//
//   const BranchCell({super.key, required this.branch});
//
//   Future<void> _callPhone(String phone) async {
//     if (phone.isEmpty) {
//       return;
//     }
//
//     final uri = Uri(scheme: 'tel', path: phone);
//
//     await launchUrl(uri);
//   }
//
//   Future<void> _openMap() async {
//     if (branch.latitude == 0 && branch.longitude == 0) {
//       return;
//     }
//
//     final uri = Uri.parse(
//       'https://www.google.com/maps/search/?api=1'
//       '&query=${branch.latitude},${branch.longitude}',
//     );
//
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }
//
//   Future<void> _openGoogleReview() async {
//     if (branch.googleRateUrl.isEmpty) {
//       return;
//     }
//
//     final uri = Uri.parse(branch.googleRateUrl);
//
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   }
//
//   String _formatTime(TimeOfDay? time) {
//     if (time == null) {
//       return '--';
//     }
//
//     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
//
//     final minute = time.minute.toString().padLeft(2, '0');
//
//     final period = time.period == DayPeriod.am ? 'AM' : 'PM';
//
//     return '$hour:$minute $period';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final phones = <String>[
//       if (branch.phone1.isNotEmpty) branch.phone1,
//       if (branch.phone2.isNotEmpty) branch.phone2,
//     ];
//
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     branch.displayName.isEmpty ? 'Branch' : branch.displayName,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//
//                 // ✅ أيقونة الفرع (جديدة) + شارة Open/Closed
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.storefront_rounded, // أيقونة الفرع
//                       size: 22,
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 6),
//                     _buildOpenStatus(context),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             // ============================================================
//             // ساعات العمل
//             // ============================================================
//             if (branch.isOpen24 ||
//                 branch.openTime != null ||
//                 branch.closeTime != null)
//               _infoRow(
//                 context,
//                 Icons.access_time_rounded,
//                 'Working hours',
//                 branch.isOpen24
//                     ? 'Open 24 Hours'
//                     : '${_formatTime(branch.openTime)} - '
//                           '${_formatTime(branch.closeTime)}',
//               ),
//
//             // ============================================================
//             // وقت الانتظار
//             // ============================================================
//             if (branch.waitingTime > 0) ...[
//               const SizedBox(height: 12),
//               _infoRow(
//                 context,
//                 Icons.timer_outlined,
//                 'Waiting time',
//                 '${branch.waitingTime} minutes',
//               ),
//             ],
//
//             if (phones.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               Text(
//                 'phone_numbers'.tr(),
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               for (final phone in phones) _buildPhoneRow(context, phone),
//             ],
//
//             const SizedBox(height: 18),
//
//             // ============================================================
//             // زر Get Directions + زر التقييم
//             // ============================================================
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: _openMap,
//                       icon: const Icon(Icons.directions_rounded),
//                       label: Text('get_directions'.tr()),
//                     ),
//                   ),
//                 ),
//
//                 if (branch.googleRateUrl.isNotEmpty) ...[
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: _openGoogleReview,
//                       child: const Icon(Icons.star_rate_rounded),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // شارة Open/Closed
//   // ================================================================
//   Widget _buildOpenStatus(BuildContext context) {
//     final controllerTime = DateTime.now();
//
//     bool isOpen;
//
//     if (branch.isOpen24) {
//       isOpen = true;
//     } else {
//       final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;
//
//       final openMinutes =
//           branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;
//
//       final closeMinutes =
//           branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;
//
//       if (closeMinutes < openMinutes) {
//         isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
//       } else {
//         isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
//       }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isOpen
//             ? Colors.green.withValues(alpha: 0.12)
//             : Colors.red.withValues(alpha: 0.12),
//       ),
//       child: Text(
//         isOpen ? 'open'.tr() : 'closed'.tr(),
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isOpen ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // سطر المعلومات (ساعات العمل / وقت الانتظار)
//   // ================================================================
//   Widget _infoRow(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     final theme = Theme.of(context);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 21, color: theme.colorScheme.primary),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(value, style: theme.textTheme.bodyMedium),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ================================================================
//   // سطر الهاتف
//   // ================================================================
//   Widget _buildPhoneRow(BuildContext context, String phone) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           const Icon(Icons.phone_outlined, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
//           ),
//           IconButton(
//             tooltip: 'Call',
//             onPressed: () => _callPhone(phone),
//             icon: const Icon(Icons.call_rounded),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'branch_model.dart';
//
// class BranchCell extends StatelessWidget {
//   final Branch branch;
//
//   const BranchCell({super.key, required this.branch});
//
//   Future<void> _openUrl(
//     BuildContext context,
//     Uri uri, {
//     String errorMessage = 'Could not open this link',
//   }) async {
//     try {
//       debugPrint('🔗 Branch link: $uri');
//
//       final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
//
//       debugPrint('🔗 Branch launch result: $launched');
//
//       if (!launched && context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     } catch (e) {
//       debugPrint('❌ Branch URL error: $e');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     }
//   }
//
//   Future<void> _callPhone(BuildContext context, String phone) async {
//     final cleanPhone = phone.trim();
//
//     if (cleanPhone.isEmpty) {
//       return;
//     }
//
//     final uri = Uri(scheme: 'tel', path: cleanPhone);
//
//     await _openUrl(
//       context,
//       uri,
//       errorMessage: 'Could not open the phone dialer',
//     );
//   }
//
//   Future<void> _openMap(BuildContext context) async {
//     if (branch.latitude == 0 && branch.longitude == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Branch location is not available')),
//       );
//       return;
//     }
//
//     final uri = Uri.parse(
//       'https://www.google.com/maps/dir/?api=1'
//       '&destination=${branch.latitude},${branch.longitude}',
//     );
//
//     await _openUrl(context, uri, errorMessage: 'Could not open Google Maps');
//   }
//
//   Future<void> _openGoogleReview(BuildContext context) async {
//     final link = branch.googleRateUrl.trim();
//
//     if (link.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Rating link is not available')),
//       );
//       return;
//     }
//
//     final uri = Uri.tryParse(link);
//
//     if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
//       debugPrint('❌ Invalid Google review URL: $link');
//
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Invalid rating link')));
//       return;
//     }
//
//     await _openUrl(
//       context,
//       uri,
//       errorMessage: 'Could not open the rating link',
//     );
//   }
//
//   String _formatTime(TimeOfDay? time) {
//     if (time == null) {
//       return '--';
//     }
//
//     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
//
//     final minute = time.minute.toString().padLeft(2, '0');
//
//     final period = time.period == DayPeriod.am ? 'AM' : 'PM';
//
//     return '$hour:$minute $period';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final phones = <String>[
//       if (branch.phone1.isNotEmpty) branch.phone1,
//       if (branch.phone2.isNotEmpty) branch.phone2,
//     ];
//
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     branch.displayName.isEmpty ? 'Branch' : branch.displayName,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//
//                 // ✅ أيقونة الفرع (جديدة) + شارة Open/Closed
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.storefront_rounded, // أيقونة الفرع
//                       size: 22,
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 6),
//                     _buildOpenStatus(context),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             // ============================================================
//             // ساعات العمل
//             // ============================================================
//             if (branch.isOpen24 ||
//                 branch.openTime != null ||
//                 branch.closeTime != null)
//               _infoRow(
//                 context,
//                 Icons.access_time_rounded,
//                 'Working hours',
//                 branch.isOpen24
//                     ? 'Open 24 Hours'
//                     : '${_formatTime(branch.openTime)} - '
//                           '${_formatTime(branch.closeTime)}',
//               ),
//
//             // ============================================================
//             // وقت الانتظار
//             // ============================================================
//             if (branch.waitingTime > 0) ...[
//               const SizedBox(height: 12),
//               _infoRow(
//                 context,
//                 Icons.timer_outlined,
//                 'Waiting time',
//                 '${branch.waitingTime} minutes',
//               ),
//             ],
//
//             if (phones.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               Text(
//                 'phone_numbers'.tr(),
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               for (final phone in phones) _buildPhoneRow(context, phone),
//             ],
//
//             const SizedBox(height: 18),
//
//             // ============================================================
//             // زر Get Directions + زر التقييم
//             // ============================================================
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: () => _openMap(context),
//                       icon: const Icon(Icons.directions_rounded),
//                       label: Text('get_directions'.tr()),
//                     ),
//                   ),
//                 ),
//
//                 if (branch.googleRateUrl.isNotEmpty) ...[
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () => _openGoogleReview(context),
//                       child: const Icon(Icons.star_rate_rounded),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // شارة Open/Closed
//   // ================================================================
//   Widget _buildOpenStatus(BuildContext context) {
//     final controllerTime = DateTime.now();
//
//     bool isOpen;
//
//     if (branch.isOpen24) {
//       isOpen = true;
//     } else {
//       final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;
//
//       final openMinutes =
//           branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;
//
//       final closeMinutes =
//           branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;
//
//       if (closeMinutes < openMinutes) {
//         isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
//       } else {
//         isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
//       }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isOpen
//             ? Colors.green.withValues(alpha: 0.12)
//             : Colors.red.withValues(alpha: 0.12),
//       ),
//       child: Text(
//         isOpen ? 'open'.tr() : 'closed'.tr(),
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isOpen ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // سطر المعلومات (ساعات العمل / وقت الانتظار)
//   // ================================================================
//   Widget _infoRow(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     final theme = Theme.of(context);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 21, color: theme.colorScheme.primary),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(value, style: theme.textTheme.bodyMedium),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ================================================================
//   // سطر الهاتف
//   // ================================================================
//   Widget _buildPhoneRow(BuildContext context, String phone) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           const Icon(Icons.phone_outlined, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
//           ),
//           IconButton(
//             tooltip: 'Call',
//             onPressed: () => _callPhone(context, phone),
//             icon: const Icon(Icons.call_rounded),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'branch_model.dart';
//
// class BranchCell extends StatelessWidget {
//   final Branch branch;
//
//   const BranchCell({super.key, required this.branch});
//
//   // ================================================================
//   // فتح الروابط
//   //
//   // Android:
//   // نستخدم Android Intent مباشرة لتجنب مشكلة url_launcher
//   // التي ظهرت في Release.
//   //
//   // iOS:
//   // نستخدم url_launcher بشكل طبيعي.
//   // ================================================================
//   Future<void> _openUrl(
//     BuildContext context,
//     Uri uri, {
//     String errorMessage = 'Could not open this link',
//   }) async {
//     try {
//       debugPrint('🔗 Branch link: $uri');
//
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: Uri.encodeFull(uri.toString()),
//         );
//
//         await intent.launch();
//
//         debugPrint('✅ Android Intent launched successfully');
//         return;
//       }
//
//       // ============================================================
//       // iOS
//       // ============================================================
//       if (Platform.isIOS) {
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         debugPrint('🍎 iOS launch result: $launched');
//
//         if (!launched && context.mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(errorMessage)));
//         }
//
//         return;
//       }
//
//       // أي منصة أخرى
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//
//       if (!launched && context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     } catch (e) {
//       debugPrint('❌ Branch URL error: $e');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     }
//   }
//
//   // ================================================================
//   // الاتصال
//   // ================================================================
//   // Future<void> _callPhone(BuildContext context, String phone) async {
//   //   final cleanPhone = phone.trim();
//   //
//   //   if (cleanPhone.isEmpty) {
//   //     return;
//   //   }
//   //
//   //   debugPrint('📞 Opening phone dialer: $cleanPhone');
//   //
//   //   try {
//   //     if (Platform.isAndroid) {
//   //       final intent = AndroidIntent(
//   //         action: 'action_dial',
//   //         data: Uri.encodeFull('tel:$cleanPhone'),
//   //       );
//   //
//   //       await intent.launch();
//   //
//   //       debugPrint('✅ Android phone dialer opened');
//   //       return;
//   //     }
//   //
//   //     // iOS
//   //     final uri = Uri(scheme: 'tel', path: cleanPhone);
//   //
//   //     final launched = await launchUrl(
//   //       uri,
//   //       mode: LaunchMode.externalApplication,
//   //     );
//   //
//   //     debugPrint('🍎 iOS phone launch result: $launched');
//   //
//   //     if (!launched && context.mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('Could not open the phone dialer')),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     debugPrint('❌ Phone dialer error: $e');
//   //
//   //     if (context.mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('Could not open the phone dialer')),
//   //       );
//   //     }
//   //   }
//   // }
//   Future<void> _callPhone(BuildContext context, String phone) async {
//     final cleanPhone = phone.trim().replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
//
//     if (cleanPhone.isEmpty) {
//       debugPrint('❌ Empty phone number');
//       return;
//     }
//
//     debugPrint('📞 Opening phone dialer: $cleanPhone');
//
//     try {
//       // ============================================================
//       // Android
//       // ============================================================
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'android.intent.action.DIAL',
//           data: 'tel:$cleanPhone',
//         );
//         await intent.launch();
//         debugPrint('✅ Android phone dialer opened');
//         return;
//       }
//
//       // ============================================================
//       // iOS
//       // ============================================================
//       if (Platform.isIOS) {
//         // ✅ استخدام telprompt: بدلاً من tel:
//         final uri = Uri.parse('telprompt://$cleanPhone');
//
//         debugPrint('🍎 iOS telprompt URI: $uri');
//
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         debugPrint('🍎 iOS phone launch result: $launched');
//
//         // إذا فشل telprompt، جرّب tel: كـ fallback
//         if (!launched) {
//           debugPrint('⚠️ telprompt failed, trying tel:');
//
//           final fallbackUri = Uri(scheme: 'tel', path: cleanPhone);
//           final fallbackLaunched = await launchUrl(
//             fallbackUri,
//             mode: LaunchMode.externalApplication,
//           );
//
//           debugPrint('🍎 Fallback result: $fallbackLaunched');
//
//           if (!fallbackLaunched && context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Phone calls are not supported on this device'),
//               ),
//             );
//           }
//         }
//         return;
//       }
//     } catch (e, stack) {
//       debugPrint('❌ Phone dialer error: $e');
//       debugPrint('📚 Stack: $stack');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Could not open the phone dialer: $e')),
//         );
//       }
//     }
//   }
//
//   // ================================================================
//   // Google Maps / Directions
//   // ================================================================
//   Future<void> _openMap(BuildContext context) async {
//     if (branch.latitude == 0 && branch.longitude == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Branch location is not available')),
//       );
//       return;
//     }
//
//     final latitude = branch.latitude;
//     final longitude = branch.longitude;
//
//     debugPrint('📍 Opening Google Maps: $latitude,$longitude');
//
//     try {
//       // ============================================================
//       // Android
//       // ============================================================
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: Uri.encodeFull('google.navigation:q=$latitude,$longitude'),
//           package: 'com.google.android.apps.maps',
//         );
//
//         await intent.launch();
//
//         debugPrint('✅ Google Maps Android Intent launched successfully');
//
//         return;
//       }
//
//       // ============================================================
//       // iOS
//       //
//       // نستخدم Google Maps URL.
//       // إذا كان Google Maps مثبتًا، iOS قد يفتح التطبيق
//       // حسب الـ URL handling.
//       // وإلا يفتح الرابط في Safari.
//       // ============================================================
//       if (Platform.isIOS) {
//         final uri = Uri.parse(
//           'https://www.google.com/maps/dir/?api=1'
//           '&destination=$latitude,$longitude',
//         );
//
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         debugPrint('🍎 Google Maps iOS launch result: $launched');
//
//         if (!launched && context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not open Google Maps')),
//           );
//         }
//
//         return;
//       }
//
//       // Fallback
//       final uri = Uri.parse(
//         'https://www.google.com/maps/dir/?api=1'
//         '&destination=$latitude,$longitude',
//       );
//
//       await _openUrl(context, uri, errorMessage: 'Could not open Google Maps');
//     } catch (e) {
//       debugPrint('❌ Google Maps error: $e');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Could not open Google Maps')),
//         );
//       }
//     }
//   }
//
//   // ================================================================
//   // Google Review
//   // ================================================================
//   Future<void> _openGoogleReview(BuildContext context) async {
//     final link = branch.googleRateUrl.trim();
//
//     if (link.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Rating link is not available')),
//       );
//       return;
//     }
//
//     final uri = Uri.tryParse(link);
//
//     if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
//       debugPrint('❌ Invalid Google review URL: $link');
//
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Invalid rating link')));
//       return;
//     }
//
//     debugPrint('⭐ Opening Google review: $link');
//
//     await _openUrl(
//       context,
//       uri,
//       errorMessage: 'Could not open the rating link',
//     );
//   }
//
//   // ================================================================
//   // تنسيق الوقت
//   // ================================================================
//   String _formatTime(TimeOfDay? time) {
//     if (time == null) {
//       return '--';
//     }
//
//     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
//
//     final minute = time.minute.toString().padLeft(2, '0');
//
//     final period = time.period == DayPeriod.am ? 'AM' : 'PM';
//
//     return '$hour:$minute $period';
//   }
//
//   // ================================================================
//   // UI
//   // ================================================================
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final phones = <String>[
//       if (branch.phone1.isNotEmpty) branch.phone1,
//       if (branch.phone2.isNotEmpty) branch.phone2,
//     ];
//
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ========================================================
//             // Branch name + status
//             // ========================================================
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     branch.displayName.isEmpty ? 'Branch' : branch.displayName,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 10),
//
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.storefront_rounded,
//                       size: 22,
//                       color: theme.colorScheme.primary,
//                     ),
//
//                     const SizedBox(width: 6),
//
//                     _buildOpenStatus(context),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             // ========================================================
//             // Working hours
//             // ========================================================
//             if (branch.isOpen24 ||
//                 branch.openTime != null ||
//                 branch.closeTime != null)
//               _infoRow(
//                 context,
//                 Icons.access_time_rounded,
//                 'Working hours',
//                 branch.isOpen24
//                     ? 'Open 24 Hours'
//                     : '${_formatTime(branch.openTime)} - '
//                           '${_formatTime(branch.closeTime)}',
//               ),
//
//             // ========================================================
//             // Waiting time
//             // ========================================================
//             if (branch.waitingTime > 0) ...[
//               const SizedBox(height: 12),
//
//               _infoRow(
//                 context,
//                 Icons.timer_outlined,
//                 'Waiting time',
//                 '${branch.waitingTime} minutes',
//               ),
//             ],
//
//             // ========================================================
//             // Phone numbers
//             // ========================================================
//             if (phones.isNotEmpty) ...[
//               const SizedBox(height: 16),
//
//               const Divider(),
//
//               const SizedBox(height: 8),
//
//               Text(
//                 'phone_numbers'.tr(),
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               for (final phone in phones) _buildPhoneRow(context, phone),
//             ],
//
//             const SizedBox(height: 18),
//
//             // ========================================================
//             // Directions + Rating
//             // ========================================================
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: () => _openMap(context),
//                       icon: const Icon(Icons.directions_rounded),
//                       label: Text('get_directions'.tr()),
//                     ),
//                   ),
//                 ),
//
//                 if (branch.googleRateUrl.isNotEmpty) ...[
//                   const SizedBox(width: 10),
//
//                   SizedBox(
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () => _openGoogleReview(context),
//                       child: const Icon(Icons.star_rate_rounded),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // Open / Closed
//   // ================================================================
//   Widget _buildOpenStatus(BuildContext context) {
//     final controllerTime = DateTime.now();
//
//     bool isOpen;
//
//     if (branch.isOpen24) {
//       isOpen = true;
//     } else {
//       final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;
//
//       final openMinutes =
//           branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;
//
//       final closeMinutes =
//           branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;
//
//       if (closeMinutes < openMinutes) {
//         isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
//       } else {
//         isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
//       }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isOpen
//             ? Colors.green.withValues(alpha: 0.12)
//             : Colors.red.withValues(alpha: 0.12),
//       ),
//       child: Text(
//         isOpen ? 'open'.tr() : 'closed'.tr(),
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isOpen ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // Information row
//   // ================================================================
//   Widget _infoRow(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     final theme = Theme.of(context);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 21, color: theme.colorScheme.primary),
//
//         const SizedBox(width: 10),
//
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//
//               const SizedBox(height: 2),
//
//               Text(value, style: theme.textTheme.bodyMedium),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ================================================================
//   // Phone row
//   // ================================================================
//   Widget _buildPhoneRow(BuildContext context, String phone) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           const Icon(Icons.phone_outlined, size: 20),
//
//           const SizedBox(width: 10),
//
//           Expanded(
//             child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
//           ),
//
//           IconButton(
//             tooltip: 'Call',
//             onPressed: () => _callPhone(context, phone),
//             icon: const Icon(Icons.call_rounded),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
//
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'branch_model.dart';
//
// class BranchCell extends StatelessWidget {
//   final Branch branch;
//
//   const BranchCell({super.key, required this.branch});
//
//   // ================================================================
//   // فتح الروابط
//   // ================================================================
//   Future<void> _openUrl(
//     BuildContext context,
//     Uri uri, {
//     String errorMessage = 'Could not open this link',
//   }) async {
//     try {
//       debugPrint('🔗 Branch link: $uri');
//
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: Uri.encodeFull(uri.toString()),
//         );
//
//         await intent.launch();
//         debugPrint('✅ Android Intent launched successfully');
//         return;
//       }
//
//       if (Platform.isIOS) {
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         debugPrint('🍎 iOS launch result: $launched');
//
//         if (!launched && context.mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(errorMessage)));
//         }
//         return;
//       }
//
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//
//       if (!launched && context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     } catch (e) {
//       debugPrint('❌ Branch URL error: $e');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(errorMessage)));
//       }
//     }
//   }
//
//   // ================================================================
//   // الاتصال
//   // ================================================================
//   Future<void> _callPhone(BuildContext context, String phone) async {
//     final cleanPhone = phone.trim().replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
//
//     if (cleanPhone.isEmpty) {
//       debugPrint('❌ Empty phone number');
//       return;
//     }
//
//     debugPrint('📞 Opening phone dialer: $cleanPhone');
//
//     try {
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'android.intent.action.DIAL',
//           data: 'tel:$cleanPhone',
//         );
//         await intent.launch();
//         debugPrint('✅ Android phone dialer opened');
//         return;
//       }
//
//       if (Platform.isIOS) {
//         final uri = Uri.parse('telprompt://$cleanPhone');
//         debugPrint('🍎 iOS telprompt URI: $uri');
//
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         debugPrint('🍎 iOS phone launch result: $launched');
//
//         if (!launched) {
//           final fallbackUri = Uri(scheme: 'tel', path: cleanPhone);
//           final fallbackLaunched = await launchUrl(
//             fallbackUri,
//             mode: LaunchMode.externalApplication,
//           );
//
//           if (!fallbackLaunched && context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Phone calls are not supported on this device'),
//               ),
//             );
//           }
//         }
//         return;
//       }
//     } catch (e, stack) {
//       debugPrint('❌ Phone dialer error: $e');
//       debugPrint('📚 Stack: $stack');
//
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Could not open the phone dialer: $e')),
//         );
//       }
//     }
//   }
//
//   // ================================================================
//   // Google Maps
//   // ================================================================
//   Future<void> _openMap(BuildContext context) async {
//     if (branch.latitude == 0 && branch.longitude == 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Branch location is not available')),
//       );
//       return;
//     }
//
//     final latitude = branch.latitude;
//     final longitude = branch.longitude;
//
//     debugPrint('📍 Opening Google Maps: $latitude,$longitude');
//
//     try {
//       if (Platform.isAndroid) {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: Uri.encodeFull('google.navigation:q=$latitude,$longitude'),
//           package: 'com.google.android.apps.maps',
//         );
//
//         await intent.launch();
//         debugPrint('✅ Google Maps Android Intent launched successfully');
//         return;
//       }
//
//       if (Platform.isIOS) {
//         final uri = Uri.parse(
//           'https://www.google.com/maps/dir/?api=1'
//           '&destination=$latitude,$longitude',
//         );
//
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//
//         if (!launched && context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not open Google Maps')),
//           );
//         }
//         return;
//       }
//
//       final uri = Uri.parse(
//         'https://www.google.com/maps/dir/?api=1'
//         '&destination=$latitude,$longitude',
//       );
//
//       await _openUrl(context, uri, errorMessage: 'Could not open Google Maps');
//     } catch (e) {
//       debugPrint('❌ Google Maps error: $e');
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Could not open Google Maps')),
//         );
//       }
//     }
//   }
//
//   // ================================================================
//   // Google Review
//   // ================================================================
//   Future<void> _openGoogleReview(BuildContext context) async {
//     final link = branch.googleRateUrl.trim();
//
//     if (link.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Rating link is not available')),
//       );
//       return;
//     }
//
//     final uri = Uri.tryParse(link);
//
//     if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
//       debugPrint('❌ Invalid Google review URL: $link');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Invalid rating link')));
//       return;
//     }
//
//     debugPrint('⭐ Opening Google review: $link');
//
//     await _openUrl(
//       context,
//       uri,
//       errorMessage: 'Could not open the rating link',
//     );
//   }
//
//   // ================================================================
//   // تنسيق الوقت (ص / م)
//   // ================================================================
//   String _formatTime(TimeOfDay? time) {
//     if (time == null) {
//       return '--';
//     }
//
//     final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
//     final minute = time.minute.toString().padLeft(2, '0');
//     final period = time.period == DayPeriod.am ? 'ص' : 'م';
//
//     return '$hour:$minute $period';
//   }
//
//   // ================================================================
//   // UI
//   // ================================================================
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final phones = <String>[
//       if (branch.phone1.isNotEmpty) branch.phone1,
//       if (branch.phone2.isNotEmpty) branch.phone2,
//     ];
//
//     return Card(
//       margin: EdgeInsets.zero,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ========================================================
//             // Branch name + status
//             // ========================================================
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     branch.displayName.isEmpty ? 'Branch' : branch.displayName,
//                     style: theme.textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 10),
//
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.storefront_rounded,
//                       size: 22,
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 6),
//                     _buildOpenStatus(context),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
//             // ========================================================
//             // ✅ أوقات العمل في سطر واحد
//             // ========================================================
//             if (branch.isOpen24 ||
//                 branch.openTime != null ||
//                 branch.closeTime != null)
//               // _infoRow(
//               //   context,
//               //   Icons.access_time_rounded,
//               //   'working_hours'.tr(),
//               //   branch.isOpen24
//               //       ? '24 ساعة'
//               //       : 'opens_at. ${_formatTime(branch.openTime)}  •  closes_at ${_formatTime(branch.closeTime)}'
//               //             .tr(),
//               // ),
//               _infoRow(
//                 context,
//                 Icons.access_time_rounded,
//                 'working_hours'.tr(),
//                 branch.isOpen24
//                     ? 'open_24_hours'.tr()
//                     : '${'opens_at'.tr()} ${_formatTime(branch.openTime)}  •  ${'closes_at'.tr()} ${_formatTime(branch.closeTime)}',
//               ),
//
//             // ========================================================
//             // ❌ Waiting time محذوف
//             // ========================================================
//
//             // ========================================================
//             // Phone numbers
//             // ========================================================
//             if (phones.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//               Text(
//                 'phone_numbers'.tr(),
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               for (final phone in phones) _buildPhoneRow(context, phone),
//             ],
//
//             const SizedBox(height: 18),
//
//             // ========================================================
//             // Directions + Rating
//             // ========================================================
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: () => _openMap(context),
//                       icon: const Icon(Icons.directions_rounded),
//                       label: Text('get_directions'.tr()),
//                     ),
//                   ),
//                 ),
//
//                 if (branch.googleRateUrl.isNotEmpty) ...[
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () => _openGoogleReview(context),
//                       child: const Icon(Icons.star_rate_rounded),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // Open / Closed
//   // ================================================================
//   Widget _buildOpenStatus(BuildContext context) {
//     final controllerTime = DateTime.now();
//
//     bool isOpen;
//
//     if (branch.isOpen24) {
//       isOpen = true;
//     } else {
//       final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;
//
//       final openMinutes =
//           branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;
//
//       final closeMinutes =
//           branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;
//
//       if (closeMinutes < openMinutes) {
//         isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
//       } else {
//         isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
//       }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isOpen
//             ? Colors.green.withValues(alpha: 0.12)
//             : Colors.red.withValues(alpha: 0.12),
//       ),
//       child: Text(
//         isOpen ? 'open'.tr() : 'closed'.tr(),
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isOpen ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // Information row
//   // ================================================================
//   Widget _infoRow(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     final theme = Theme.of(context);
//
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 21, color: theme.colorScheme.primary),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(value, style: theme.textTheme.bodyMedium),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ================================================================
//   // Phone row
//   // ================================================================
//   Widget _buildPhoneRow(BuildContext context, String phone) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           const Icon(Icons.phone_outlined, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
//           ),
//           IconButton(
//             tooltip: 'Call',
//             onPressed: () => _callPhone(context, phone),
//             icon: const Icon(Icons.call_rounded),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'branch_model.dart';

class BranchCell extends StatelessWidget {
  final Branch branch;

  const BranchCell({super.key, required this.branch});

  // ================================================================
  // فتح الروابط
  // ================================================================
  Future<void> _openUrl(
    BuildContext context,
    Uri uri, {
    String errorMessage = 'Could not open this link',
  }) async {
    try {
      debugPrint('🔗 Branch link: $uri');

      if (Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(uri.toString()),
        );

        await intent.launch();
        debugPrint('✅ Android Intent launched successfully');
        return;
      }

      if (Platform.isIOS) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        debugPrint('🍎 iOS launch result: $launched');

        if (!launched && context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
        return;
      }

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      debugPrint('❌ Branch URL error: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  // ================================================================
  // الاتصال
  // ================================================================
  Future<void> _callPhone(BuildContext context, String phone) async {
    final cleanPhone = phone.trim().replaceAll(RegExp(r'[\s\-\(\)\.]'), '');

    if (cleanPhone.isEmpty) {
      debugPrint('❌ Empty phone number');
      return;
    }

    debugPrint('📞 Opening phone dialer: $cleanPhone');

    try {
      if (Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'android.intent.action.DIAL',
          data: 'tel:$cleanPhone',
        );
        await intent.launch();
        debugPrint('✅ Android phone dialer opened');
        return;
      }

      if (Platform.isIOS) {
        final uri = Uri.parse('telprompt://$cleanPhone');
        debugPrint('🍎 iOS telprompt URI: $uri');

        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        debugPrint('🍎 iOS phone launch result: $launched');

        if (!launched) {
          final fallbackUri = Uri(scheme: 'tel', path: cleanPhone);
          final fallbackLaunched = await launchUrl(
            fallbackUri,
            mode: LaunchMode.externalApplication,
          );

          if (!fallbackLaunched && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Phone calls are not supported on this device'),
              ),
            );
          }
        }
        return;
      }
    } catch (e, stack) {
      debugPrint('❌ Phone dialer error: $e');
      debugPrint('📚 Stack: $stack');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the phone dialer: $e')),
        );
      }
    }
  }

  // ================================================================
  // Google Maps
  // ================================================================
  Future<void> _openMap(BuildContext context) async {
    if (branch.latitude == 0 && branch.longitude == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Branch location is not available')),
      );
      return;
    }

    final latitude = branch.latitude;
    final longitude = branch.longitude;

    debugPrint('📍 Opening Google Maps: $latitude,$longitude');

    try {
      if (Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull('google.navigation:q=$latitude,$longitude'),
          package: 'com.google.android.apps.maps',
        );

        await intent.launch();
        debugPrint('✅ Google Maps Android Intent launched successfully');
        return;
      }

      if (Platform.isIOS) {
        final uri = Uri.parse(
          'https://www.google.com/maps/dir/?api=1'
          '&destination=$latitude,$longitude',
        );

        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open Google Maps')),
          );
        }
        return;
      }

      final uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1'
        '&destination=$latitude,$longitude',
      );

      await _openUrl(context, uri, errorMessage: 'Could not open Google Maps');
    } catch (e) {
      debugPrint('❌ Google Maps error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Google Maps')),
        );
      }
    }
  }

  // ================================================================
  // Google Review
  // ================================================================
  Future<void> _openGoogleReview(BuildContext context) async {
    final link = branch.googleRateUrl.trim();

    if (link.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rating link is not available')),
      );
      return;
    }

    final uri = Uri.tryParse(link);

    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      debugPrint('❌ Invalid Google review URL: $link');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid rating link')));
      return;
    }

    debugPrint('⭐ Opening Google review: $link');

    await _openUrl(
      context,
      uri,
      errorMessage: 'Could not open the rating link',
    );
  }

  // ================================================================
  // تنسيق الوقت (ص / م أو AM / PM حسب لغة التطبيق)
  // ================================================================
  String _formatTime(BuildContext context, TimeOfDay? time) {
    if (time == null) {
      return '--';
    }

    final locale = context.locale.languageCode;
    final isArabic = locale == 'ar';

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');

    final period = isArabic
        ? (time.period == DayPeriod.am ? 'ص' : 'م')
        : (time.period == DayPeriod.am ? 'AM' : 'PM');

    return '$hour:$minute $period';
  }

  // ================================================================
  // UI
  // ================================================================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final phones = <String>[
      if (branch.phone1.isNotEmpty) branch.phone1,
      if (branch.phone2.isNotEmpty) branch.phone2,
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================================
            // Branch name + status
            // ========================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    branch.displayName.isEmpty ? 'Branch' : branch.displayName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Row(
                  children: [
                    Icon(
                      Icons.storefront_rounded,
                      size: 22,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    _buildOpenStatus(context),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ========================================================
            // ✅ أوقات العمل في سطر واحد
            // ========================================================
            if (branch.isOpen24 ||
                branch.openTime != null ||
                branch.closeTime != null)
              _infoRow(
                context,
                Icons.access_time_rounded,
                'working_hours'.tr(),
                branch.isOpen24
                    ? 'open_24_hours'.tr()
                    : '${'opens_at'.tr()} ${_formatTime(context, branch.openTime)}  •  ${'closes_at'.tr()} ${_formatTime(context, branch.closeTime)}',
              ),

            // ========================================================
            // Phone numbers
            // ========================================================
            if (phones.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'phone_numbers'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              for (final phone in phones) _buildPhoneRow(context, phone),
            ],

            const SizedBox(height: 18),

            // ========================================================
            // Directions + Rating
            // ========================================================
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () => _openMap(context),
                      icon: const Icon(Icons.directions_rounded),
                      label: Text('get_directions'.tr()),
                    ),
                  ),
                ),

                if (branch.googleRateUrl.isNotEmpty) ...[
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _openGoogleReview(context),
                      child: const Icon(Icons.star_rate_rounded),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // Open / Closed
  // ================================================================
  Widget _buildOpenStatus(BuildContext context) {
    final controllerTime = DateTime.now();

    bool isOpen;

    if (branch.isOpen24) {
      isOpen = true;
    } else {
      final nowMinutes = controllerTime.hour * 60 + controllerTime.minute;

      final openMinutes =
          branch.allowOrderFrom.hour * 60 + branch.allowOrderFrom.minute;

      final closeMinutes =
          branch.allowOrderTo.hour * 60 + branch.allowOrderTo.minute;

      if (closeMinutes < openMinutes) {
        isOpen = nowMinutes >= openMinutes || nowMinutes < closeMinutes;
      } else {
        isOpen = nowMinutes >= openMinutes && nowMinutes < closeMinutes;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isOpen
            ? Colors.green.withValues(alpha: 0.12)
            : Colors.red.withValues(alpha: 0.12),
      ),
      child: Text(
        isOpen ? 'open'.tr() : 'closed'.tr(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isOpen ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  // ================================================================
  // Information row
  // ================================================================
  Widget _infoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 21, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  // ================================================================
  // Phone row
  // ================================================================
  Widget _buildPhoneRow(BuildContext context, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.phone_outlined, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(phone, style: Theme.of(context).textTheme.bodyLarge),
          ),
          IconButton(
            tooltip: 'Call',
            onPressed: () => _callPhone(context, phone),
            icon: const Icon(Icons.call_rounded),
          ),
        ],
      ),
    );
  }
}
