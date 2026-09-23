import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyalty/splach_screen.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'ThemeProvider.dart';
import 'fcm_service.dart';
import 'notification/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  FcmService.instance.initNotification().catchError((e) {
    debugPrint('❌ FCM init error: $e');
  });

  await GetStorage.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/localization',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: false,
      child: const LoyaltyApp(),
    ),
  );
}

class LoyaltyApp extends StatelessWidget {
  const LoyaltyApp({super.key});

  static const Color primaryColor = Color(0xFFCC007A);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<NotificationsController>(
          create: (_) => NotificationsController()..loadNotifications(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SENSE',

            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            themeMode: themeProvider.themeMode,

            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,

              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.light,
              ),

              scaffoldBackgroundColor: const Color(0xFFF8F8F8),
              cardColor: Colors.white,

              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.black,
              ),

              dividerColor: const Color(0xFFE0E0E0),

              iconTheme: const IconThemeData(color: Colors.black87),

              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black87),
                bodyMedium: TextStyle(color: Colors.black87),
                bodySmall: TextStyle(color: Colors.black54),
                titleLarge: TextStyle(color: Colors.black87),
                titleMedium: TextStyle(color: Colors.black87),
                titleSmall: TextStyle(color: Colors.black87),
              ),

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

              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return primaryColor;
                  }

                  return Colors.grey;
                }),
              ),

              dialogTheme: DialogThemeData(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
              ),

              snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.black87,
                contentTextStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            ),

            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,

              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.dark,
              ),

              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1E1E1E),

              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),

              dividerColor: const Color(0xFF383838),

              iconTheme: const IconThemeData(color: Colors.white70),

              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white60),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),

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

              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return primaryColor;
                  }

                  return Colors.grey;
                }),
              ),

              dialogTheme: DialogThemeData(
                backgroundColor: const Color(0xFF1E1E1E),
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color(0xFF1E1E1E),
                surfaceTintColor: Colors.transparent,
              ),

              snackBarTheme: SnackBarThemeData(
                backgroundColor: const Color(0xFF2D2D2D),
                contentTextStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            ),

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
