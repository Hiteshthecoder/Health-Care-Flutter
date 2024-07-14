
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppDoctorService.dart';
import 'MockDoctorService.dart';

abstract class DoctorService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static DoctorService get instance {
    if (!Get.isRegistered<DoctorService>()) Get.lazyPut<DoctorService>(() => MOCK_ENABLED ? MockDoctorService() : AppDoctorService());

    return Get.find<DoctorService>();
  }
  Future<ApiResponse> getDoctorData({ int? page, String? state, String? city, String? district, String? pincode}) ;
  Future<ApiResponse> getState();

  Future<ApiResponse> getCity({required stateID});
  Future<ApiResponse> getDoctorShowDetails({required int id});

}
