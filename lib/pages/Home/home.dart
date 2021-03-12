import 'package:flutter/material.dart';
import 'package:push_notification_app/services/services.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _message = '';
  PushNotificationService _pushNotificationService = PushNotificationService();

  @override
  void initState() {
    _pushNotificationService.initialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Message: $_message"),
              OutlineButton(
                child: Text("Register My Device"),
                onPressed: () => _pushNotificationService.register(),
              ),
              // Text("Message: $message")
            ]),
      ),
    );
  }
}
