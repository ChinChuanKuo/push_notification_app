import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void initialize() {
    _fcm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    _fcm.requestPermission();
    firebaseOnMessage();
    firebaseOnMessageOpenedApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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

  void firebaseOnMessage() => FirebaseMessaging.onMessage.listen((event) {
        if (event != null) {
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

  void register() => _fcm.getToken().then((token) => print("token：$token"));
}
