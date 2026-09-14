// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import 'language_controller.dart';
//
// class LanguageScreen extends StatefulWidget {
//   const LanguageScreen({super.key});
//
//   static const String routeName = '/language';
//
//   @override
//   State<LanguageScreen> createState() => _LanguageScreenState();
// }
//
// class _LanguageScreenState extends State<LanguageScreen> {
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   late String selectedLanguage;
//
//   final LanguageController controller = LanguageController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Default language
//     selectedLanguage = 'en';
//
//     // Get the current language after EasyLocalization
//     // is attached to the widget tree.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;
//
//       final currentLanguage = context.locale.languageCode;
//
//       if (currentLanguage == 'en' || currentLanguage == 'ar') {
//         setState(() {
//           selectedLanguage = currentLanguage;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       // ============================================================
//       // APP BAR
//       // ============================================================
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//             size: 20,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//
//         title: Text(
//           'language'.tr(),
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//
//       // ============================================================
//       // BODY
//       // ============================================================
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//
//               Text(
//                 'language'.tr(),
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               Text(
//                 'choose_preferred_language'.tr(),
//                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//               ),
//
//               const SizedBox(height: 30),
//
//               // ======================================================
//               // ENGLISH
//               // ======================================================
//               _LanguageOption(
//                 title: 'english'.tr(),
//                 subtitle: 'english_subtitle'.tr(),
//                 languageCode: 'en',
//                 selectedLanguage: selectedLanguage,
//                 onTap: () {
//                   setState(() {
//                     selectedLanguage = 'en';
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 14),
//
//               // ======================================================
//               // ARABIC
//               // ======================================================
//               _LanguageOption(
//                 title: 'arabic'.tr(),
//                 subtitle: 'arabic_subtitle'.tr(),
//                 languageCode: 'ar',
//                 selectedLanguage: selectedLanguage,
//                 onTap: () {
//                   setState(() {
//                     selectedLanguage = 'ar';
//                   });
//                 },
//               ),
//
//               const Spacer(),
//
//               // ======================================================
//               // SAVE BUTTON
//               // ======================================================
//               SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     await LanguageController.setLanguage(
//                       context,
//                       selectedLanguage,
//                     );
//
//                     if (!mounted) return;
//
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: Text(
//                     'save'.tr(),
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ============================================================================
// // LANGUAGE OPTION
// // ============================================================================
//
// class _LanguageOption extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String languageCode;
//   final String selectedLanguage;
//   final VoidCallback onTap;
//
//   const _LanguageOption({
//     required this.title,
//     required this.subtitle,
//     required this.languageCode,
//     required this.selectedLanguage,
//     required this.onTap,
//   });
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = languageCode == selectedLanguage;
//
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? primaryColor.withValues(alpha: 0.06)
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: isSelected ? primaryColor : Colors.grey.shade200,
//               width: isSelected ? 1.5 : 1,
//             ),
//           ),
//           child: Row(
//             children: [
//               // ========================================================
//               // LANGUAGE ICON
//               // ========================================================
//               Container(
//                 width: 46,
//                 height: 46,
//                 decoration: BoxDecoration(
//                   color: isSelected ? primaryColor : Colors.grey.shade100,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.language,
//                   color: isSelected ? Colors.white : Colors.grey.shade600,
//                   size: 23,
//                 ),
//               ),
//
//               const SizedBox(width: 15),
//
//               // ========================================================
//               // TEXT
//               // ========================================================
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//
//                     const SizedBox(height: 4),
//
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // ========================================================
//               // RADIO
//               // ========================================================
//               Radio<String>(
//                 value: languageCode,
//                 groupValue: selectedLanguage,
//                 activeColor: primaryColor,
//                 onChanged: (_) {
//                   onTap();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
