
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppSubscriptionService.dart';
import 'MockSubscriptionService.dart';

abstract class SubscriptionService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;


  static SubscriptionService get instance {
    if (!Get.isRegistered<SubscriptionService>()) Get.lazyPut<SubscriptionService>(() => MOCK_ENABLED ? MockSubscriptionService() : AppSubscriptionService());

    return Get.find<SubscriptionService>();
  }
  Future<ApiResponse> getSubscriptionPlan() ;
  Future<ApiResponse> checkoutStatus({required Map<String, dynamic> body});
  Future<ApiResponse> mySubscription();
  Future<ApiResponse> unlinkSubscription({required int id});
  Future<ApiResponse> selfUnlink({required int authid, required int subscribeId});
}
