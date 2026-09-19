//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ThemeProvider.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'settings'.tr(),
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: const SettingsContent(),
//     );
//   }
// }
//
// class SettingsContent extends StatelessWidget {
//   const SettingsContent({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     // الحصول على اللغة الحالية من context
//     final currentLocale = context.locale;
//     final currentLanguageLabel = currentLocale.languageCode == 'ar'
//         ? 'arabic'.tr()
//         : 'english'.tr();
//
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             _sectionTitle('general'.tr()),
//
//             const SizedBox(height: 8),
//
//             // ============================================================
//             // LANGUAGE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.language_outlined,
//               title: 'language'.tr(),
//               trailing: Text(
//                 currentLanguageLabel,
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//               onTap: () {
//                 _showLanguageDialog(context);
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // DARK MODE (معدل - مرتبط مع ThemeProvider)
//             // ============================================================
//             _SettingTile(
//               icon: Icons.dark_mode_outlined,
//               title: 'dark_mode'.tr(),
//               trailing: Switch(
//                 value: themeProvider.isDarkMode,
//                 activeColor: primaryColor,
//                 onChanged: (value) async {
//                   await themeProvider.toggleTheme();
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _sectionTitle('others'.tr()),
//
//             const SizedBox(height: 6),
//
//             // 👈 حُذف Our Branches
//             // 👈 حُذف About Us
//             _SettingTile(
//               icon: Icons.privacy_tip_outlined,
//               title: 'privacy_policy'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'privacy_policy'.tr());
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             _SettingTile(
//               icon: Icons.description_outlined,
//               title: 'terms_conditions'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'terms_conditions'.tr());
//               },
//             ),
//
//             const SizedBox(height: 10),
//
//             _sectionTitle('account_actions'.tr()),
//
//             const SizedBox(height: 5),
//
//             _SettingTile(
//               icon: Icons.login_outlined,
//               title: 'login'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'login'.tr());
//               },
//             ),
//
//             const SizedBox(height: 10),
//
//             // ============================================================
//             // SOCIAL MEDIA
//             // ============================================================
//             // _sectionTitle('follow_us'.tr()),
//             const SizedBox(height: 6),
//
//             // const _SocialMediaSection(),
//             const SizedBox(height: 20),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     final currentLocale = context.locale;
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text('language'.tr()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile<String>(
//                 value: 'en',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('english'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'en');
//                 },
//               ),
//               RadioListTile<String>(
//                 value: 'ar',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('arabic'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'ar');
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _changeLanguage(
//     BuildContext context,
//     BuildContext dialogContext,
//     String languageCode,
//   ) {
//     // إغلاق الـ Dialog
//     Navigator.of(dialogContext).pop();
//
//     // تغيير اللغة
//     context.setLocale(Locale(languageCode));
//
//     // عرض رسالة تأكيد
//     final message = languageCode == 'ar'
//         ? 'language_changed_to_arabic'.tr()
//         : 'language_changed_to_english'.tr();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   void _showComingSoon(BuildContext context, String title) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('$title ${"coming_soon".tr()}')));
//   }
// }
//
// class _SettingTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//
//   const _SettingTile({
//     required this.icon,
//     required this.title,
//     this.trailing,
//     this.onTap,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 57,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 2),
//
//               Icon(icon, color: primaryColor),
//
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               trailing ??
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ProfileScreen.dart';
// import '../ThemeProvider.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'settings'.tr(),
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: const SettingsContent(),
//     );
//   }
// }
//
// class SettingsContent extends StatelessWidget {
//   const SettingsContent({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     // الحصول على اللغة الحالية من context
//     final currentLocale = context.locale;
//     final currentLanguageLabel = currentLocale.languageCode == 'ar'
//         ? 'arabic'.tr()
//         : 'english'.tr();
//
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             _sectionTitle('general'.tr()),
//
//             const SizedBox(height: 8),
//
//             // ============================================================
//             // MY PROFILE 👈 جديد
//             // ============================================================
//             _SettingTile(
//               icon: Icons.person_outline_rounded,
//               title: 'my_profile'.tr(),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const ProfileScreen(),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // LANGUAGE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.language_outlined,
//               title: 'language'.tr(),
//               trailing: Text(
//                 currentLanguageLabel,
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//               onTap: () {
//                 _showLanguageDialog(context);
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // DARK MODE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.dark_mode_outlined,
//               title: 'dark_mode'.tr(),
//               trailing: Switch(
//                 value: themeProvider.isDarkMode,
//                 activeColor: primaryColor,
//                 onChanged: (value) async {
//                   await themeProvider.toggleTheme();
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _sectionTitle('others'.tr()),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // PRIVACY POLICY
//             // ============================================================
//             _SettingTile(
//               icon: Icons.privacy_tip_outlined,
//               title: 'privacy_policy'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'privacy_policy'.tr());
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // TERMS & CONDITIONS
//             // ============================================================
//             _SettingTile(
//               icon: Icons.description_outlined,
//               title: 'terms_conditions'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'terms_conditions'.tr());
//               },
//             ),
//
//             const SizedBox(height: 10),
//
//             _sectionTitle('account_actions'.tr()),
//
//             const SizedBox(height: 5),
//
//             // ============================================================
//             // LOGIN
//             // ============================================================
//             _SettingTile(
//               icon: Icons.login_outlined,
//               title: 'login'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'login'.tr());
//               },
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     final currentLocale = context.locale;
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text('language'.tr()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile<String>(
//                 value: 'en',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('english'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'en');
//                 },
//               ),
//               RadioListTile<String>(
//                 value: 'ar',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('arabic'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'ar');
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _changeLanguage(
//     BuildContext context,
//     BuildContext dialogContext,
//     String languageCode,
//   ) {
//     // إغلاق الـ Dialog
//     Navigator.of(dialogContext).pop();
//
//     // تغيير اللغة
//     context.setLocale(Locale(languageCode));
//
//     // عرض رسالة تأكيد
//     final message = languageCode == 'ar'
//         ? 'language_changed_to_arabic'.tr()
//         : 'language_changed_to_english'.tr();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   void _showComingSoon(BuildContext context, String title) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('$title ${"coming_soon".tr()}')));
//   }
// }
//
// // ================================================================
// // SETTING TILE
// // ================================================================
//
// class _SettingTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//
//   const _SettingTile({
//     required this.icon,
//     required this.title,
//     this.trailing,
//     this.onTap,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 57,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 2),
//
//               Icon(icon, color: primaryColor),
//
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               trailing ??
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ProfileScreen.dart';
// import '../ThemeProvider.dart';
// import '../aboutUS_screen.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       //   title: Text(
//       //     'settings'.tr(),
//       //     style: const TextStyle(fontWeight: FontWeight.w600),
//       //   ),
//       // ),
//       body: const SettingsContent(),
//     );
//   }
// }
//
// class SettingsContent extends StatelessWidget {
//   const SettingsContent({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final currentLocale = context.locale;
//     final currentLanguageLabel = currentLocale.languageCode == 'ar'
//         ? 'arabic'.tr()
//         : 'english'.tr();
//
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             _sectionTitle('general'.tr()),
//
//             const SizedBox(height: 8),
//
//             // ============================================================
//             // MY PROFILE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.person_outline_rounded,
//               title: 'My Profile'.tr(),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const ProfileScreen(),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // LANGUAGE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.language_outlined,
//               title: 'language'.tr(),
//               trailing: Text(
//                 currentLanguageLabel,
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//               onTap: () {
//                 _showLanguageDialog(context);
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // DARK MODE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.dark_mode_outlined,
//               title: 'dark_mode'.tr(),
//               trailing: Switch(
//                 value: themeProvider.isDarkMode,
//                 activeColor: primaryColor,
//                 onChanged: (value) async {
//                   await themeProvider.toggleTheme();
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _sectionTitle('others'.tr()),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // PRIVACY POLICY
//             // ============================================================
//             // _SettingTile(
//             //   icon: Icons.notifications_none_rounded,
//             //   title: 'notifications'.tr(),
//             //   onTap: () {
//             //     Navigator.of(context).push(
//             //       MaterialPageRoute(
//             //         builder: (context) => const NotificationsScreen(),
//             //       ),
//             //     );
//             //   },
//             // ),
//             _SettingTile(
//               icon: Icons.info_outline,
//               title: 'about_us'.tr(),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         const AboutUsScreen(), // 👈 استبدل باسم شاشة About عندك
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 6),
//             _SettingTile(
//               icon: Icons.privacy_tip_outlined,
//               title: 'privacy_policy'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'privacy_policy'.tr());
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             _SettingTile(
//               icon: Icons.description_outlined,
//               title: 'terms_conditions'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'terms_conditions'.tr());
//               },
//             ),
//
//             // const SizedBox(height: 10),
//             //
//             // _sectionTitle('account_actions'.tr()),
//             //
//             // const SizedBox(height: 5),
//
//             // _SettingTile(
//             //   icon: Icons.login_outlined,
//             //   title: 'login'.tr(),
//             //   onTap: () {
//             //     _showComingSoon(context, 'login'.tr());
//             //   },
//             // ),
//             const SizedBox(height: 20),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     final currentLocale = context.locale;
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text('language'.tr()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile<String>(
//                 value: 'en',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('english'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'en');
//                 },
//               ),
//               RadioListTile<String>(
//                 value: 'ar',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('arabic'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//                   _changeLanguage(context, dialogContext, 'ar');
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _changeLanguage(
//     BuildContext context,
//     BuildContext dialogContext,
//     String languageCode,
//   ) {
//     // إغلاق الـ Dialog
//     Navigator.of(dialogContext).pop();
//
//     // تغيير اللغة
//     context.setLocale(Locale(languageCode));
//
//     // عرض رسالة تأكيد
//     final message = languageCode == 'ar'
//         ? 'language_changed_to_arabic'.tr()
//         : 'language_changed_to_english'.tr();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   void _showComingSoon(BuildContext context, String title) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('$title ${"coming_soon".tr()}')));
//   }
// }
//
// // ================================================================
// // SETTING TILE
// // ================================================================
//
// class _SettingTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//
//   const _SettingTile({
//     required this.icon,
//     required this.title,
//     this.trailing,
//     this.onTap,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 57,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 2),
//
//               Icon(icon, color: primaryColor),
//
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               trailing ??
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../ProfileScreen.dart';
// import '../ThemeProvider.dart';
// import '../aboutUS_screen.dart';
//
// class SettingsScreen extends StatefulWidget {
//   final String userName;
//   final String customerNo;
//
//   const SettingsScreen({
//     super.key,
//     required this.userName,
//     required this.customerNo,
//   });
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SettingsContent(
//         userName: widget.userName,
//         customerNo: widget.customerNo,
//       ),
//     );
//   }
// }
//
// class SettingsContent extends StatelessWidget {
//   final String userName;
//   final String customerNo;
//
//   const SettingsContent({
//     super.key,
//     required this.userName,
//     required this.customerNo,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final currentLocale = context.locale;
//
//     final currentLanguageLabel = currentLocale.languageCode == 'ar'
//         ? 'arabic'.tr()
//         : 'english'.tr();
//
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             // ============================================================
//             // GENERAL
//             // ============================================================
//
//             _sectionTitle('general'.tr()),
//
//             const SizedBox(height: 8),
//
//             // ============================================================
//             // MY PROFILE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.person_outline_rounded,
//               title: 'My Profile'.tr(),
//               onTap: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ProfileScreen(
//                       userName: userName,
//                       customerNo: customerNo,
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // LANGUAGE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.language_outlined,
//               title: 'language'.tr(),
//               trailing: Text(
//                 currentLanguageLabel,
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//               onTap: () {
//                 _showLanguageDialog(context);
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // DARK MODE
//             // ============================================================
//             _SettingTile(
//               icon: Icons.dark_mode_outlined,
//               title: 'dark_mode'.tr(),
//               trailing: Switch(
//                 value: themeProvider.isDarkMode,
//                 activeColor: primaryColor,
//                 onChanged: (value) async {
//                   await themeProvider.toggleTheme();
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // ============================================================
//             // OTHERS
//             // ============================================================
//             _sectionTitle('others'.tr()),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // ABOUT US
//             // ============================================================
//             _SettingTile(
//               icon: Icons.info_outline,
//               title: 'about_us'.tr(),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const AboutUsScreen(),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // PRIVACY POLICY
//             // ============================================================
//             _SettingTile(
//               icon: Icons.privacy_tip_outlined,
//               title: 'privacy_policy'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'privacy_policy'.tr());
//               },
//             ),
//
//             const SizedBox(height: 6),
//
//             // ============================================================
//             // TERMS & CONDITIONS
//             // ============================================================
//             _SettingTile(
//               icon: Icons.description_outlined,
//               title: 'terms_conditions'.tr(),
//               onTap: () {
//                 _showComingSoon(context, 'terms_conditions'.tr());
//               },
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         );
//       },
//     );
//   }
//
//   // ================================================================
//   // SECTION TITLE
//   // ================================================================
//
//   Widget _sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//     );
//   }
//
//   // ================================================================
//   // LANGUAGE DIALOG
//   // ================================================================
//
//   void _showLanguageDialog(BuildContext context) {
//     final currentLocale = context.locale;
//
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: Text('language'.tr()),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ==========================================================
//               // ENGLISH
//               // ==========================================================
//
//               RadioListTile<String>(
//                 value: 'en',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('english'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//
//                   _changeLanguage(context, dialogContext, 'en');
//                 },
//               ),
//
//               // ==========================================================
//               // ARABIC
//               // ==========================================================
//               RadioListTile<String>(
//                 value: 'ar',
//                 groupValue: currentLocale.languageCode,
//                 title: Text('arabic'.tr()),
//                 activeColor: primaryColor,
//                 onChanged: (value) {
//                   if (value == null) return;
//
//                   _changeLanguage(context, dialogContext, 'ar');
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // ================================================================
//   // CHANGE LANGUAGE
//   // ================================================================
//
//   void _changeLanguage(
//     BuildContext context,
//     BuildContext dialogContext,
//     String languageCode,
//   ) {
//     // إغلاق الـ Dialog
//     Navigator.of(dialogContext).pop();
//
//     // تغيير اللغة
//     context.setLocale(Locale(languageCode));
//
//     // رسالة تأكيد
//     final message = languageCode == 'ar'
//         ? 'language_changed_to_arabic'.tr()
//         : 'language_changed_to_english'.tr();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
//
//   // ================================================================
//   // COMING SOON
//   // ================================================================
//
//   void _showComingSoon(BuildContext context, String title) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('$title ${"coming_soon".tr()}')));
//   }
// }
//
// // ====================================================================
// // SETTING TILE
// // ====================================================================
//
// class _SettingTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//
//   const _SettingTile({
//     required this.icon,
//     required this.title,
//     this.trailing,
//     this.onTap,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 57,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 2),
//
//               // ========================================================
//               // ICON
//               // ========================================================
//               Icon(icon, color: primaryColor),
//
//               const SizedBox(width: 12),
//
//               // ========================================================
//               // TITLE
//               // ========================================================
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               // ========================================================
//               // TRAILING
//               // ========================================================
//               trailing ??
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ProfileScreen.dart';
import '../ThemeProvider.dart';
import '../aboutUS_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String userName;
  final String customerNo;
  final String phoneNumber;

  const SettingsScreen({
    super.key,
    required this.userName,
    required this.customerNo,
    required this.phoneNumber,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SettingsContent(
        userName: widget.userName,
        customerNo: widget.customerNo,
        phoneNumber: widget.phoneNumber,
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  final String userName;
  final String customerNo;
  final String phoneNumber;

  const SettingsContent({
    super.key,
    required this.userName,
    required this.customerNo,
    required this.phoneNumber,
  });

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    final currentLanguageLabel = currentLocale.languageCode == 'ar'
        ? 'arabic'.tr()
        : 'english'.tr();

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ============================================================
            // GENERAL
            // ============================================================

            _sectionTitle('general'.tr()),

            const SizedBox(height: 8),

            // ============================================================
            // MY PROFILE
            // ============================================================
            _SettingTile(
              icon: Icons.person_outline_rounded,
              title: 'My Profile'.tr(),
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      userName: userName,
                      customerNo: customerNo,
                      phoneNumber: phoneNumber,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 6),

            // ============================================================
            // LANGUAGE
            // ============================================================
            _SettingTile(
              icon: Icons.language_outlined,
              title: 'language'.tr(),
              trailing: Text(
                currentLanguageLabel,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),

            const SizedBox(height: 6),

            // ============================================================
            // DARK MODE
            // ============================================================
            _SettingTile(
              icon: Icons.dark_mode_outlined,
              title: 'dark_mode'.tr(),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                activeColor: primaryColor,
                onChanged: (value) async {
                  await themeProvider.toggleTheme();
                },
              ),
            ),

            const SizedBox(height: 10),

            // ============================================================
            // OTHERS
            // ============================================================
            _sectionTitle('others'.tr()),

            const SizedBox(height: 6),

            // ============================================================
            // ABOUT US
            // ============================================================
            _SettingTile(
              icon: Icons.info_outline,
              title: 'about_us'.tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 6),

            // ============================================================
            // PRIVACY POLICY
            // ============================================================
            _SettingTile(
              icon: Icons.privacy_tip_outlined,
              title: 'privacy_policy'.tr(),
              onTap: () {
                _showComingSoon(context, 'privacy_policy'.tr());
              },
            ),

            const SizedBox(height: 6),

            // ============================================================
            // TERMS & CONDITIONS
            // ============================================================
            _SettingTile(
              icon: Icons.description_outlined,
              title: 'terms_conditions'.tr(),
              onTap: () {
                _showComingSoon(context, 'terms_conditions'.tr());
              },
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

  // ================================================================
  // LANGUAGE DIALOG
  // ================================================================

  void _showLanguageDialog(BuildContext context) {
    final currentLocale = context.locale;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('language'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ==========================================================
              // ENGLISH
              // ==========================================================

              RadioListTile<String>(
                value: 'en',
                groupValue: currentLocale.languageCode,
                title: Text('english'.tr()),
                activeColor: primaryColor,
                onChanged: (value) {
                  if (value == null) return;

                  _changeLanguage(context, dialogContext, 'en');
                },
              ),

              // ==========================================================
              // ARABIC
              // ==========================================================
              RadioListTile<String>(
                value: 'ar',
                groupValue: currentLocale.languageCode,
                title: Text('arabic'.tr()),
                activeColor: primaryColor,
                onChanged: (value) {
                  if (value == null) return;

                  _changeLanguage(context, dialogContext, 'ar');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================================================================
  // CHANGE LANGUAGE
  // ================================================================

  void _changeLanguage(
    BuildContext context,
    BuildContext dialogContext,
    String languageCode,
  ) {
    // إغلاق الـ Dialog
    Navigator.of(dialogContext).pop();

    // تغيير اللغة
    context.setLocale(Locale(languageCode));

    // رسالة تأكيد
    final message = languageCode == 'ar'
        ? 'language_changed_to_arabic'.tr()
        : 'language_changed_to_english'.tr();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ================================================================
  // COMING SOON
  // ================================================================

  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$title ${"coming_soon".tr()}')));
  }
}

// ====================================================================
// SETTING TILE
// ====================================================================

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  static const Color primaryColor = Color(0xFFA5005A);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 57,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              const SizedBox(width: 2),

              // ========================================================
              // ICON
              // ========================================================
              Icon(icon, color: primaryColor),

              const SizedBox(width: 12),

              // ========================================================
              // TITLE
              // ========================================================
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // ========================================================
              // TRAILING
              // ========================================================
              trailing ??
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
