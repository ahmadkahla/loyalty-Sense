import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'ProfileScreen.dart';
import 'notification/notification_bell.dart';
import 'notification/screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String customerNo;
  final String phoneNumber;

  final String? screenTitle;
  final IconData? screenIcon;
  final VoidCallback? onSettingsClosed;

  const CustomAppBar({
    super.key,
    required this.userName,
    required this.customerNo,
    required this.phoneNumber,
    this.screenTitle,
    this.screenIcon,
    this.onSettingsClosed,
  });

  static const Color primaryColor = Color(0xFFCC007A);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  String get _greeting => 'Welcome_Back'.tr();

  Future<void> _openProfile(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          userName: userName,
          customerNo: customerNo,
          phoneNumber: phoneNumber,
        ),
      ),
    );

    if (onSettingsClosed != null) {
      onSettingsClosed!();
    }
  }

  void _openNotifications(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
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

  Widget _buildHomeBar(BuildContext context, bool isDark) {
    return Row(
      children: [
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

        NotificationBell(onTap: () => _openNotifications(context)),
      ],
    );
  }

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
              NotificationBell(onTap: () => _openNotifications(context)),
            ],
          ),
        ),
      ],
    );
  }
}
