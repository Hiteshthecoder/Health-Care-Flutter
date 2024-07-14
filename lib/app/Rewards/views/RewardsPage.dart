import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../models/RewardsModel.dart';
import '../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../shared/views/widgets/HelperWidget.dart';
import '../../shared/views/widgets/LoadingWidget.dart';
import '../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/RewardsController.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RewardsController(),
        builder: (RewardsController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      backgroundColor: kcOffWhite,
                      title: 'Rewards',
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: spacer4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    HelperWidget(
                                      description: "Get reward points just for uploading your various medical documents and reports. Exchange this reward points for exciting offers in future.",
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/contact.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                width: spacer1,
                              ),
                            ],
                          ),
                        ),
                      ],
                      titleSpacing: 0,
                      leadingWidth: 45,
                      body: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(spacer2),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    'assets/images/reward-card.png',
                                    width: 125,
                                  ),
                                  Text(
                                    'Get Daily Rewards!',
                                    textAlign: TextAlign.center,
                                    style: TextStyl.subtitle?.copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    'Get rewards by managing your\n medical records.',
                                    textAlign: TextAlign.center,
                                    style: TextStyl.bodySm?.copyWith(color: kcDarkAlt),
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Obx(
                                    () => controller.rewards.isEmpty
                                        ? Center(
                                            child: NoDataWidget(
                                            message: 'No Rewards Data Found!',
                                            icon: SvgPicture.asset(
                                              'assets/icons/gift-card.svg',
                                              width: spacer8,
                                              color: kcDarkAlt,
                                            ),
                                          ))
                                        : SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ...List.generate(controller.rewards.length, (index) {
                                                  RewardModel rewards = controller.rewards[index];
                                                  return Column(
                                                    children: [
                                                      int.parse('${rewards.month}') == DateTime.now().month
                                                          ? Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(color: kcBlack.withOpacity(0.1), width: 0.52),
                                                                color: kcPrimary.withOpacity(0.8),
                                                              ),
                                                              margin: EdgeInsets.all(4),
                                                              width: screen.width,
                                                              child: Row(
                                                                children: [
                                                                  // Container(
                                                                  //   padding: EdgeInsets.all(9),
                                                                  //   decoration: BoxDecoration(
                                                                  //     borderRadius: BorderRadius.circular(10),
                                                                  //     color: kcWhite.withOpacity(0.8),
                                                                  //   ),
                                                                  //   child: Image.asset("assets/images/coins.png", width: 40, height: 45),
                                                                  // ),
                                                                  // SizedBox(
                                                                  //   width: spacer2,
                                                                  // ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '${rewards.monthName},',
                                                                        style: TextStyle(
                                                                            color: kcWhite.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w700),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                        //"${revenues.total}",
                                                                        '${rewards.year}',
                                                                        style: TextStyle(
                                                                            color: kcWhite.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '${rewards.points} Super Bonus',
                                                                    style: TextStyle(color: kcWhite, fontSize: 18, fontWeight: FontWeight.w600),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(color: kcBlack.withOpacity(0.1), width: 0.52),
                                                                color: kcWhite,
                                                              ),
                                                              margin: EdgeInsets.all(4),
                                                              width: screen.width,
                                                              child: Row(
                                                                children: [
                                                                  // Container(
                                                                  //   padding: EdgeInsets.all(9),
                                                                  //   decoration: BoxDecoration(
                                                                  //     borderRadius: BorderRadius.circular(10),
                                                                  //     color: kcWhite.withOpacity(0.8),
                                                                  //   ),
                                                                  //   child: Image.asset("assets/images/coins.png", width: 40, height: 45),
                                                                  // ),
                                                                  // SizedBox(
                                                                  //   width: spacer2,
                                                                  // ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        '${rewards.monthName},',
                                                                        style: TextStyle(
                                                                          color: kcBlack,
                                                                          fontSize: 18,
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                        //"${revenues.total}",
                                                                        '${rewards.year}',
                                                                        style: TextStyle(color: kcBlack, fontSize: 15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    '${rewards.points} Super Bonus',
                                                                    style: TextStyle(color: kcBlack, fontSize: 18, fontWeight: FontWeight.w600),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                    ],
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
        });
  }
}
