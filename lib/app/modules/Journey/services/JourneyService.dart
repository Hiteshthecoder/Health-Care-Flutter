
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppJourneyService.dart';
import 'MockJourneyService.dart';

abstract class JourneyService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static JourneyService get instance {
    if (!Get.isRegistered<JourneyService>()) Get.lazyPut<JourneyService>(() => MOCK_ENABLED ? MockJourneyService() : AppJourneyService());

    return Get.find<JourneyService>();
  }
  Future<ApiResponse> getJourneyData() ;

}
