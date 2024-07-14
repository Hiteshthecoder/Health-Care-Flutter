import 'package:flutter_mvc/app/modules/Menu/controllers/MenuController.dart';
import 'package:flutter_mvc/app/modules/MyFamily/services/MyFamilyService.dart';
import 'package:flutter_mvc/app/modules/Subscribe/controllers/SubscribeController.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/MyFamilyMemberModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../../Dashboard/controllers/DashboardController.dart';

class MyFamilyController extends AppController {
  static MyFamilyController get instance => MyFamilyController();
  final MenueController menuController = Get.put(MenueController());
  final DashboardController dashboardController = DashboardController.instance;
  var _memberData = <MyFamilyMemberModel>[].obs;

  final SubscribeController subscribeController = Get.put(SubscribeController());

  List<MyFamilyMemberModel> get memberData => _memberData;

  final MyFamilyService _familyService = MyFamilyService.instance;

  @override
  void onInit() {
    super.onInit();
    getMemberData();
  }

  Future<void> getMemberData() async {
    try {
      setBusy(true);
      ApiResponse response = await _familyService.getMemberData();

      if (response.hasError()) {
        setBusy(false);
        return;
      }
      if (response.hasData()) {
        _memberData.assignAll(List<MyFamilyMemberModel>.from(response.data.map((x) => MyFamilyMemberModel.fromJson(x))));
      } else {
        _memberData.clear();
      }
      setBusy(false);
      await auth.getUser();
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> deleteMember({required int id}) async {
    setBusy(true);
    ApiResponse response = await _familyService.deleteMember(id: id);
    Get.back();

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      await getMemberData();
      return;
    }
    setBusy(false);
    await auth.getUser();
    await getMemberData();
    await menuController.getMemberData();
    Toastr.show(message: "${response.message}"); 
  }

  // Future<void> deleteMember({required int id}) async {
  //     ApiResponse response = await _familyService.deleteMember(id: id);
  //     Get.back();
  //     if (response.hasError()) {
  //       Toastr.show(message: "${response.message}");
  //       setBusy(false);
  //       return;
  //     } else {
  //       setBusy(false);
  //       await getMemberData();
  //       await menuController.getMemberData();
  //       Toastr.show(message: "${response.message}");
  //       Get.back();
  //     }
  // }

  void loginMember() {
    if (int.parse(auth.user.progress!) < 2) {
      Get.offAllNamed('/doctorProfile');
    }
    // else if( int.parse(auth.user.progress!) < 3) {
    //     Get.offAllNamed('/onboarding');
    // }
    else {
      dashboardController.onTabChanged(0);
    }
  }
}
