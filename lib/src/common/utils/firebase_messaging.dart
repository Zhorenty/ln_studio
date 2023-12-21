import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    // Подписка на уведомления в фоновом режиме
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      // Обработка уведомления, например, показать уведомление внутри приложения
    });

    // Подписка на уведомления при клике пользователя
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      // Обработка уведомления, если приложение открыто
    });

    // Получение токена устройства
    String? token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
  }
}

final FirebaseMessagingService firebaseMessagingService =
    FirebaseMessagingService();
