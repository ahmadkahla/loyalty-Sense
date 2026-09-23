import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'notification_model.dart';

class NotificationCell extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationCell({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final languageCode = context.locale.languageCode;

    final title = notification.getLocalizedTitle(languageCode);
    final body = notification.getLocalizedBody(languageCode);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: notification.isRead
            ? Colors.transparent
            : theme.colorScheme.primary.withValues(alpha: 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? body ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),

                      if (notification.hasLink) ...[
                        const SizedBox(width: 6),
                        Icon(
                          Icons.link_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                      ],

                      if (!notification.isRead) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ],
                  ),

                  if (body != null && title != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        body,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: notification.isRead
                              ? FontWeight.normal
                              : FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      timeago.format(notification.time, locale: languageCode),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
