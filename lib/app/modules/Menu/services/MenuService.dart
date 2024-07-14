import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppMenuService.dart';
import 'MockMenuService.dart';

abstract class MenuService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static MenuService get instance {
    if (!Get.isRegistered<MenuService>())
      Get.lazyPut<MenuService>(
          () => MOCK_ENABLED ? MockMenuService() : AppMenuService());

    return Get.find<MenuService>();
  }

  Future<ApiResponse> getMenuData();
  Future<ApiResponse> loginMemberUser({required userId, required id});
  Future<ApiResponse> deleteAccount();
}
