// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FcmService {
//   final firebaseMessaging = FirebaseMessaging.instance;
//
//   initNotification() async {
//     await firebaseMessaging.requestPermission();
//     final fcmToken = await firebaseMessaging.getToken();
//     print(fcmToken);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
//   }
// }
//
// Future<void> handleBackgroundFcm(RemoteMessage message) async {
//   print("title:${message.notification?.title}");
//   print("body : ${message.notification?.body}");
// }

// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
//
// class FcmService {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initNotification() async {
//     try {
//       final settings = await firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         provisional: false,
//       );
//
//       debugPrint(
//         'Notification permission status: ${settings.authorizationStatus}',
//       );
//
//       if (Platform.isIOS) {
//         String? apnsToken;
//
//         for (int i = 0; i < 20; i++) {
//           try {
//             apnsToken = await firebaseMessaging.getAPNSToken();
//
//             if (apnsToken != null && apnsToken.isNotEmpty) {
//               break;
//             }
//           } catch (e) {
//             debugPrint('Waiting for APNs token: $e');
//           }
//
//           await Future.delayed(const Duration(seconds: 1));
//         }
//
//         debugPrint('APNS Token: $apnsToken');
//
//         if (apnsToken == null || apnsToken.isEmpty) {
//           debugPrint('APNs token is not available yet.');
//           _listenForTokenRefresh();
//           return;
//         }
//       }
//
//       final String? fcmToken = await firebaseMessaging.getToken();
//
//       debugPrint('FCM Token: $fcmToken');
//
//       _listenForTokenRefresh();
//
//       FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
//     } catch (e, stackTrace) {
//       debugPrint('FCM initialization error: $e');
//       debugPrint('Stack trace: $stackTrace');
//     }
//   }
//
//   void _listenForTokenRefresh() {
//     firebaseMessaging.onTokenRefresh.listen(
//       (String token) {
//         debugPrint('FCM Token refreshed: $token');
//       },
//       onError: (Object error) {
//         debugPrint('FCM token refresh error: $error');
//       },
//     );
//   }
// }
//
// @pragma('vm:entry-point')
// Future<void> handleBackgroundFcm(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp();
//
//     debugPrint('Background notification title: ${message.notification?.title}');
//
//     debugPrint('Background notification body: ${message.notification?.body}');
//
//     debugPrint('Background notification data: ${message.data}');
//   } catch (e) {
//     debugPrint('Background FCM error: $e');
//   }
// }

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    try {
      final settings = await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      debugPrint(
        'Notification permission status: ${settings.authorizationStatus}',
      );

      if (Platform.isIOS) {
        await firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        String? apnsToken;

        for (int i = 0; i < 20; i++) {
          try {
            apnsToken = await firebaseMessaging.getAPNSToken();

            if (apnsToken != null && apnsToken.isNotEmpty) {
              break;
            }
          } catch (e) {
            debugPrint('Waiting for APNs token: $e');
          }

          await Future.delayed(const Duration(seconds: 1));
        }

        debugPrint('APNS Token: $apnsToken');

        if (apnsToken == null || apnsToken.isEmpty) {
          debugPrint('APNs token is not available yet.');
          _listenForTokenRefresh();
          return;
        }
      }

      final String? fcmToken = await firebaseMessaging.getToken();

      debugPrint('FCM Token: $fcmToken');

      _listenForTokenRefresh();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint(
          'Foreground notification title: '
          '${message.notification?.title}',
        );

        debugPrint(
          'Foreground notification body: '
          '${message.notification?.body}',
        );

        debugPrint(
          'Foreground notification data: '
          '${message.data}',
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('Notification opened: ${message.data}');
      });

      final RemoteMessage? initialMessage = await firebaseMessaging
          .getInitialMessage();

      if (initialMessage != null) {
        debugPrint('App opened from notification: ${initialMessage.data}');
      }

      FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
    } catch (e, stackTrace) {
      debugPrint('FCM initialization error: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  void _listenForTokenRefresh() {
    firebaseMessaging.onTokenRefresh.listen(
      (String token) {
        debugPrint('FCM Token refreshed: $token');
      },
      onError: (Object error) {
        debugPrint('FCM token refresh error: $error');
      },
    );
  }
}

@pragma('vm:entry-point')
Future<void> handleBackgroundFcm(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();

    debugPrint(
      'Background notification title: '
      '${message.notification?.title}',
    );

    debugPrint(
      'Background notification body: '
      '${message.notification?.body}',
    );

    debugPrint(
      'Background notification data: '
      '${message.data}',
    );
  } catch (e) {
    debugPrint('Background FCM error: $e');
  }
}
