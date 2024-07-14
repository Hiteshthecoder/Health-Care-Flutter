import '../../../models/ApiResponse.dart';
import 'DiagnosticService.dart';

class MockDiagnosticService implements DiagnosticService {
  @override
  Future<ApiResponse> getDiagnosticData({int? page ,String? state, String? city, String? district, String? pincode}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> getState() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> getCity({required stateID}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
}
