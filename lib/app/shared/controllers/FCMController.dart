import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../helpers/Global.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class FCMController extends GetxController {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FCMController instance = Get.find<FCMController>();
  var _token = ''.obs;
  var fcmNotificationData = RemoteMessage().obs;

  String get deviceToken => _token.value;

  @override
  void onInit() {
    super.onInit();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //onSelectNotification: (payload) => _handleNotificationClick(payload)
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /// Update reactive variable data
      fcmNotificationData(message);

      var data = message.data;
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            iOS: DarwinNotificationDetails(),
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
    getToken();
  }

  void _handleNotificationClick(String? payload) async {
    /// TODO: add functionality here
  }

  getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    _token(token);
  }
}
