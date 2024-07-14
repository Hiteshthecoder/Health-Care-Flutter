import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/modules/HealthTips/views/HealthTipsPage.dart';
import 'package:get/get.dart';

import '../../../shared/controllers/AppController.dart';
import '../../Doctor/views/DoctorPage.dart';
import '../../Home/views/HomePage.dart';
import '../../Menu/views/MenuPage.dart';

class DashboardController extends AppController {
  static DashboardController get instance {
    if (!Get.isRegistered<DashboardController>()) Get.put(DashboardController());
    return Get.find<DashboardController>();
  }

  var _tasks = RxList<Map<String, dynamic>>([]);
  var _tabIndex = RxInt(0);

  /// Getters
  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;

  /// Variables
  TextEditingController taskInput = TextEditingController();
  List<Widget> pageList = [
    HomePage(),
    DoctorPage(),
    HealthTipsPage(),
    MenuPage(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void onTabChanged(int index) {
    _tabIndex(index);
  }
}
