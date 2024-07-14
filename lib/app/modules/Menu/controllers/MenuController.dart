import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/UserModel.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/MyFamilyMemberModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../../Dashboard/controllers/DashboardController.dart';
import '../../MyFamily/services/MyFamilyService.dart';
import '../../Subscribe/controllers/SubscribeController.dart';
import '../services/MenuService.dart';

class MenueController extends AppController {
  static MenueController get instance {
    if (!Get.isRegistered<MenueController>()) Get.put(MenueController());
    return Get.find<MenueController>();
  }

  final DashboardController dashboardController = DashboardController.instance;

  /// Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final MenuService _menuService = MenuService.instance;
  final MyFamilyService _myFamilyService = MyFamilyService.instance;
  SubscribeController subscribeController = SubscribeController.instance;

  /// Observables
  var _isMemberLoggedIn = false.obs;
  var _menu = UserModel().obs;
  var _memberData = <MyFamilyMemberModel>[].obs;
  var _userData = UserModel().obs;

  /// Getters
  bool get isMemberLoggedIn => _isMemberLoggedIn.value;

  UserModel get menu => _menu.value;

  List<MyFamilyMemberModel> get memberData => _memberData;

  UserModel get userData => _userData.value;

  @override
  void onInit() async {
    super.onInit();
    // getMenuData();
    getMemberData();
    await auth.getUser();
    subscribeController.getSubscriptionPlan();
    subscribeController.mySubscription();
    checkIfMemberIsLoggedIn();
  }

  void checkIfMemberIsLoggedIn() async {
    var oldUser = await storage.read('old_user');
    var isChief = await storage.read('old_user_is_chief');
    _isMemberLoggedIn(oldUser != null && isChief != null);
  }

  Future<void> getMemberData({bool immediate = false}) async {
    try {
      if (!immediate) setBusy(true);
      ApiResponse response = await _myFamilyService.getMemberData();

      if (response.hasError()) {
        setBusy(false);
        return;
      }
      if (response.hasData()) {
        _memberData.assignAll(List<MyFamilyMemberModel>.from(
            response.data.map((x) => MyFamilyMemberModel.fromJson(x))));
      } else {
        _memberData.clear();
      }
      setBusy(false);
      await auth.getUser();
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> deleteAccount({bool immediate = false}) async {
    try {
      setBusy(true);
      ApiResponse response = await _menuService.deleteAccount();

      if (response.hasError()) {
        setBusy(false);
        return;
      }
      Toastr.show(message: response.message ?? "");

      await storage.remove('token');
      await storage.remove('user');
      Get.offAllNamed('/login');

      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> reLoginOldUser({bool redirect = false}) async {
    showBusy();

    /// Re login old user
    await auth.setUserData(await storage.read('old_user'));
    await auth.setUserToken(await storage.read('old_token'));
    await auth.getUser();

    // remove
    await storage.remove('old_user');
    await storage.remove('old_user_is_chief');
    checkIfMemberIsLoggedIn();
    // getMenuData(immediate: true);
    getMemberData(immediate: true);
    hideBusy();
    if (redirect) {
      Get.offAllNamed('/dashboard');
    } else {
      dashboardController.onTabChanged(0);
    }
  }

  Future<void> loginMemberUser({required int id}) async {
    showBusy();

    /// Call api to login user
    ApiResponse response =
        await _menuService.loginMemberUser(userId: id, id: auth.user.id);
    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      hideBusy();
      return;
    }
    log.w(response.toJson());

    /// Save already logged in user in memory
    await storage.write('old_user', auth.user.toJson());
    await storage.write('old_token', await storage.read("token"));
    await storage.write('old_user_is_chief', 'true');

    /// Set logged in data for new user
    _userData(UserModel.fromJson(response.data['user']));
    //await auth.setUserData(response.data['user']);
    await auth.setUserToken(response.data['token']);

    if (int.parse(userData.progress!) == 1) {
      Get.offAllNamed('/doctorProfile');
    } else {
      await auth.setUserData(response.data['user']);
      await auth.setUserToken(response.data['token']);
      if (Get.currentRoute == "/dashboard")
        dashboardController.onTabChanged(0);
      else
        Get.offAllNamed("/dashboard");
      dashboardController.onTabChanged(0);
    }

    // if(int.parse(auth.user.progress!) < 2){
    //   Get.offNamed('/doctorProfile');
    //   }
    // // else if( int.parse(auth.user.progress!) < 3) {
    // //     Get.offAllNamed('/onboarding');
    // // }
    // else  {
    //   log.w(Get.currentRoute);
    //   if(Get.currentRoute == "/dashboard")
    //     dashboardController.onTabChanged(0);
    //   else
    //       Get.offAllNamed("/dashboard");
    //       dashboardController.onTabChanged(0);
    // }

    await auth.getUser();
    checkIfMemberIsLoggedIn();
    getMemberData(immediate: true);
    hideBusy();
  }
// }
}
