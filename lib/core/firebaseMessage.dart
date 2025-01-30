import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User  granted permission');
    } else {
      print('User  declined or has not accepted permission');
    }
  }

  Future<void> initialize() async {
    await requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Received a message while in the foreground: ${message.notification?.title}');
      // Show a dialog or notification to the user
    });
  }

  Future<void> sendNotification(String title, String body) async {
    // Logic to send a notification to the user
    // This could involve calling a backend service that sends the notification
    print('Sending notification: $title - $body');
  }
}
