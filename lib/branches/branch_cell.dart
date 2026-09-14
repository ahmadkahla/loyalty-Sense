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
//                 _buildOpenStatus(context),
//               ],
//             ),
//
//             const SizedBox(height: 18),
//
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
//             if (branch.latitude != 0 || branch.longitude != 0) ...[
//               const SizedBox(height: 12),
//               _infoRow(
//                 context,
//                 Icons.location_on_outlined,
//                 'Location',
//                 '${branch.latitude}, ${branch.longitude}',
//               ),
//             ],
//
//             if (phones.isNotEmpty) ...[
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               Text(
//                 'Phone numbers',
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
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 48,
//                     child: OutlinedButton.icon(
//                       onPressed: _openMap,
//                       icon: const Icon(Icons.directions_rounded),
//                       label: const Text('Get Directions'),
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
//         isOpen ? 'Open' : 'Closed',
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: isOpen ? Colors.green : Colors.red,
//         ),
//       ),
//     );
//   }
//
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'branch_model.dart';

class BranchCell extends StatelessWidget {
  final Branch branch;

  const BranchCell({super.key, required this.branch});

  Future<void> _callPhone(String phone) async {
    if (phone.isEmpty) {
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);

    await launchUrl(uri);
  }

  Future<void> _openMap() async {
    if (branch.latitude == 0 && branch.longitude == 0) {
      return;
    }

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=${branch.latitude},${branch.longitude}',
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openGoogleReview() async {
    if (branch.googleRateUrl.isEmpty) {
      return;
    }

    final uri = Uri.parse(branch.googleRateUrl);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) {
      return '--';
    }

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    final minute = time.minute.toString().padLeft(2, '0');

    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

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

                // ✅ أيقونة الفرع (جديدة) + شارة Open/Closed
                Row(
                  children: [
                    Icon(
                      Icons.storefront_rounded, // أيقونة الفرع
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

            // ============================================================
            // ساعات العمل
            // ============================================================
            if (branch.isOpen24 ||
                branch.openTime != null ||
                branch.closeTime != null)
              _infoRow(
                context,
                Icons.access_time_rounded,
                'Working hours',
                branch.isOpen24
                    ? 'Open 24 Hours'
                    : '${_formatTime(branch.openTime)} - '
                          '${_formatTime(branch.closeTime)}',
              ),

            // ============================================================
            // وقت الانتظار
            // ============================================================
            if (branch.waitingTime > 0) ...[
              const SizedBox(height: 12),
              _infoRow(
                context,
                Icons.timer_outlined,
                'Waiting time',
                '${branch.waitingTime} minutes',
              ),
            ],

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

            // ============================================================
            // زر Get Directions + زر التقييم
            // ============================================================
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: _openMap,
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
                      onPressed: _openGoogleReview,
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
  // شارة Open/Closed
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
  // سطر المعلومات (ساعات العمل / وقت الانتظار)
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
  // سطر الهاتف
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
            onPressed: () => _callPhone(phone),
            icon: const Icon(Icons.call_rounded),
          ),
        ],
      ),
    );
  }
}
