// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  bool get isLightMode => _themeMode == ThemeMode.light;

  bool get isSystemMode => _themeMode == ThemeMode.system;

  // تغيير الثيم
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    // حفظ في التخزين
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  // تبديل بين النهاري والليلي
  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  // تعيين الوضع النهاري
  Future<void> setLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  // تعيين الوضع الليلي
  Future<void> setDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  // تعيين وضع النظام
  Future<void> setSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }

  // تحميل الثيم المحفوظ
  Future<void> _loadTheme() async {
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
      // في حالة حدوث خطأ، استخدم الوضع الافتراضي
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }

  // الحصول على اسم الوضع الحالي
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

  // التحقق مما إذا كان الوضع الحالي هو النهاري
  bool get isCurrentlyLight {
    // هذه الدالة تعتمد على سياق التطبيق، تستخدم في الـ UI
    // يجب استخدامها مع BuildContext
    return false; // سيتم تحديدها في الـ UI
  }

  // الحصول على Brightness الحالي (يستخدم في الـ UI)
  Brightness getCurrentBrightness(BuildContext context) {
    return Theme.of(context).brightness;
  }
}
