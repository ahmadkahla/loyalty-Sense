import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final firebaseMessaging = FirebaseMessaging.instance;

  initNotification() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print(fcmToken);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundFcm);
  }
}

Future<void> handleBackgroundFcm(RemoteMessage message) async {
  print("title:${message.notification?.title}");
  print("body : ${message.notification?.body}");
}
