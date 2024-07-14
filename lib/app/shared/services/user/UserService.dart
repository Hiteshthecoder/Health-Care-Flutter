import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:get/get.dart';

import 'AppUserService.dart';
import 'MockUserService.dart';

abstract class UserService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [AuthService]

  static UserService get instance {
    if (!Get.isRegistered<UserService>()) Get.lazyPut<UserService>(() => MOCK_ENABLED ? MockUserService() : AppUserService());

    return Get.find<UserService>();
  }

 Future<ApiResponse> getSubscription();
}
