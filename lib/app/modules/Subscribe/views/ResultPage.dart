import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Dashboard/controllers/DashboardController.dart';

import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/layouts/MasterLayout.dart';
import '../controllers/SubscribeController.dart';

DashboardController dashboardController = Get.put(DashboardController());

class ResultPage extends StatelessWidget {
  final SubscribeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      title: "Thank you!",
      backgroundColor: kcWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacer),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: BorderRadius.circular(spacer2),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: spacer * 5, horizontal: spacer5),
              child: Column(
                children: [
                  // Image.asset(
                  //   assetIcon('tick.png'),
                  //   width: spacer10 * 2,
                  // ),
                  // const SizedBox(height: spacer5),
                  Icon(
                    Icons.emoji_emotions_rounded,
                    color: kcWarning.withOpacity(0.8),
                    size: 45,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Congratulations',
                    style: TextStyl.subtitle?.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: spacer3),
                  Text(
                    'Your subscription to plan has been successful.',
                    style: TextStyl.body,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Regards,',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Team DQ Care',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kcDarkAlt,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: kcDarkAlt,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Go to Home',
                    style: TextStyl.label?.copyWith(
                      fontSize: spacer5 / 1.2,
                      color: kcDarkAlt,
                      // fontWeight: fw600,
                    ),
                  ),
                ],
              ),
              onTap: () {
                dashboardController.onTabChanged(0);
                Get.offAllNamed("/dashboard");
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
