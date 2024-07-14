
import 'package:flutter_mvc/app/shared/services/user/UserService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import '../../helpers/Global.dart';
import '../../models/ApiResponse.dart';
import '../../models/MySubscriptionModel.dart';
import 'AppController.dart';
class UserController extends AppController {
  /// Static Getter for [AuthState]
  ///
  /// Can be accessed by calling `AuthState.instance`
  static UserController get instance => Get.find<UserController>();

  UserService _userService = UserService.instance;

  // Observables
  var _subscribe = MySubscriptionModel().obs;

  /// Getters
  MySubscriptionModel get subscribe => _subscribe.value;

  @override
  void onInit() {
    super.onInit();
  //  getSubscription();
  }

  Future<void> getSubscription() async {
    if (await auth.check()) {
      ApiResponse response = await _userService.getSubscription();

      if (response.hasError()) {
        log.w(response.message);
        // Toastr.show(message: "${response.message}");
        return;
      }

      if (response.hasData()) {
        _subscribe(MySubscriptionModel.fromJson(response.data));
      }
    }
  }

  /// Logout the user
  // Future<void> logout() async {
  //   // ApiResponse response = await Request.post('/logout', authenticate: true);
  //   // if (response.hasError()) {
  //   //   Toastr.show(message: "${response.message}");
  //   //   return;
  //   // }
  //   // Toastr.show(message: "${response.message}");
  //   await storage.remove('token');
  //   await storage.remove('user');
  //   Get.offAllNamed('/login');
  // }
  //
  // /// Setter for user data [setUserData(String)]
  // Future<void> setUserData(Map<String, dynamic> userData) async {
  //   await storage.write("user", userData);
  //   _user(UserModel.fromJson(userData));
  // }
  //
  // /// Setter for user auth token [setUserToken(String)]
  // Future<void> setUserToken(String token) async {
  //   await storage.write("token", token);
  // }
  //
  // /// Checks if user is logged in by validating the token
  // Future<bool> check() async {
  //   if (storage.read('token') != null) {
  //     // ApiResponse response = await Request.get("/validate-token", authenticate: true);
  //     // if (response.hasError()) {
  //     //   return false;
  //     // }
  //     return true;
  //   }
  //
  //   return false;
  // }

// bool get loggedIn => check().whenComplete(() => true);
}
