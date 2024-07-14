
import 'package:get/get.dart';
import '../../../models/ApiResponse.dart';

import 'AppProfileService.dart';
import 'MockProfileService.dart';

abstract class ProfileService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [LoginService]
  static ProfileService get instance {
    if (!Get.isRegistered<ProfileService>()) Get.lazyPut<ProfileService>(() => MOCK_ENABLED ? MockProfileService() : AppProfileService());

    return Get.find<ProfileService>();
  }
  /// Profile Setup
  Future<ApiResponse> profileSetup({required Map<String, dynamic> body ,required userID});
  Future<ApiResponse> createPrimaryDoctor({required Map<String, dynamic> body ,required String userID});
  Future<ApiResponse> updateProfile({required Map<String, dynamic> body});
  Future<ApiResponse> submitDoctorProfile({required Map<String, dynamic> body});
  Future<ApiResponse> getState();
  Future<ApiResponse> getCity({required stateID});
  Future<ApiResponse> linkDoctor({required String phone});
}
