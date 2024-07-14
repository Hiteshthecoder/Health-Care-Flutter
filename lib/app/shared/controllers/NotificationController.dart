import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:get/get.dart';

import '../../helpers/Global.dart';
import '../views/widgets/NotificationServices.dart';

class NotificationController extends AppController {
  static NotificationController get instance {
    if (!Get.isRegistered<NotificationController>()) Get.put(NotificationController());

    return Get.find<NotificationController>();
  }

  final NotificationServices notificationServices = NotificationServices();

  @override
  void onInit() {
    super.onInit();
    notificationServices.initialiseNotifications();

    Future.delayed(
      Duration(seconds: 10),
      () => notificationServices.scheduledNotification(
          10, 00, 'Good morning ${auth.user.name}', auth.user.followup == 0 ? 'You have No followups today.' : 'You have ${auth.user.followup} followups today.'),
    );
  }
}
