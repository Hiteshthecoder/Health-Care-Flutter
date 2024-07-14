
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppMyFamilyService.dart';
import 'MockMyFamilyService.dart';

abstract class MyFamilyService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static MyFamilyService get instance {
    if (!Get.isRegistered<MyFamilyService>()) Get.lazyPut<MyFamilyService>(() => MOCK_ENABLED ? MockMyFamilyService() : AppMyFamilyService());

    return Get.find<MyFamilyService>();
  }

  Future<ApiResponse> addMember({required Map<String, dynamic> body });

  Future<ApiResponse> getMemberData();

  Future<ApiResponse> deleteMember({required int id});

  Future<ApiResponse> getState();

  Future<ApiResponse> getCity({required stateID});

  Future<ApiResponse> getRelation();

  Future<ApiResponse> linkMember({required Map<String, dynamic> body});

  Future<ApiResponse> linkMemberOtp({required Map<String, dynamic> body});
}