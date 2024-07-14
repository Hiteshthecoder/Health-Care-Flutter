
import '../../../../helpers/Request.dart';
import '../../../../models/ApiResponse.dart';
import 'HomeService.dart';

class AppHomeService implements HomeService{

  @override
  Future<ApiResponse> submit({required Map<String, dynamic> body}) async {
    return await Request.post('/login', body: body);
  }

  @override
  Future<ApiResponse> google() {
    // TODO: implement google
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> verifyOtp({required Map<String, dynamic> body}) async {
    return await Request.post('/verify-otp', body: body);
  }
}
