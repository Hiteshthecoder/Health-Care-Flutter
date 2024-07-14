import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'ActivateAccountService.dart';

class AppActivateAccountService implements ActivateAccountService {

  Future<ApiResponse> activateAccount({required Map<String, dynamic> body}) async {
    return await Request.post('/member/activate-account-otp', body: body, authenticate: true);
  }
  Future<ApiResponse> activateAccountOtp({required Map<String, dynamic> body}) async {
    return await Request.post('/member/activate-account', body: body, authenticate: true);
  }
}
