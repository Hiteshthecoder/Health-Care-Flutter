import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppEPrescriptionService.dart';
import 'MockEPrescriptionService.dart';

abstract class EPrescriptionService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static EPrescriptionService get instance {
    if (!Get.isRegistered<EPrescriptionService>())
      Get.lazyPut<EPrescriptionService>(() => MOCK_ENABLED
          ? MockEPrescriptionService()
          : AppEPrescriptionService());

    return Get.find<EPrescriptionService>();
  }

  Future<ApiResponse> getEPrescriptionData();
  Future<ApiResponse> getPatientPrescriptionList({required int patientId});Future<ApiResponse> getPrescriptionPdfAPI({required String prescriptionId});

}
