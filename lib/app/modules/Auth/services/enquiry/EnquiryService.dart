
import 'package:get/get.dart';

import '../../../../helpers/Global.dart';
import '../../../../models/ApiResponse.dart';
import 'AppEnquiryService.dart';
import 'MockEnquiryService.dart';

abstract class EnquiryService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;
  /// Create and get the instance of [EnquiryService]
  static EnquiryService get instance {
    if (!Get.isRegistered<EnquiryService>()) Get.lazyPut<EnquiryService>(() => MOCK_ENABLED ? MockEnquiryService() : AppEnquiryService());

    return Get.find<EnquiryService>();
  }


  Future<ApiResponse> enquiryForm({required Map<String, dynamic> body,}) ;

}
