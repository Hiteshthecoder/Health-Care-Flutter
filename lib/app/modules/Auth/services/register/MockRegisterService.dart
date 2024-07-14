
import '../../../../models/ApiResponse.dart';
import 'RegisterService.dart';

class MockRegisterService implements RegisterService {

  @override
  Future<ApiResponse> submitRegistration({required Map<String, dynamic> body}) {
    throw UnimplementedError();
  }
}
