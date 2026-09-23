import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notification_controller.dart';

class NotificationBell extends StatelessWidget {
  final VoidCallback? onTap;

  const NotificationBell({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsController>(
      builder: (context, controller, _) {
        final unreadCount = controller.notifications
            .where((n) => !n.isRead)
            .length;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: onTap,
            ),
            if (unreadCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : '$unreadCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
