import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../fcm_service.dart';
import 'NotificationFilter.dart';
import 'notification_dialog.dart';
import 'notification_model.dart';
import 'notifications_repo.dart';

class NotificationsController extends ChangeNotifier {
  final NotificationsRepo _repo = NotificationsRepo();
  StreamSubscription<RemoteMessage>? _fcmSub;

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  final List<AppNotification> _localFcmNotifications = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  NotificationFilter _filter = NotificationFilter.unread;
  NotificationFilter get filter => _filter;

  int _page = 0;
  bool _hasMore = false;
  bool get hasMore => _hasMore;

  static const int _pageSize = 20;

  NotificationsController() {
    _listenToFcm();
  }

  void _listenToFcm() {
    _fcmSub = FcmService.instance.onMessage.listen((message) {
      final notif = _fromRemoteMessage(message);
      _localFcmNotifications.insert(0, notif);

      if (_filter == NotificationFilter.unread) {
        _notifications.insert(0, notif);
      }
      notifyListeners();
    });
  }

  AppNotification _fromRemoteMessage(RemoteMessage message) {
    final data = message.data;
    final n = message.notification;

    DateTime time;
    final sentTime = message.sentTime;

    if (sentTime != null && sentTime.year >= 2020) {
      time = sentTime;
    } else {
      time = DateTime.now();
    }

    return AppNotification(
      id:
          message.messageId ??
          data['NotificationId']?.toString() ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      titleEn: data['titleEn'] ?? n?.title,
      titleAr: data['titleAr'] ?? n?.title,
      bodyEn: data['bodyEn'] ?? n?.body,
      bodyAr: data['bodyAr'] ?? n?.body,
      time: time,
      isRead: false,
      data: Map<String, dynamic>.from(data),
    );
  }

  Future<void> loadNotifications() async {
    _isLoading = true;
    _error = null;
    _page = 0;
    _notifications = [];
    notifyListeners();

    try {
      final result = await _repo.fetchNotifications(
        page: _page,
        read: _filter == NotificationFilter.read,
        pageSize: _pageSize,
      );

      if (_filter == NotificationFilter.unread) {
        final unreadFcm = _localFcmNotifications
            .where((n) => !n.isRead)
            .toList();
        _notifications = _removeDuplicates([...unreadFcm, ...result]);
      } else {
        final readFcm = _localFcmNotifications.where((n) => n.isRead).toList();
        _notifications = _removeDuplicates([...readFcm, ...result]);
      }

      _hasMore = result.length >= _pageSize;
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ loadNotifications error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<AppNotification> _removeDuplicates(List<AppNotification> list) {
    final seen = <String>{};
    return list.where((n) => seen.add(n.id)).toList();
  }

  Future<void> refresh() async {
    _page = 0;
    _hasMore = false;
    notifyListeners();
    await loadNotifications();
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _page++;
      final result = await _repo.fetchNotifications(
        page: _page,
        read: _filter == NotificationFilter.read,
        pageSize: _pageSize,
      );

      _notifications.addAll(result);
      _hasMore = result.length >= _pageSize;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(NotificationFilter value) {
    if (value == _filter) return;
    _filter = value;
    notifyListeners();
    loadNotifications();
  }

  Future<void> onNotificationPressed(
    AppNotification notification,
    BuildContext context,
  ) async {
    final wasUnread = !notification.isRead;

    debugPrint('═══════════════════════════════════════');
    debugPrint('👆 User pressed notification: ${notification.id}');
    debugPrint('   hasLink: ${notification.hasLink}');
    debugPrint('   link: ${notification.link}');
    debugPrint('   data: ${notification.data}');
    debugPrint('═══════════════════════════════════════');

    if (context.mounted) {
      await showNotificationDetailsDialog(context, notification);
    }

    if (wasUnread) {
      await markAsRead(notification);
    }
  }

  Future<void> markAsRead(AppNotification notification) async {
    if (notification.isRead) return;

    final fcmIndex = _localFcmNotifications.indexWhere(
      (n) => n.id == notification.id,
    );
    if (fcmIndex != -1) {
      _localFcmNotifications[fcmIndex] = _localFcmNotifications[fcmIndex]
          .copyWith(isRead: true);
    }

    final index = _notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1) {
      if (_filter == NotificationFilter.unread) {
        _notifications.removeAt(index);
      } else {
        _notifications[index] = notification.copyWith(isRead: true);
      }
      notifyListeners();
    }

    final success = await _repo.readNotification(notification.id);

    if (!success) {
      debugPrint('⚠️ readNotification failed — reloading');
      await loadNotifications();
    }
  }

  @override
  void dispose() {
    _fcmSub?.cancel();
    super.dispose();
  }
}
