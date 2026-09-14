// // import 'package:easy_localization/easy_localization.dart';
// // import 'package:flutter/material.dart';
// //
// // class LanguageController {
// //   static const String englishCode = 'en';
// //   static const String arabicCode = 'ar';
// //
// //   static Future<void> setLanguage(
// //     BuildContext context,
// //     String languageCode,
// //   ) async {
// //     if (languageCode != englishCode && languageCode != arabicCode) {
// //       return;
// //     }
// //
// //     await context.setLocale(Locale(languageCode));
// //   }
// // }
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class LanguageController {
//   static const String englishCode = 'en';
//   static const String arabicCode = 'ar';
//
//   static Future<void> setLanguage(
//     BuildContext context,
//     String languageCode,
//   ) async {
//     if (languageCode != englishCode && languageCode != arabicCode) {
//       return;
//     }
//
//     debugPrint(
//       '🌎 Changing language from '
//       '${context.locale.languageCode} to $languageCode',
//     );
//
//     if (context.locale.languageCode == languageCode) {
//       debugPrint('🌎 Language is already $languageCode');
//       return;
//     }
//
//     await context.setLocale(Locale(languageCode));
//
//     debugPrint(
//       '🌎 Locale changed successfully to '
//       '${context.locale.languageCode}',
//     );
//   }
// }
