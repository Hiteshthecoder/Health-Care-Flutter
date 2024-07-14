import '../../../models/ApiResponse.dart';
import 'DoctorService.dart';

class MockDoctorService implements DoctorService {
  @override
  Future<ApiResponse> getDoctorData({int? page, String? state, String? city, String? district, String? pincode}) {
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

  Future<ApiResponse> getDoctorShowDetails({required int id}){
    // TODO: implement getData
    throw UnimplementedError();
  }
}