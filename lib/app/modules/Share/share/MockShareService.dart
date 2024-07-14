
import '../../../models/ApiResponse.dart';
import 'ShareService.dart';


class MockShareService implements ShareService {


  @override
  Future<ApiResponse> google() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  // @override
  // Future<ApiResponse> submitProfile({required Map<String, dynamic> body}) {
  //   // TODO: implement verifyOtp
  //   throw UnimplementedError();
  // }

}
