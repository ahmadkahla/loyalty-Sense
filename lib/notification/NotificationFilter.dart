import 'package:easy_localization/easy_localization.dart';

enum NotificationFilter {
  unread,
  read;

  const NotificationFilter();

  String get label {
    return switch (this) {
      NotificationFilter.unread => 'labels.new'.tr(),
      NotificationFilter.read => 'labels.old'.tr(),
    }.tr();
  }
}
