//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import 'SettingsScreen.dart';
//
// void showSettingsSidebar(BuildContext context) {
//   final isRTL = context.locale.languageCode == 'ar';
//
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: 'Settings',
//     barrierColor: Colors.black.withOpacity(0.45),
//     transitionDuration: const Duration(milliseconds: 350),
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return _SettingsSidebar(isRTL: isRTL);
//     },
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       final beginOffset = isRTL ? const Offset(-1, 0) : const Offset(1, 0);
//
//       final slideAnimation = Tween<Offset>(
//         begin: beginOffset,
//         end: Offset.zero,
//       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
//
//       return SlideTransition(position: slideAnimation, child: child);
//     },
//   );
// }
//
// class _SettingsSidebar extends StatefulWidget {
//   final bool isRTL;
//
//   const _SettingsSidebar({required this.isRTL});
//
//   @override
//   State<_SettingsSidebar> createState() => _SettingsSidebarState();
// }
//
// class _SettingsSidebarState extends State<_SettingsSidebar> {
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Align(
//       alignment: widget.isRTL ? Alignment.centerLeft : Alignment.centerRight,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           width: screenWidth * 0.88,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: isDarkMode
//                 ? const Color(0xFF1A1A1A)
//                 : const Color(0xFFF9F6F8),
//             borderRadius: BorderRadius.only(
//               topLeft: widget.isRTL ? Radius.zero : const Radius.circular(28),
//               bottomLeft: widget.isRTL
//                   ? Radius.zero
//                   : const Radius.circular(28),
//               topRight: widget.isRTL ? const Radius.circular(28) : Radius.zero,
//               bottomRight: widget.isRTL
//                   ? const Radius.circular(28)
//                   : Radius.zero,
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
//                   child: Row(
//                     children: [
//                       if (!widget.isRTL) ...[
//                         Container(
//                           width: 46,
//                           height: 46,
//                           decoration: BoxDecoration(
//                             color: primaryColor.withOpacity(0.10),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: const Icon(
//                             Icons.settings_rounded,
//                             color: primaryColor,
//                             size: 24,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'lb_settings'.tr(),
//                               style: TextStyle(
//                                 fontSize: 21,
//                                 fontWeight: FontWeight.w700,
//                                 color: isDarkMode ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                       ],
//                       if (widget.isRTL) ...[
//                         IconButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           icon: Icon(
//                             Icons.close_rounded,
//                             size: 26,
//                             color: isDarkMode ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const Spacer(),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               'lb_settings'.tr(),
//                               style: TextStyle(
//                                 fontSize: 21,
//                                 fontWeight: FontWeight.w700,
//                                 color: isDarkMode ? Colors.white : Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 12),
//                         // Container(
//                         //   width: 46,
//                         //   height: 46,
//                         //   decoration: BoxDecoration(
//                         //     color: primaryColor.withOpacity(0.10),
//                         //     borderRadius: BorderRadius.circular(15),
//                         //   ),
//                         //   child: const Icon(
//                         //     Icons.settings_rounded,
//                         //     color: primaryColor,
//                         //     size: 24,
//                         //   ),
//                         // ),
//                       ],
//                       // if (!widget.isRTL) ...[
//                       //   IconButton(
//                       //     onPressed: () {
//                       //       Navigator.of(context).pop();
//                       //     },
//                       //     icon: Icon(
//                       //       Icons.close_rounded,
//                       //       size: 26,
//                       //       color: isDarkMode ? Colors.white : Colors.black,
//                       //     ),
//                       //   ),
//                       // ],
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: SettingsContent(), // ✅ تم إزالة darkMode
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 50, top: 4),
//                   child: Text(
//                     'SENSE Loyalty',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: isDarkMode
//                           ? Colors.grey.shade400
//                           : Colors.grey.shade500,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showSettingsSidebar(BuildContext context) async {
  final isRTL = context.locale.languageCode == 'ar';

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Settings',
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _SettingsSidebar(isRTL: isRTL);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final beginOffset = isRTL ? const Offset(-1, 0) : const Offset(1, 0);

      final slideAnimation = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return SlideTransition(position: slideAnimation, child: child);
    },
  );
}

class _SettingsSidebar extends StatefulWidget {
  final bool isRTL;

  const _SettingsSidebar({required this.isRTL});

  @override
  State<_SettingsSidebar> createState() => _SettingsSidebarState();
}

class _SettingsSidebarState extends State<_SettingsSidebar> {
  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: widget.isRTL ? Alignment.centerLeft : Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth * 0.88,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF1A1A1A)
                : const Color(0xFFF9F6F8),
            borderRadius: BorderRadius.only(
              topLeft: widget.isRTL ? Radius.zero : const Radius.circular(28),
              bottomLeft: widget.isRTL
                  ? Radius.zero
                  : const Radius.circular(28),
              topRight: widget.isRTL ? const Radius.circular(28) : Radius.zero,
              bottomRight: widget.isRTL
                  ? const Radius.circular(28)
                  : Radius.zero,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                  child: Row(
                    children: [
                      if (!widget.isRTL) ...[
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.settings_rounded,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'lb_settings'.tr(),
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                      if (widget.isRTL) ...[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            size: 26,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'lb_settings'.tr(),
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                      ],
                    ],
                  ),
                ),
                // const SizedBox(height: 16),
                // Expanded(child: SettingsContent()),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 50, top: 4),
                //   child: Text(
                //     'SENSE Loyalty',
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: isDarkMode
                //           ? Colors.grey.shade400
                //           : Colors.grey.shade500,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
