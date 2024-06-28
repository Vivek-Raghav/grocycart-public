import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmtoken = await _firebaseMessaging.getToken();
    print('Token => $fcmtoken');
    FirebaseMessaging.onBackgroundMessage(
        (message) => handleBackGroundMessage(message));

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {}
    });
  }
}

Future<void> handleBackGroundMessage(RemoteMessage remote) async {
  print('Remote Message Title => ${remote.notification!.title}');
  print('Remote Message body => ${remote.notification!.body}');
  print('Remote Message data => ${remote..data}');
}
