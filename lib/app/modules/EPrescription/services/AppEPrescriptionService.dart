import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'EPrescriptionService.dart';

class AppEPrescriptionService implements EPrescriptionService {
  Future<ApiResponse> getEPrescriptionData() async {
    return await Request.get('/patient/my-followup', authenticate: true);
  }

  @override
  Future<ApiResponse> getPatientPrescriptionList(
      {required int patientId}) async {
    print("-----------------------patient----------------------------");
    return await Request.post('/patient/eprescription/list/$patientId',
        body: {}, authenticate: true);
  }

  @override
  Future<ApiResponse> getPrescriptionPdfAPI(
      {required String prescriptionId}) async {
    return await Request.get('/doctor/eprescription/preview/$prescriptionId',
        authenticate: true);
  }
}
