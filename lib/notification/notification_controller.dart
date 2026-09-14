import 'package:flutter/material.dart';

import 'notification_model.dart';
import 'notifications_repo.dart';

enum NotificationFilter { unread, read }

class NotificationsController extends ChangeNotifier {
  final NotificationsRepo _repo = NotificationsRepo();

  // ============================================================
  // STATE
  // ============================================================
  final List<AppNotification> branches = [];
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

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

  // ============================================================
  // LOAD
  // ============================================================
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

      _notifications = result;
      _hasMore = result.length >= _pageSize;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // ============================================================
  // REFRESH
  // ============================================================
  Future<void> refresh() async {
    _page = 0;
    _hasMore = false;
    notifyListeners();
    await loadNotifications();
  }

  // ============================================================
  // LOAD MORE
  // ============================================================
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

  // ============================================================
  // FILTER
  // ============================================================
  void setFilter(NotificationFilter value) {
    if (value == _filter) return;
    _filter = value;
    notifyListeners();
    loadNotifications();
  }

  // ============================================================
  // MARK AS READ
  // ============================================================
  Future<void> markAsRead(AppNotification notification) async {
    if (notification.isRead) return;

    // تحديث فوري في الواجهة
    final index = _notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1) {
      _notifications[index] = notification.copyWith(isRead: true);
      notifyListeners();
    }

    // إرسال للسيرفر
    final success = await _repo.readNotification(notification.id);

    // إذا فشل، نرجع الحالة
    if (!success && index != -1) {
      _notifications[index] = notification.copyWith(isRead: false);
      notifyListeners();
    }
  }
}
