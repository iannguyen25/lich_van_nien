import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setupNotifications() async {
    // Request permission to receive notifications
    await _requestPermission();

    // Register to receive the notification token
    String? token = await _firebaseMessaging.getToken();
    print("Firebase Messaging Token: $token");

    // Handle notifications when received
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the received message
      print('Received a message: ${message.notification?.title}, ${message.notification?.body}');
    });
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User declined permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    }
  }
}
