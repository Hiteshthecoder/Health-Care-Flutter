
import 'package:get/get.dart';


import '../../models/ApiResponse.dart';
import 'AppRewardsService.dart';
import 'MockRewardsService.dart';

abstract class RewardsService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [RewardsService]
  static RewardsService get instance {
    if (!Get.isRegistered<RewardsService>()) Get.lazyPut<RewardsService>(() => MOCK_ENABLED ? MockRewardsService() : AppRewardsService());

    return Get.find<RewardsService>();
  }
  Future<ApiResponse> getRewardsData() ;

}
