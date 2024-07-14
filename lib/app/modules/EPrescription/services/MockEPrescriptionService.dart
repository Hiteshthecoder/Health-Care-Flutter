import '../../../models/ApiResponse.dart';
import 'EPrescriptionService.dart';

class MockEPrescriptionService implements EPrescriptionService {
  @override
  Future<ApiResponse> getEPrescriptionData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getPatientPrescriptionList({required int patientId}) {
    // TODO: implement getPatientPrescriptionList
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getPrescriptionPdfAPI({required String prescriptionId}) {
    // TODO: implement getPrescriptionPdfAPI
    throw UnimplementedError();
  }
}
