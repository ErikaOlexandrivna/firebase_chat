import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification()  async {
    await _firebaseMessaging.requestPermission();
    final String? tokenFirebase = await _firebaseMessaging.getToken();

    print('Token: $tokenFirebase');

  }


  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

  }


}