
import 'package:flutter_mvc/app/modules/Share/share/AppShareService.dart';
import 'package:flutter_mvc/app/modules/Share/share/MockShareService.dart';
import 'package:get/get.dart';
import '../../../models/ApiResponse.dart';


abstract class ShareService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [LoginService]
  static ShareService get instance {
    if (!Get.isRegistered<ShareService>()) Get.lazyPut<ShareService>(() => MOCK_ENABLED ? MockShareService() : AppShareService());

    return Get.find<ShareService>();
  }


  // /// Profile Setup
  // Future<ApiResponse> submitProfile({required Map<String, dynamic> body});

  /// Registers the user
  Future<ApiResponse> google();


}
