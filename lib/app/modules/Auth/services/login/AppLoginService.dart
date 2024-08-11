import '../../../../helpers/Request.dart';
import '../../../../models/ApiResponse.dart';
import 'LoginService.dart';

class AppLoginService implements LoginService {
  @override
  Future<ApiResponse> submit({required Map<String, dynamic> body}) async {
    return await Request.post('/patient/login', body: body);
  }

  @override
  Future<ApiResponse> google() {
    // TODO: implement google
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> verifyOtp({required Map<String, dynamic> body}) async {
    return await Request.post('/patient/verify-otp', body: body);
  }

  Future<ApiResponse> updateUserDeviceToken({required Map<String, dynamic> body}) async {
    return await Request.post("/update-device-token", body: body, authenticate: true);
  }
}
