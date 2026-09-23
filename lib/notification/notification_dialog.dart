import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'notification_model.dart';

Future<void> showNotificationDetailsDialog(
  BuildContext context,
  AppNotification notification,
) async {
  final theme = Theme.of(context);
  final languageCode = context.locale.languageCode;

  final title = notification.getLocalizedTitle(languageCode) ?? '';
  final body = notification.getLocalizedBody(languageCode) ?? '';
  final hasLink = notification.hasLink;
  final link = notification.link;

  debugPrint('═══════════════════════════════════════');
  debugPrint('📋 Dialog: hasLink=$hasLink');
  debugPrint('📋 Dialog: link=$link');
  debugPrint('📋 Dialog: data=${notification.data}');
  debugPrint('═══════════════════════════════════════');

  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              hasLink ? Icons.link_rounded : Icons.notifications_rounded,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(body, style: const TextStyle(fontSize: 14, height: 1.5)),
              const SizedBox(height: 12),
              Text(
                timeago.format(notification.time, locale: languageCode),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        actions: [
          if (hasLink && link != null)
            ElevatedButton.icon(
              onPressed: () async {
                await _openLink(dialogContext, link);
              },
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: Text('open_link'.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),

          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('close'.tr()),
          ),
        ],
      );
    },
  );
}

Future<void> _openLink(BuildContext context, String link) async {
  debugPrint('🔗 فتح الرابط: $link');
  try {
    final uri = Uri.tryParse(link);
    if (uri == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('رابط غير صالح')));
      }
      return;
    }

    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('تعذر فتح الرابط: $link')));
      }
    }
  } catch (e) {
    debugPrint('❌ فتح الرابط فشل: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ: $e')));
    }
  }
}
