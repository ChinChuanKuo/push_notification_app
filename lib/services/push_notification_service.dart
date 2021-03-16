import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> initialize() async {
    //if os system is android
    /*final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);*/
    settingNotification();
    firebaseOnMessage();
    firebaseOnMessageOpenedApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    /*messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);*/
    /*_fcm.configure(
      onMessage: (Map<String, dynamic> message) async =>
          print("onMessage： $message"),
      onLaunch: (Map<String, dynamic> message) async =>
          print("onLaunch： $message"),
      onResume: (Map<String, dynamic> message) async =>
          print("onResume： $message"),
    );
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
    }*/
  }

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  Future<void> settingNotification() async {
    messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
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

  void firebaseOnMessage() => FirebaseMessaging.onMessage.listen((event) {
        RemoteNotification notification = event.notification;
        AndroidNotification android = event.notification?.android;
        print('Android Notification:');
        if (notification != null && android != null) {
          final title = event.notification.title;
          final body = event.notification.body;
          print("title：$title body：$body");
        }
      });

  void firebaseOnMessageOpenedApp() =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        final title = event.notification.title;
        final body = event.notification.body;
        print("title：$title body：$body");
      });

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    final title = message.notification.title;
    final body = message.notification.body;
    print("title：$title body：$body");
  }

  void register() =>
      messaging.getToken().then((token) => print("token：$token"));
}
