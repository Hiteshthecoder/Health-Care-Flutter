
import 'package:get/get.dart';

import '../../../../models/ApiResponse.dart';
import 'AppHomeService.dart';
import 'MockHomeService.dart';

abstract class HomeService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [LoginService]
  static HomeService get instance {
    if (!Get.isRegistered<HomeService>()) Get.lazyPut<HomeService>(() => MOCK_ENABLED ? MockHomeService() : AppHomeService());

    return Get.find<HomeService>();
  }

  /// Home the user
  Future<ApiResponse> submit({required Map<String, dynamic> body});


  /// Registers the user
  Future<ApiResponse> google();
}
