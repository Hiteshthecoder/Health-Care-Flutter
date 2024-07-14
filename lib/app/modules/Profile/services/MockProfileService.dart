
import '../../../models/ApiResponse.dart';
import 'ProfileService.dart';

class MockProfileService implements ProfileService {


  @override
  Future<ApiResponse> google() {
    // TODO: implement googleLogin
    throw UnimplementedError();
  }

  Future<ApiResponse> profileSetup({required Map<String, dynamic> body ,required userID})  {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
  Future<ApiResponse> createPrimaryDoctor({required Map<String, dynamic> body ,required String userID}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
  Future<ApiResponse> updateProfile({required Map<String, dynamic> body}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  Future<ApiResponse> submitDoctorProfile({required Map<String, dynamic> body}) {
    // TODO: implement submitDoctorProfile
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

  Future<ApiResponse> linkDoctor({required String phone}){
    // TODO: implement getData
    throw UnimplementedError();
  }


}
