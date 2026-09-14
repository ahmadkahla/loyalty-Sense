// import 'package:flutter/material.dart';
// import 'package:loyalty/settings/settings_menu.dart';
//
// import 'notification/screen.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String userName;
//
//   /// 👈 عنوان الشاشة
//   /// إذا null → يظهر الترحيب + الاسم (شاشة Home)
//   /// إذا موجود → يظهر اسم الشاشة في المنتصف (باقي الشاشات)
//   final String? screenTitle;
//
//   /// 👈 أيقونة الشاشة (اختياري)
//   final IconData? screenIcon;
//
//   /// 👈 callback ينشغل بعد ما ينسدّ الـ Settings sidebar
//   /// عشان نقدر نحدّث الاسم
//   final VoidCallback? onSettingsClosed;
//
//   const CustomAppBar({
//     super.key,
//     required this.userName,
//     this.screenTitle,
//     this.screenIcon,
//     this.onSettingsClosed,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Size get preferredSize => const Size.fromHeight(100);
//
//   // ================================================================
//   // GREETING
//   // ================================================================
//
//   String get _greeting {
//     final hour = DateTime.now().hour;
//
//     if (hour >= 5 && hour < 12) {
//       return 'Good morning';
//     } else if (hour >= 12 && hour < 18) {
//       return 'Good afternoon';
//     } else if (hour >= 18 && hour < 24) {
//       return 'Good evening';
//     } else {
//       return 'Good night';
//     }
//   }
//
//   IconData get _greetingIcon {
//     final hour = DateTime.now().hour;
//
//     if (hour >= 5 && hour < 12) {
//       return Icons.wb_sunny_rounded;
//     } else if (hour >= 12 && hour < 18) {
//       return Icons.wb_twilight_rounded;
//     } else if (hour >= 18 && hour < 24) {
//       return Icons.nightlight_round;
//     } else {
//       return Icons.bedtime_rounded;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     // 👈 نفس لون خلفية الشاشة
//     final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
//
//     final bool showGreeting =
//         screenTitle == null || screenTitle!.trim().isEmpty;
//
//     return SafeArea(
//       bottom: false,
//       child: Container(
//         // 👈 بدون حواف ولا gradient — نفس لون الشاشة
//         color: backgroundColor,
//
//         padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
//
//         child: SizedBox(
//           height: 72, // 👈 ارتفاع ثابت بسيط
//
//           child: showGreeting
//               ? _buildHomeBar(context, isDark)
//               : _buildTitleBar(context, isDark),
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // HOME BAR (الترحيب + الاسم + الأزرار)
//   // ================================================================
//
//   Widget _buildHomeBar(BuildContext context, bool isDark) {
//     return Row(
//       children: [
//         // ========================================================
//         // GREETING ICON
//         // ========================================================
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: isDark
//                 ? const Color(0xFFA5005A).withOpacity(0.18)
//                 : const Color(0xFF6C3A63).withOpacity(0.10),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             _greetingIcon,
//             color: isDark ? const Color(0xFFDFA0C4) : const Color(0xFF6C3A63),
//             size: 24,
//           ),
//         ),
//
//         const SizedBox(width: 12),
//
//         // ========================================================
//         // GREETING TEXT
//         // ========================================================
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Flexible(
//                     child: Text(
//                       _greeting,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: isDark
//                             ? const Color(0xFFDFA0C4)
//                             : const Color(0xFF6C3A63),
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 5),
//
//                   const Text(
//                     '✦',
//                     style: TextStyle(fontSize: 12, color: Color(0xFFA5005A)),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 2),
//
//               Text(
//                 '$userName 👋',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 19,
//                   fontWeight: FontWeight.w800,
//                   color: isDark ? Colors.white : const Color(0xFF242124),
//                   letterSpacing: -0.2,
//                 ),
//               ),
//
//               const SizedBox(height: 4),
//
//               // الخط البنفسجي (يظهر فقط في Home)
//               Container(
//                 width: 28,
//                 height: 2.5,
//                 decoration: BoxDecoration(
//                   color: primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // ========================================================
//         // NOTIFICATIONS
//         // ========================================================
//         _AppBarIconButton(
//           icon: Icons.notifications_none_rounded,
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const NotificationsScreen(),
//               ),
//             );
//           },
//         ),
//
//         const SizedBox(width: 4),
//
//         // ========================================================
//         // SETTINGS 👈 معدّل عشان ينادي onSettingsClosed
//         // ========================================================
//         _AppBarIconButton(
//           icon: Icons.settings_outlined,
//           onTap: () async {
//             await showSettingsSidebar(context);
//             onSettingsClosed?.call();
//           },
//         ),
//       ],
//     );
//   }
//
//   // ================================================================
//   // TITLE BAR (اسم الشاشة في المنتصف + الأزرار)
//   // ================================================================
//
//   Widget _buildTitleBar(BuildContext context, bool isDark) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         // ========================================================
//         // TITLE (في المنتصف تماماً)
//         // ========================================================
//         Center(
//           child: Text(
//             screenTitle ?? '',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//               color: isDark ? Colors.white : const Color(0xFF242124),
//               letterSpacing: -0.2,
//             ),
//           ),
//         ),
//
//         // ========================================================
//         // NOTIFICATIONS + SETTINGS (على اليمين)
//         // ========================================================
//         Positioned(
//           right: 0,
//           top: 0,
//           bottom: 0,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _AppBarIconButton(
//                 icon: Icons.notifications_none_rounded,
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const NotificationsScreen(),
//                     ),
//                   );
//                 },
//               ),
//
//               const SizedBox(width: 4),
//
//               // 👈 معدّل عشان ينادي onSettingsClosed
//               _AppBarIconButton(
//                 icon: Icons.settings_outlined,
//                 onTap: () async {
//                   await showSettingsSidebar(context);
//                   onSettingsClosed?.call();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ================================================================
// // APPBAR ICON BUTTON
// // ================================================================
//
// class _AppBarIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//
//   const _AppBarIconButton({required this.icon, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Material(
//       color: isDark
//           ? Colors.white.withOpacity(0.08)
//           : Colors.white.withOpacity(0.55),
//       shape: const CircleBorder(),
//       child: InkWell(
//         onTap: onTap,
//         customBorder: const CircleBorder(),
//         child: SizedBox(
//           width: 42,
//           height: 42,
//           child: Icon(
//             icon,
//             size: 22,
//             color: isDark ? Colors.white : CustomAppBar.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// import 'notification/screen.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String userName;
//
//   final String? screenTitle;
//
//   /// 👈 أيقونة الشاشة (اختياري)
//   final IconData? screenIcon;
//
//   /// 👈 callback ينشغل بعد ما ينسدّ الـ Settings sidebar
//   /// عشان نقدر نحدّث الاسم
//   final VoidCallback? onSettingsClosed;
//
//   const CustomAppBar({
//     super.key,
//     required this.userName,
//     this.screenTitle,
//     this.screenIcon,
//     this.onSettingsClosed,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Size get preferredSize => const Size.fromHeight(100);
//
//   // ================================================================
//   // GREETING
//   // ================================================================
//
//   String get _greeting => 'Welcome back';
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     // 👈 نفس لون خلفية الشاشة
//     final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
//
//     final bool showGreeting =
//         screenTitle == null || screenTitle!.trim().isEmpty;
//
//     return SafeArea(
//       bottom: false,
//       child: Container(
//         // 👈 بدون حواف ولا gradient — نفس لون الشاشة
//         color: backgroundColor,
//
//         padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
//
//         child: SizedBox(
//           height: 72, // 👈 ارتفاع ثابت بسيط
//
//           child: showGreeting
//               ? _buildHomeBar(context, isDark)
//               : _buildTitleBar(context, isDark),
//         ),
//       ),
//     );
//   }
//
//   // ================================================================
//   // HOME BAR (الترحيب + الاسم + الأزرار)
//   // ================================================================
//
//   Widget _buildHomeBar(BuildContext context, bool isDark) {
//     return Row(
//       children: [
//         // ========================================================
//         // GREETING TEXT
//         // ========================================================
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Flexible(
//                     child: Text(
//                       _greeting,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: isDark
//                             ? const Color(0xFFDFA0C4)
//                             : const Color(0xFF6C3A63),
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 5),
//
//                   const Text(
//                     '✦',
//                     style: TextStyle(fontSize: 12, color: Color(0xFFA5005A)),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 2),
//
//               // 👈 الاسم + القلب بجانبه
//               Row(
//                 children: [
//                   Flexible(
//                     child: Text(
//                       userName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w800,
//                         color: isDark ? Colors.white : const Color(0xFF242124),
//                         letterSpacing: -0.2,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   const Icon(
//                     Icons.favorite_rounded,
//                     size: 20,
//                     color: Color(0xFFA5005A),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//
//         // ========================================================
//         // NOTIFICATIONS
//         // ========================================================
//         _AppBarIconButton(
//           icon: Icons.notifications_none_rounded,
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const NotificationsScreen(),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTitleBar(BuildContext context, bool isDark) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Center(
//           child: Text(
//             screenTitle ?? '',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//               color: isDark ? Colors.white : const Color(0xFF242124),
//               letterSpacing: -0.2,
//             ),
//           ),
//         ),
//
//         Positioned(
//           right: 0,
//           top: 0,
//           bottom: 0,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _AppBarIconButton(
//                 icon: Icons.notifications_none_rounded,
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const NotificationsScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ================================================================
// // APPBAR ICON BUTTON
// // ================================================================
//
// class _AppBarIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//
//   const _AppBarIconButton({required this.icon, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Material(
//       color: isDark
//           ? Colors.white.withOpacity(0.08)
//           : Colors.white.withOpacity(0.55),
//       shape: const CircleBorder(),
//       child: InkWell(
//         onTap: onTap,
//         customBorder: const CircleBorder(),
//         child: SizedBox(
//           width: 42,
//           height: 42,
//           child: Icon(
//             icon,
//             size: 22,
//             color: isDark ? Colors.white : CustomAppBar.primaryColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'notification/screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  final String? screenTitle;

  /// 👈 أيقونة الشاشة (اختياري)
  final IconData? screenIcon;

  /// 👈 callback ينشغل بعد ما ينسدّ الـ Settings sidebar
  /// عشان نقدر نحدّث الاسم
  final VoidCallback? onSettingsClosed;

  const CustomAppBar({
    super.key,
    required this.userName,
    this.screenTitle,
    this.screenIcon,
    this.onSettingsClosed,
  });

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  // ================================================================
  // GREETING
  // ================================================================

  String get _greeting => 'Welcome back';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 👈 نفس لون خلفية الشاشة
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    final bool showGreeting =
        screenTitle == null || screenTitle!.trim().isEmpty;

    return SafeArea(
      bottom: false,
      child: Container(
        // 👈 بدون حواف ولا gradient — نفس لون الشاشة
        color: backgroundColor,

        padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),

        child: SizedBox(
          height: 72, // 👈 ارتفاع ثابت بسيط

          child: showGreeting
              ? _buildHomeBar(context, isDark)
              : _buildTitleBar(context, isDark),
        ),
      ),
    );
  }

  // ================================================================
  // HOME BAR (الترحيب + الاسم + الأزرار)
  // ================================================================

  Widget _buildHomeBar(BuildContext context, bool isDark) {
    return Row(
      children: [
        // ========================================================
        // 👈 AVATAR ICON
        // ========================================================
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFA5005A), Color(0xFFD41473)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: CustomAppBar.primaryColor.withOpacity(0.30),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),

        const SizedBox(width: 12),

        // ========================================================
        // GREETING TEXT
        // ========================================================
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👈 "Welcome back" بدون نجمة
              Text(
                _greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFFDFA0C4)
                      : const Color(0xFF6C3A63),
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 2),

              // 👈 الاسم + القلب
              Row(
                children: [
                  Flexible(
                    child: Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF242124),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.favorite_rounded,
                    size: 20,
                    color: Color(0xFFA5005A),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ========================================================
        // NOTIFICATIONS
        // ========================================================
        _AppBarIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  // ================================================================
  // TITLE BAR (اسم الشاشة في المنتصف + الأزرار)
  // ================================================================

  Widget _buildTitleBar(BuildContext context, bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ========================================================
        // TITLE (في المنتصف تماماً)
        // ========================================================
        Center(
          child: Text(
            screenTitle ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF242124),
              letterSpacing: -0.2,
            ),
          ),
        ),

        // ========================================================
        // NOTIFICATIONS (على اليمين)
        // ========================================================
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AppBarIconButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================================================================
// APPBAR ICON BUTTON
// ================================================================

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark
          ? Colors.white.withOpacity(0.08)
          : Colors.white.withOpacity(0.55),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            size: 22,
            color: isDark ? Colors.white : CustomAppBar.primaryColor,
          ),
        ),
      ),
    );
  }
}
