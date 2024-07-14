import 'package:flutter_mvc/app/models/ApiResponse.dart';
import 'package:get/get.dart';

import  'AppAuthService.dart';
import  'MockAuthService.dart';

abstract class AuthService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [AuthService]

  static AuthService get instance {
    if (!Get.isRegistered<AuthService>()) Get.lazyPut<AuthService>(() => MOCK_ENABLED ? MockAuthService() : AppAuthService());

    return Get.find<AuthService>();
  }

  /// Login the user
  Future<ApiResponse> login({required String identifier, required String password});

  /// Registers the user
  Future<ApiResponse> register({required Map<String, dynamic> body});

  /// Get and refresh user data
  Future<ApiResponse> getUser();

  /// Logout the user from system
  void logout();
}
