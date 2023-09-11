import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shali_fe/notification_service.dart';

void requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message.notification != null) {
    NotificationService.showLocalNotification(
        id: 0,
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: message.data.toString());
  }

  print("Handling a background message: ${message.messageId}");
}

void handleNotifications() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print(message.data);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      NotificationService.showLocalNotification(
          id: 0,
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data.toString());
      print(
          'Message also contained a notification: ${message.notification?.title}');
      print(message.notification?.body);
    }
  });
}

Future<void> handleDeviceToken() async {
  String? fcmToken;
  if (kIsWeb) {
    fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BP6VTlK1kn7mJhRfrrhRLWxw2WcRXXFc7UP2MQ2HD7qiia6TgG9nsLrRRGO4WfEPQMeodWb6t98u8EfJyCi1rlc");
  } else {
    fcmToken = await FirebaseMessaging.instance.getToken();
  }
  print(fcmToken);

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.
    print(fcmToken);
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
}
