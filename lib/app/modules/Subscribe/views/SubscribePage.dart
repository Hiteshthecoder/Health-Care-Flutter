import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/SubscribeController.dart';

class SubscribePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubscribeController(),
      builder: (SubscribeController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: 'My Subscription',
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
                                    description: "See your subscription plan here. Purchase a new plan or upgrade your existing plan.",
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
                    body: RefreshIndicator(
                      onRefresh: () async {
                        controller.mySubscription();
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: spacer8, vertical: spacer4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: spacer4, vertical: spacer5),
                                width: screen.width,
                                height: screen.height * 0.80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/subscribe_bg.png"), fit: BoxFit.fill),

                                  // border: Border.all(
                                  //   width:1.5,
                                  //   color: kcOrange.withOpacity(0.5),
                                  // ),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                      ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Obx(
                                  () => auth.user.id != controller.subscribe.userId
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/subscription.png",
                                              height: 180,
                                              width: 180,
                                            ),
                                            SizedBox(
                                              height: 150,
                                            ),
                                            Text(
                                              "${controller.subscribe.subscriptionStatus}", //name
                                              style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 25),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                              child: Container(
                                                height: 1.0,
                                                width: screen.width * 0.15,
                                                color: kcWhite,
                                              ),
                                            ),
                                            Text(
                                              "You have shared member package",
                                              style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: spacer2,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Valid Till - ${Jiffy(controller.subscribe.toDate).format('MMMM do yy')}",
                                                    style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 15),
                                                    // "30 days"
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer),
                                                child: Button.block(
                                                  key: UniqueKey(),
                                                  label:

                                                      // controller.subscribe.subscriptionStatus == "Expired" ?
                                                      //"Unlink" :
                                                      "Unlink",
                                                  variant: ButtonVariant.LIGHT,
                                                  onTap: (btn) async {
                                                    log.w(auth.user.id);
                                                    btn.setBusy(true).setDisabled(true);
                                                    await controller.selfUnlink(
                                                        id: int.parse(auth.user.id.toString()),
                                                        subscribeId: int.parse(controller.subscribe.id.toString()));
                                                    btn.setBusy(false).setDisabled(false);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/subscription.png",
                                              height: 180,
                                              width: 180,
                                            ),
                                            SizedBox(
                                              height: 150,
                                            ),
                                            Text(
                                              "${controller.subscribe.subscriptionStatus}", //name
                                              style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 25),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                              child: Container(
                                                height: 1.0,
                                                width: screen.width * 0.15,
                                                color: kcWhite,
                                              ),
                                            ),
                                            controller.subscribe.subscriptionStatus == "Paid "
                                                ? Text(
                                                    "VIP Member", //name
                                                    style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 20),
                                                  )
                                                : Text(""),
                                            SizedBox(
                                              height: spacer2,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Valid Till - ${Jiffy(controller.subscribe.toDate).format('MMMM do yy')}",
                                                    style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 15),
                                                    // "30 days"
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer),
                                                child: Button.block(
                                                  key: UniqueKey(),
                                                  label: controller.subscribe.subscriptionStatus == "Expired" ? "Renew" : " Upgrade Now",
                                                  variant: ButtonVariant.LIGHT,
                                                  onTap: (btn) async {
                                                    btn.setBusy(true).setDisabled(true);
                                                    Get.toNamed("/buyPlan");
                                                    btn.setBusy(false).setDisabled(false);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: spacer4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
