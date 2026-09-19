// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;
//   static const String _themeKey = 'theme_mode';
//
//   ThemeProvider() {
//     _loadTheme();
//   }
//
//   ThemeMode get themeMode => _themeMode;
//
//   bool get isDarkMode => _themeMode == ThemeMode.dark;
//
//   bool get isLightMode => _themeMode == ThemeMode.light;
//
//   bool get isSystemMode => _themeMode == ThemeMode.system;
//
//   Future<void> setThemeMode(ThemeMode mode) async {
//     if (_themeMode == mode) return;
//
//     _themeMode = mode;
//     notifyListeners();
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_themeKey, mode.name);
//   }
//
//   Future<void> toggleTheme() async {
//     final newMode = _themeMode == ThemeMode.dark
//         ? ThemeMode.light
//         : ThemeMode.dark;
//     await setThemeMode(newMode);
//   }
//
//   Future<void> setLightMode() async {
//     await setThemeMode(ThemeMode.light);
//   }
//
//   Future<void> setDarkMode() async {
//     await setThemeMode(ThemeMode.dark);
//   }
//
//   Future<void> setSystemMode() async {
//     await setThemeMode(ThemeMode.system);
//   }
//
//   Future<void> _loadTheme() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final themeName = prefs.getString(_themeKey);
//
//       if (themeName != null) {
//         _themeMode = ThemeMode.values.firstWhere(
//           (e) => e.name == themeName,
//           orElse: () => ThemeMode.system,
//         );
//       }
//       notifyListeners();
//     } catch (e) {
//       _themeMode = ThemeMode.system;
//       notifyListeners();
//     }
//   }
//
//   String getCurrentThemeName() {
//     switch (_themeMode) {
//       case ThemeMode.light:
//         return 'Light';
//       case ThemeMode.dark:
//         return 'Dark';
//       case ThemeMode.system:
//         return 'System';
//     }
//   }
//
//   bool get isCurrentlyLight {
//     return false;
//   }
//
//   Brightness getCurrentBrightness(BuildContext context) {
//     return Theme.of(context).brightness;
//   }
// }

// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  static const String _themeKey = 'theme_mode';

  // مهم: لا نستدعي SharedPreferences هنا
  ThemeProvider();

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  bool get isLightMode => _themeMode == ThemeMode.light;

  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// يتم استدعاؤها بعد بدء التطبيق، وليس داخل constructor
  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final themeName = prefs.getString(_themeKey);

      if (themeName != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (e) => e.name == themeName,
          orElse: () => ThemeMode.system,
        );
      }

      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
      notifyListeners();

      debugPrint('Failed to load theme: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_themeKey, mode.name);
    } catch (e) {
      debugPrint('Failed to save theme: $e');
    }
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await setThemeMode(newMode);
  }

  Future<void> setLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  Future<void> setDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  Future<void> setSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }

  String getCurrentThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';

      case ThemeMode.dark:
        return 'Dark';

      case ThemeMode.system:
        return 'System';
    }
  }

  bool get isCurrentlyLight {
    return _themeMode == ThemeMode.light;
  }

  Brightness getCurrentBrightness(BuildContext context) {
    return Theme.of(context).brightness;
  }
}
