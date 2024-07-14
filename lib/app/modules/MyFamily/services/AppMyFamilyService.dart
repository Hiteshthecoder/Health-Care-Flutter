import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'MyFamilyService.dart';

class AppMyFamilyService implements MyFamilyService {
  Future<ApiResponse> addMember({required Map<String, dynamic> body}) async {
    return await Request.post('/member/add-member', body: body, authenticate: true);
  }

  Future<ApiResponse> getMemberData() async {
    return await Request.get('/member/my-family-members', authenticate: true);
  }

  Future<ApiResponse> deleteMember({required int id}) async {
    return await Request.get('/member/subscription-delete/$id', authenticate: true);
  }

  Future<ApiResponse> getState() async {
    return await Request.get('/get-states', authenticate: true);
  }


  Future<ApiResponse> getCity({required stateID}) async {
    return await Request.get('/get-cities?state_id=$stateID', authenticate: true);
  }

  Future<ApiResponse> getRelation() async {
    return await Request.get('/patient/get-relation', authenticate: true);
  }
  Future<ApiResponse> linkMember({required Map<String, dynamic> body}) async {
    return await Request.post('/member/link-member-number', body: body, authenticate: true);
  }
  Future<ApiResponse> linkMemberOtp({required Map<String, dynamic> body}) async {
    return await Request.post('/member/link-member', body: body, authenticate: true);
  }
}
