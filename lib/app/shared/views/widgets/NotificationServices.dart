import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future secheduleNotification(String title, String message,) async {
  //
  //   AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
  //     'channelId',
  //     'High Importance Notifications',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     title,
  //     message,
  //     RepeatInterval.daily,
  //     notificationDetails,
  //   );
  // }

  void scheduledNotification(int hour, int minutes, task, description) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      UniqueKey().toString().hashCode,
      task,
      "$description",
      _nextInstanceOfTenAM(hour, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'High Importance Notifications',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate.subtract(Duration(hours: 5, minutes: 30));
  }

  void requestIOSPermissions() {
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}
