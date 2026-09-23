import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundFcm(RemoteMessage message) async {
  debugPrint('📩 [BG] title: ${message.notification?.title}');
  debugPrint('📩 [BG] body : ${message.notification?.body}');
  debugPrint('📩 [BG] data : ${message.data}');
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final StreamController<RemoteMessage> _onMessageStream =
      StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get onMessage => _onMessageStream.stream;

  Future<void> initNotification() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('🔔 Permission: ${settings.authorizationStatus}');

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('📩 [FG] title: ${message.notification?.title}');
      debugPrint('📩 [FG] body : ${message.notification?.body}');
      debugPrint('📩 [FG] data : ${message.data}');
      _onMessageStream.add(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('👆 Opened from notif: ${message.messageId}');
      _onMessageStream.add(message);
    });

    final initial = await _fcm.getInitialMessage();
    if (initial != null) {
      debugPrint('🚀 Initial message: ${initial.messageId}');
      _onMessageStream.add(initial);
    }

    try {
      final token = await _fcm.getToken();
      debugPrint('🔥 FCM Token: $token');
    } catch (e) {
      debugPrint('❌ getToken failed: $e');
    }

    _fcm.onTokenRefresh.listen((newToken) {
      debugPrint('🔥 Token refreshed: $newToken');
    });
  }

  void dispose() {
    _onMessageStream.close();
  }
}
