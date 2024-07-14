
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppFollowupService.dart';
import 'MockFollowupService.dart';

abstract class FollowupService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static FollowupService get instance {
    if (!Get.isRegistered<FollowupService>()) Get.lazyPut<FollowupService>(() => MOCK_ENABLED ? MockFollowupService() : AppFollowupService());

    return Get.find<FollowupService>();
  }
  Future<ApiResponse> getFollowupData() ;

}
