// import 'package:flutter/material.dart';
//
// // ============================================================================
// // 🎨 الألوان — من CMYK: 0/100/40/0
// // ============================================================================
//
// class AppColors {
//   // 🎯 اللون الأساسي
//   static const Color primary = Color(0xFFFF0099);
//
//   // تدرجات
//   static const Color primaryLight = Color(0xFFFF33AD); // أفتح
//   static const Color primaryDark = Color(0xFFCC007A); // أغمق
//
//   // 🎨 خلفيات
//   static const Color backgroundLight = Color(0xFFFFF5FA); // وردي فاتح جداً
//   static const Color backgroundDark = Color(0xFF121212);
//   static const Color cardLight = Colors.white;
//   static const Color cardDark = Color(0xFF1E1E1E);
//
//   // 📝 نصوص
//   static const Color textPrimaryLight = Color(0xFF242124);
//   static const Color textSecondaryLight = Color(0xFF7A5C6E);
//   static const Color textPrimaryDark = Colors.white;
//   static const Color textSecondaryDark = Color(0xFFFFB3D9);
//
//   // ✅❌ حالات
//   static const Color success = Color(0xFF4CAF50);
//   static const Color error = Color(0xFFE53935);
//   static const Color warning = Color(0xFFFFA726);
//   static const Color info = Color(0xFF29B6F6);
// }
//
// class AppTheme {
//   static ThemeData light = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//
//     colorScheme: const ColorScheme.light(
//       primary: AppColors.primary,
//       secondary: AppColors.primaryLight,
//       surface: AppColors.cardLight,
//       error: AppColors.error,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: AppColors.textPrimaryLight,
//     ),
//
//     scaffoldBackgroundColor: AppColors.backgroundLight,
//     cardColor: AppColors.cardLight,
//
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.backgroundLight,
//       foregroundColor: AppColors.textPrimaryLight,
//       elevation: 0,
//     ),
//
//     iconTheme: const IconThemeData(color: AppColors.primary, size: 22),
//
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//     ),
//   );
//
//   static ThemeData dark = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//
//     colorScheme: const ColorScheme.dark(
//       primary: AppColors.primary,
//       secondary: AppColors.primaryLight,
//       surface: AppColors.cardDark,
//       error: AppColors.error,
//       onPrimary: Colors.white,
//       onSecondary: Colors.white,
//       onSurface: AppColors.textPrimaryDark,
//     ),
//
//     scaffoldBackgroundColor: AppColors.backgroundDark,
//     cardColor: AppColors.cardDark,
//
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.backgroundDark,
//       foregroundColor: AppColors.textPrimaryDark,
//       elevation: 0,
//     ),
//
//     iconTheme: const IconThemeData(color: AppColors.primary, size: 22),
//   );
// }

import 'package:flutter/material.dart';

// ============================================================================
// 🎨 الألوان — أغمق قليلاً
// ============================================================================

class AppColors {
  // 🎯 اللون الأساسي — أغمق 20%
  static const Color primary = Color(0xFFCC007A);

  // تدرجات
  static const Color primaryLight = Color(0xFFE6008A); // أفتح قليلاً
  static const Color primaryDark = Color(0xFF99005C); // أغمق

  // 🎨 خلفيات
  static const Color backgroundLight = Color(0xFFFFF5FA); // وردي فاتح جداً
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E1E1E);

  // 📝 نصوص
  static const Color textPrimaryLight = Color(0xFF242124);
  static const Color textSecondaryLight = Color(0xFF7A5C6E);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFFFB3D9);

  // ✅❌ حالات
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.cardLight,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryLight,
    ),

    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: AppColors.primary, size: 22),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.cardDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: AppColors.primary, size: 22),
  );
}
