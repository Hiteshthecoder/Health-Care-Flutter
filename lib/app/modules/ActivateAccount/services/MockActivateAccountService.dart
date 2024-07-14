import '../../../models/ApiResponse.dart';
import 'ActivateAccountService.dart';

class MockActivateAccountService implements ActivateAccountService {
  @override
  Future<ApiResponse> getPostData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> activateAccount({required Map<String, dynamic> body}){
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> activateAccountOtp({required Map<String, dynamic> body}){
    // TODO: implement getData
    throw UnimplementedError();
  }
}