import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../PrivacyPolicyScreen.dart';
import '../ProfileScreen.dart';
import '../Terms&conditions.dart';
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

            _sectionTitle('others'.tr()),

            const SizedBox(height: 6),

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

            _SettingTile(
              icon: Icons.privacy_tip_outlined,
              title: 'privacy_policy'.tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 6),

            _SettingTile(
              icon: Icons.description_outlined,
              title: 'terms_conditions'.tr(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TermsScreen()),
                );
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                'POWERED BY BONANZA SOFT ©',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white38
                      : Colors.grey.shade500,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }

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

  void _changeLanguage(
    BuildContext context,
    BuildContext dialogContext,
    String languageCode,
  ) {
    Navigator.of(dialogContext).pop();
    context.setLocale(Locale(languageCode));

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
}

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
              Icon(icon, color: primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
