import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'ProfileService.dart';

class AppProfileService implements ProfileService {
  @override
  Future<ApiResponse> profileSetup({required Map<String, dynamic> body, required userID}) async {
    return await Request.post('/patient/profile-setup/$userID', body: body, authenticate: true);
  }

  Future<ApiResponse> createPrimaryDoctor({required Map<String, dynamic> body, required String userID}) async {
    return await Request.post('/patient/doctor-selector/$userID', body: body, authenticate: true);
  }

  Future<ApiResponse> updateProfile({required Map<String, dynamic> body}) async {
    return await Request.post('/patient/update', body: body, authenticate: true);
  }

  Future<ApiResponse> submitDoctorProfile({required Map<String, dynamic> body}) {
    // TODO: implement submitDoctorProfile
    throw UnimplementedError();
  }

  Future<ApiResponse> getState() async {
    return await Request.get('/get-states', authenticate: true);
  }

  Future<ApiResponse> getCity({required stateID}) async {
    return await Request.get('/get-cities?state_id=$stateID', authenticate: true);
  }

  Future<ApiResponse> linkDoctor({required String phone}) async {
    return await Request.get('/member/link-doctor?phone=$phone', authenticate: true);
  }
}
