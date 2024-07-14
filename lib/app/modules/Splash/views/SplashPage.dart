import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../controllers/SplashController.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    return Scaffold(
      // backgroundColor: kcPrimary,
      backgroundColor: kcWhite,
      body: Container(
        // color: kcPrimary,
        color: kcWhite,
        height: screen.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              image('logo.png'), // launcher_icon.png
              width: screen.width * 0.5,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              // child: LoadingIcon(height: spacer, color: kcWhite), // kcBlack
              child: LoadingIcon(height: spacer, color: kcPrimary), // kcBlack
            ),
          ],
        ),
      ),
    );
  }
}
