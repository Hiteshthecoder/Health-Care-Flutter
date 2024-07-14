import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/models/UserModel.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../models/ApiResponse.dart';
import 'UserService.dart';

class MockUserService implements UserService {
  @override
  Future<ApiResponse> getSubscription() {
    // TODO: implement getData
    throw UnimplementedError();
  }

}
