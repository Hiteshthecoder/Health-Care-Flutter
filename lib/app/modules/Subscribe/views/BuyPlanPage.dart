import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/SubscriptionModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/SubscribeController.dart';

class BuyPlanPage extends StatelessWidget {
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
                    title: 'My Plan',
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
                                    title: 'Title here',
                                    description:
                                        "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients.",
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
                      onRefresh: () async {},
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: spacer6, vertical: spacer2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(
                                controller.subscribePlan.length,
                                (index) {
                                  SubscriptionModel subscribe = controller.subscribePlan[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: spacer2),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: spacer4, vertical: spacer2),
                                      width: screen.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: subscribe.name == "Monthy"
                                                ? AssetImage("assets/images/plan1.png")
                                                : subscribe.name == "Yearly"
                                                    ? AssetImage("assets/images/plan2.png")
                                                    : AssetImage("assets/images/plan33.png"),
                                            fit: BoxFit.fill),
                                        border: Border.all(
                                          width: 1.0,
                                          color: kcWhite.withOpacity(0.5),
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                            ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        color: kcPurple,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${subscribe.name} ", //name
                                            style: TextStyl.body?.copyWith(fontWeight: FontWeight.bold, color: kcWhite, fontSize: 18),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                            child: Container(
                                              height: 1.0,
                                              width: screen.width * 0.20,
                                              color: kcWhite,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/rupee.png',
                                                color: kcWhite,
                                                width: 40,
                                                height: 40,
                                              ),
                                              Text("${subscribe.price}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: kcWhite)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("${subscribe.duration} Days",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kcWhite)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: spacer3, horizontal: spacer),
                                            child: Button.block(
                                              key: UniqueKey(),
                                              label: "Proceed to pay",
                                              variant: ButtonVariant.LIGHT,
                                              onTap: (btn) async {
                                                btn.setBusy(true).setDisabled(true);
                                                controller.purchaseSubscription(
                                                    subscriptionId: int.parse(subscribe.id.toString()),
                                                    price: double.parse(subscribe.price.toString()),
                                                    description: '${subscribe.name}');
                                                // await controller.makePayment(double.parse(subscribe.price.toString()),'${subscribe.name}');
                                                btn.setBusy(false).setDisabled(false);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
