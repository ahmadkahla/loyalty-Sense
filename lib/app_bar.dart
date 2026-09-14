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
//         // 👈 AVATAR ICON
//         // ========================================================
//         Container(
//           width: 46,
//           height: 46,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: const LinearGradient(
//               colors: [Color(0xFFA5005A), Color(0xFFD41473)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: CustomAppBar.primaryColor.withOpacity(0.30),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.person_rounded,
//             color: Colors.white,
//             size: 26,
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
//               // 👈 "Welcome back" بدون نجمة
//               Text(
//                 _greeting,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: isDark
//                       ? const Color(0xFFDFA0C4)
//                       : const Color(0xFF6C3A63),
//                   letterSpacing: 0.2,
//                 ),
//               ),
//
//               const SizedBox(height: 2),
//
//               // 👈 الاسم + القلب
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
//         // NOTIFICATIONS (على اليمين)
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
// // class _AppBarIconButton extends StatelessWidget {
// //   final IconData icon;
// //   final VoidCallback onTap;
// //
// //   const _AppBarIconButton({required this.icon, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Material(
// //       color: isDark
// //           ? Colors.white.withOpacity(0.08)
// //           : Colors.white.withOpacity(0.55),
// //       shape: const CircleBorder(),
// //       child: InkWell(
// //         onTap: onTap,
// //         customBorder: const CircleBorder(),
// //         child: SizedBox(
// //           width: 42,
// //           height: 42,
// //           child: Icon(
// //             icon,
// //             size: 22,
// //             color: isDark ? Colors.white : CustomAppBar.primaryColor,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// class _AppBarIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//
//   const _AppBarIconButton({required this.icon, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 46,
//         height: 46,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             colors: [Color(0xFFA5005A), Color(0xFFD41473)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: CustomAppBar.primaryColor.withOpacity(0.30),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 22),
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
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
//   // ============================================================
//   // 🎨 اللون الأساسي — من CMYK: 0/100/40/0
//   // ============================================================
//   static const Color primaryColor = Color(0xFFCC007A);
//
//   // ✨ تدرجات
//   static const Color primaryLight = Color(0xFFE6008A);
//   static const Color primaryDark = Color(0xFFCC007A);
//
//   @override
//   Size get preferredSize => const Size.fromHeight(100);
//
//   // ================================================================
//   // GREETING
//   // ================================================================
//
//   String get _greeting => 'Welcome_Back'.tr();
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
//         // 👈 AVATAR ICON
//         // ========================================================
//         Container(
//           width: 46,
//           height: 46,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: const LinearGradient(
//               // colors: [Color(0xFFFF0099), Color(0xFFFF33AD)],
//               colors: [Color(0xFFCC007A), Color(0xFFE6008A)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: CustomAppBar.primaryColor.withOpacity(0.30),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.person_rounded,
//             color: Colors.white,
//             size: 26,
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
//               // 👈 "Welcome back" بدون نجمة
//               Text(
//                 _greeting,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: isDark
//                       ? const Color(0xFFFFB3D9) // 🎨 جديد
//                       : const Color(0xFF7A5C6E), // 🎨 جديد
//                   letterSpacing: 0.2,
//                 ),
//               ),
//
//               const SizedBox(height: 2),
//
//               // 👈 الاسم + القلب
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
//                     // color: Color(0xFFFF0099),
//                     color: Color(0xFFCC007A),
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
//         // NOTIFICATIONS (على اليمين)
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
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 46,
//         height: 46,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             colors: [Color(0xFFCC007A), Color(0xFFCC007A)], // 🎨 جديد
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: CustomAppBar.primaryColor.withOpacity(0.30),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 22),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'ProfileScreen.dart';
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

  // ============================================================
  // 🎨 اللون الأساسي — من CMYK: 0/100/40/0
  // ============================================================
  static const Color primaryColor = Color(0xFFCC007A);

  // ✨ تدرجات
  static const Color primaryLight = Color(0xFFE6008A);
  static const Color primaryDark = Color(0xFFCC007A);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  // ================================================================
  // GREETING
  // ================================================================

  String get _greeting => 'Welcome_Back'.tr();

  // ================================================================
  // 🎯 OPEN PROFILE SCREEN
  // ================================================================
  Future<void> _openProfile(BuildContext context) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));

    if (onSettingsClosed != null) {
      onSettingsClosed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    final bool showGreeting =
        screenTitle == null || screenTitle!.trim().isEmpty;

    return SafeArea(
      bottom: false,
      child: Container(
        color: backgroundColor,

        padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),

        child: SizedBox(
          height: 72,

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
        // 👈 AVATAR ICON (قابل للضغط → My Profile)
        // ========================================================
        GestureDetector(
          onTap: () => _openProfile(context),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFCC007A), Color(0xFFE6008A)],
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
              Text(
                _greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFFFFB3D9)
                      : const Color(0xFF7A5C6E),
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 2),

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
                    color: Color(0xFFCC007A),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFCC007A), Color(0xFFCC007A)],
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
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
