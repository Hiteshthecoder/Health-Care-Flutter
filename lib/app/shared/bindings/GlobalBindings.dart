import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../controllers/AuthState.dart';
import '../controllers/NotificationController.dart';
import '../controllers/UserController.dart';
import '../services/Services.dart';
import '../services/auth/AppAuthService.dart';
import '../services/auth/MockAuthService.dart';

class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    /// [AuthService] instance
    Get.lazyPut<AuthService>(() => AuthService.MOCK_ENABLED ? MockAuthService() : AppAuthService());

    /// Initialize [AuthState]
    Get.lazyPut<AuthState>(() => AuthState(), fenix: true);
    Get.put(UserController(), permanent: true);

    /// [ButtonController] instance
    Get.create(() => ButtonController(), permanent: false);

    // /// [NotificationController]
    // Get.put(NotificationController(), permanent: true);
  }
}
