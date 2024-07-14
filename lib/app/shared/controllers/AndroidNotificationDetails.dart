
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


class AndroidNotificationDetails extends GetxController {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      // channelId: String,   //Required for Android 8.0 or after
      // channelName: String, //Required for Android 8.0 or after
      // channelDescription: String, //Required for Android 8.0 or after
      // importance: Importance,
      // priority: Priority
  );
  // NotificationDetails platformChannelSpecifics =
  // NotificationDetails(android: androidPlatformChannelSpecifics);
}
