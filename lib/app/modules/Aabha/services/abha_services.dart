import 'package:get/get.dart';
import "../../../models/ApiResponse.dart";

import '../../../helpers/Request.dart';

class AbhaServices {
  static AbhaServices get instance {
    if (!Get.isRegistered<AbhaServices>()) Get.lazyPut<AbhaServices>(() => AbhaServices());

    return Get.find<AbhaServices>();
  }

  Future<ApiResponse> generateToken() async {
    return await Request.post('http://157.245.101.242/health/api/v1/abha/generate-token');
  }

  Future<ApiResponse> getAdharOtp(Map<String, dynamic> body, dynamic headers) async {
    return await Request.post(
      "http://157.245.101.242/health/api/v1/abha/get-login-aadhar",
      body: body,
      headers: headers,
    );
  }
}
