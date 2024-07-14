import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'MenuService.dart';

class AppMenuService implements MenuService {
  Future<ApiResponse> getMenuData() async {
    return await Request.get('/patient/health-tips/index', authenticate: true);
  }

  Future<ApiResponse> loginMemberUser({required userId, required id}) async {
    return await Request.get('/member-login/$userId/$id', authenticate: true);
  }

  @override
  Future<ApiResponse> deleteAccount() async {
    return await Request.post('/patient/remove', authenticate: true, body: {});
  }
}
