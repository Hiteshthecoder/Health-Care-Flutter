import 'package:flutter_mvc/app/models/ApiResponse.dart';
import '../../../helpers/Request.dart';
import 'UserService.dart';

class AppUserService implements UserService {
  @override
  Future<ApiResponse> getSubscription() async {
    return await Request.get('/subscription/my-subscription', authenticate: true);
  }

}
