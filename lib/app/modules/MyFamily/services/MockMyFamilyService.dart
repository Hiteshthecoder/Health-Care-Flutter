import '../../../models/ApiResponse.dart';
import 'MyFamilyService.dart';

class MockMyFamilyService implements MyFamilyService {
  @override
  Future<ApiResponse> getPostData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override


  Future<ApiResponse> addMember({required Map<String, dynamic> body }){
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> getMemberData() {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> deleteMember({required int id})  {
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
  Future<ApiResponse> getRelation(){
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> linkMember({required Map<String, dynamic> body}){
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> linkMemberOtp({required Map<String, dynamic> body}){
    // TODO: implement getData
    throw UnimplementedError();
  }
}