
import 'package:flutter_mvc/app/models/ApiResponse.dart';

import '../../../../helpers/Request.dart';
import 'RegisterService.dart';

class AppRegisterService implements RegisterService {
  @override

  Future<ApiResponse> submitRegistration({required Map<String, dynamic> body}) async {
    return await Request.post('/doctor/user-enquiry', body: body,authenticate: true);
  }
}
