import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          importance: Importance.max),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
}
