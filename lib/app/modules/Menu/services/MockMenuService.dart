import '../../../models/ApiResponse.dart';
import 'MenuService.dart';

class MockMenuService implements MenuService {
  @override
  Future<ApiResponse> getMenuData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> loginMemberUser({required userId, required id}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
