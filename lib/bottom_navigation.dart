import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  static const Color primaryColor = Color(0xFFCC007A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        height: 72,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.30 : 0.08),
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildItem(
                context: context,
                index: 1,
                icon: Icons.shopping_bag_outlined,
                activeIcon: Icons.shopping_bag_rounded,
                label: 'My_Orders'.tr(),
              ),
            ),

            Expanded(
              child: _buildItemWithCustomIcon(
                context: context,
                index: 2,
                iconPath: 'assets/icon/icons8-transactions-64.png',
                label: 'Transactions'.tr(),
              ),
            ),

            Expanded(child: _buildHomeItem(context)),

            Expanded(
              child: _buildItem(
                context: context,
                index: 4,
                icon: Icons.location_on_outlined,
                activeIcon: Icons.location_on,
                label: 'our_branches'.tr(),
              ),
            ),

            Expanded(
              child: _buildItem(
                context: context,
                index: 3,
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: 'settings'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeItem(BuildContext context) {
    final bool selected = currentIndex == 0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        onItemSelected(0);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              width: selected ? 52 : 44,
              height: selected ? 52 : 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? primaryColor : theme.cardColor,
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.35),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.20 : 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                border: Border.all(
                  color: selected
                      ? primaryColor
                      : (isDark
                            ? Colors.white.withOpacity(0.12)
                            : Colors.grey.shade300),
                  width: selected ? 2 : 1,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool selected = currentIndex == index;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color unselectedColor = isDark
        ? Colors.white70
        : Colors.grey.shade600;

    final Color unselectedIconColor = isDark
        ? Colors.white60
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: () {
        onItemSelected(index);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 22,
              color: selected ? primaryColor : unselectedIconColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? primaryColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWithCustomIcon({
    required BuildContext context,
    required int index,
    required String iconPath,
    required String label,
  }) {
    final bool selected = currentIndex == index;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color unselectedColor = isDark
        ? Colors.white70
        : Colors.grey.shade600;

    final Color unselectedIconColor = isDark
        ? Colors.white60
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: () {
        onItemSelected(index);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: selected ? primaryColor : unselectedIconColor,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? primaryColor : unselectedColor,
              ),
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            if (selected)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: const EdgeInsets.only(top: 2),
                height: 3,
                width: 12,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            else
              const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
