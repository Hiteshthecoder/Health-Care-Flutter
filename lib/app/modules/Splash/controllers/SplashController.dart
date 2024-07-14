import 'package:get/get.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/AuthState.dart';

class SplashController extends AppController {
  static SplashController get instance => Get.find();
  final AuthState auth = AuthState.instance;

  @override
  void onInit() {
    super.onInit();
    redirectUser();
  }

  Future<void> redirectUser() async {
    if (Config.authRequired) {
      if (await auth.check()) {
        await auth.getUser();
        // await 5.delay(() => Get.offAllNamed('/dashboard'));
        if (int.parse(auth.user.progress.toString()) < 1) {
          Get.offAllNamed('/profile');
        } else if (int.parse(auth.user.progress.toString()) < 3) {
          if (await storage.read('onboarded') == null) {
            Get.offAllNamed('/dashboard');
          } else {
            Get.offAllNamed('/onboarding');
          }
        } else {
          Get.offAllNamed('/dashboard');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/dashboard');
    }
  }
}
