// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'ThemeProvider.dart';
// import 'splach_screen.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await EasyLocalization.ensureInitialized();
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('ar')],
//       path: 'assets/localization',
//       fallbackLocale: const Locale('en'),
//       startLocale: const Locale('en'),
//       saveLocale: true,
//       child: const LoyaltyApp(),
//     ),
//   );
// }
//
// class LoyaltyApp extends StatelessWidget {
//   const LoyaltyApp({super.key});
//
//   static const Color primaryColor = Color(0xFFA5005A);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: Consumer<ThemeProvider>(
//         builder: (context, themeProvider, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//
//             title: 'SENSE',
//
//             // ============================================================
//             // LOCALIZATION
//             // ============================================================
//             localizationsDelegates: context.localizationDelegates,
//
//             supportedLocales: context.supportedLocales,
//
//             locale: context.locale,
//
//             // ============================================================
//             // THEME MODE
//             // ============================================================
//             themeMode: themeProvider.themeMode,
//
//             // ============================================================
//             // LIGHT THEME
//             // ============================================================
//             theme: ThemeData(
//               useMaterial3: true,
//
//               brightness: Brightness.light,
//
//               colorScheme: ColorScheme.fromSeed(
//                 seedColor: primaryColor,
//                 brightness: Brightness.light,
//               ),
//
//               // خلفية جميع الـ Scaffolds
//               scaffoldBackgroundColor: const Color(0xFFF8F8F8),
//
//               // لون الـ Cards
//               cardColor: Colors.white,
//
//               // ========================================================
//               // APP BAR
//               // ========================================================
//               appBarTheme: const AppBarTheme(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 surfaceTintColor: Colors.transparent,
//                 foregroundColor: Colors.black,
//               ),
//
//               // ========================================================
//               // DIVIDERS / BORDERS
//               // ========================================================
//               dividerColor: const Color(0xFFE0E0E0),
//
//               // ========================================================
//               // ICONS
//               // ========================================================
//               iconTheme: const IconThemeData(color: Colors.black87),
//
//               // ========================================================
//               // TEXT
//               // ========================================================
//               textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.black87),
//                 bodyMedium: TextStyle(color: Colors.black87),
//                 bodySmall: TextStyle(color: Colors.black54),
//                 titleLarge: TextStyle(color: Colors.black87),
//                 titleMedium: TextStyle(color: Colors.black87),
//                 titleSmall: TextStyle(color: Colors.black87),
//               ),
//
//               // ========================================================
//               // INPUT FIELDS
//               // ========================================================
//               inputDecorationTheme: InputDecorationTheme(
//                 filled: true,
//
//                 fillColor: Colors.white,
//
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
//                 ),
//
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
//                 ),
//
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: primaryColor, width: 1.5),
//                 ),
//               ),
//
//               // ========================================================
//               // BUTTONS
//               // ========================================================
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               // ========================================================
//               // SWITCH
//               // ========================================================
//               switchTheme: SwitchThemeData(
//                 thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
//                   if (states.contains(WidgetState.selected)) {
//                     return primaryColor;
//                   }
//
//                   return Colors.grey;
//                 }),
//               ),
//
//               // ========================================================
//               // DIALOG
//               // ========================================================
//               dialogTheme: DialogThemeData(
//                 backgroundColor: Colors.white,
//                 surfaceTintColor: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//
//               // ========================================================
//               // BOTTOM SHEET
//               // ========================================================
//               bottomSheetTheme: const BottomSheetThemeData(
//                 backgroundColor: Colors.white,
//                 surfaceTintColor: Colors.transparent,
//               ),
//
//               // ========================================================
//               // SNACKBAR
//               // ========================================================
//               snackBarTheme: SnackBarThemeData(
//                 backgroundColor: Colors.black87,
//                 contentTextStyle: const TextStyle(color: Colors.white),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             ),
//
//             // ============================================================
//             // DARK THEME
//             // ============================================================
//             darkTheme: ThemeData(
//               useMaterial3: true,
//
//               brightness: Brightness.dark,
//
//               colorScheme: ColorScheme.fromSeed(
//                 seedColor: primaryColor,
//                 brightness: Brightness.dark,
//               ),
//
//               // خلفية جميع الـ Scaffolds
//               scaffoldBackgroundColor: const Color(0xFF121212),
//
//               // لون الـ Cards
//               cardColor: const Color(0xFF1E1E1E),
//
//               // ========================================================
//               // APP BAR
//               // ========================================================
//               appBarTheme: const AppBarTheme(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 surfaceTintColor: Colors.transparent,
//                 foregroundColor: Colors.white,
//               ),
//
//               // ========================================================
//               // DIVIDERS / BORDERS
//               // ========================================================
//               dividerColor: const Color(0xFF383838),
//
//               // ========================================================
//               // ICONS
//               // ========================================================
//               iconTheme: const IconThemeData(color: Colors.white70),
//
//               // ========================================================
//               // TEXT
//               // ========================================================
//               textTheme: const TextTheme(
//                 bodyLarge: TextStyle(color: Colors.white),
//                 bodyMedium: TextStyle(color: Colors.white),
//                 bodySmall: TextStyle(color: Colors.white60),
//                 titleLarge: TextStyle(color: Colors.white),
//                 titleMedium: TextStyle(color: Colors.white),
//                 titleSmall: TextStyle(color: Colors.white),
//               ),
//
//               // ========================================================
//               // INPUT FIELDS
//               // ========================================================
//               inputDecorationTheme: InputDecorationTheme(
//                 filled: true,
//
//                 fillColor: const Color(0xFF1E1E1E),
//
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFF383838)),
//                 ),
//
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFF383838)),
//                 ),
//
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: primaryColor, width: 1.5),
//                 ),
//
//                 hintStyle: const TextStyle(color: Colors.white54),
//               ),
//
//               // ========================================================
//               // BUTTONS
//               // ========================================================
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               // ========================================================
//               // SWITCH
//               // ========================================================
//               switchTheme: SwitchThemeData(
//                 thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
//                   if (states.contains(WidgetState.selected)) {
//                     return primaryColor;
//                   }
//
//                   return Colors.grey;
//                 }),
//               ),
//
//               // ========================================================
//               // DIALOG
//               // ========================================================
//               dialogTheme: DialogThemeData(
//                 backgroundColor: const Color(0xFF1E1E1E),
//                 surfaceTintColor: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//
//               // ========================================================
//               // BOTTOM SHEET
//               // ========================================================
//               bottomSheetTheme: const BottomSheetThemeData(
//                 backgroundColor: Color(0xFF1E1E1E),
//                 surfaceTintColor: Colors.transparent,
//               ),
//
//               // ========================================================
//               // SNACKBAR
//               // ========================================================
//               snackBarTheme: SnackBarThemeData(
//                 backgroundColor: const Color(0xFF2D2D2D),
//                 contentTextStyle: const TextStyle(color: Colors.white),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             ),
//
//             // ============================================================
//             // HOME
//             // ============================================================
//             home: const SplashScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider.dart';
import 'splach_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/localization',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      child: const LoyaltyApp(),
    ),
  );
}

class LoyaltyApp extends StatelessWidget {
  const LoyaltyApp({super.key});

  // ============================================================
  // 🎨 اللون الأساسي — من CMYK: 0/100/40/0
  // ============================================================
  // static const Color primaryColor = Color(0xFFFF0099);
  static const Color primaryColor = Color(0xFFCC007A);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'SENSE',

            // ============================================================
            // LOCALIZATION
            // ============================================================
            localizationsDelegates: context.localizationDelegates,

            supportedLocales: context.supportedLocales,

            locale: context.locale,

            // ============================================================
            // THEME MODE
            // ============================================================
            themeMode: themeProvider.themeMode,

            // ============================================================
            // LIGHT THEME
            // ============================================================
            theme: ThemeData(
              useMaterial3: true,

              brightness: Brightness.light,

              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.light,
              ),

              // خلفية جميع الـ Scaffolds
              scaffoldBackgroundColor: const Color(0xFFF8F8F8),

              // لون الـ Cards
              cardColor: Colors.white,

              // ========================================================
              // APP BAR
              // ========================================================
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.black,
              ),

              // ========================================================
              // DIVIDERS / BORDERS
              // ========================================================
              dividerColor: const Color(0xFFE0E0E0),

              // ========================================================
              // ICONS
              // ========================================================
              iconTheme: const IconThemeData(color: Colors.black87),

              // ========================================================
              // TEXT
              // ========================================================
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black87),
                bodyMedium: TextStyle(color: Colors.black87),
                bodySmall: TextStyle(color: Colors.black54),
                titleLarge: TextStyle(color: Colors.black87),
                titleMedium: TextStyle(color: Colors.black87),
                titleSmall: TextStyle(color: Colors.black87),
              ),

              // ========================================================
              // INPUT FIELDS
              // ========================================================
              inputDecorationTheme: InputDecorationTheme(
                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryColor, width: 1.5),
                ),
              ),

              // ========================================================
              // BUTTONS
              // ========================================================
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // ========================================================
              // SWITCH
              // ========================================================
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return primaryColor;
                  }

                  return Colors.grey;
                }),
              ),

              // ========================================================
              // DIALOG
              // ========================================================
              dialogTheme: DialogThemeData(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              // ========================================================
              // BOTTOM SHEET
              // ========================================================
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
              ),

              // ========================================================
              // SNACKBAR
              // ========================================================
              snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.black87,
                contentTextStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            ),

            // ============================================================
            // DARK THEME
            // ============================================================
            darkTheme: ThemeData(
              useMaterial3: true,

              brightness: Brightness.dark,

              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.dark,
              ),

              // خلفية جميع الـ Scaffolds
              scaffoldBackgroundColor: const Color(0xFF121212),

              // لون الـ Cards
              cardColor: const Color(0xFF1E1E1E),

              // ========================================================
              // APP BAR
              // ========================================================
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),

              // ========================================================
              // DIVIDERS / BORDERS
              // ========================================================
              dividerColor: const Color(0xFF383838),

              // ========================================================
              // ICONS
              // ========================================================
              iconTheme: const IconThemeData(color: Colors.white70),

              // ========================================================
              // TEXT
              // ========================================================
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white60),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),

              // ========================================================
              // INPUT FIELDS
              // ========================================================
              inputDecorationTheme: InputDecorationTheme(
                filled: true,

                fillColor: const Color(0xFF1E1E1E),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF383838)),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF383838)),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryColor, width: 1.5),
                ),

                hintStyle: const TextStyle(color: Colors.white54),
              ),

              // ========================================================
              // BUTTONS
              // ========================================================
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // ========================================================
              // SWITCH
              // ========================================================
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return primaryColor;
                  }

                  return Colors.grey;
                }),
              ),

              // ========================================================
              // DIALOG
              // ========================================================
              dialogTheme: DialogThemeData(
                backgroundColor: const Color(0xFF1E1E1E),
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              // ========================================================
              // BOTTOM SHEET
              // ========================================================
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color(0xFF1E1E1E),
                surfaceTintColor: Colors.transparent,
              ),

              // ========================================================
              // SNACKBAR
              // ========================================================
              snackBarTheme: SnackBarThemeData(
                backgroundColor: const Color(0xFF2D2D2D),
                contentTextStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            ),

            // ============================================================
            // HOME
            // ============================================================
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
