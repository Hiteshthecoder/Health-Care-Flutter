import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/LifestylePlanController.dart';

class LifestylePlanResults extends StatelessWidget {
  const LifestylePlanResults({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LifestylePlanController(),
        builder: (LifestylePlanController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Lifestyle Plan",
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
                                      description:
                                          "Create a lifestyle plan for yourself by answering simple questions.",
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
                      body: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.allSelected
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Your score is",
                                                          style: TextStyl.bodySm
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      SizedBox(height: spacer2),
                                                      Text(
                                                        "${controller.score} / 300",
                                                        style: TextStyl.heading1
                                                            ?.copyWith(
                                                                color:
                                                                    kcPrimary),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    controller.getResEmoji(),
                                                    style:
                                                        TextStyle(fontSize: 48),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: spacer5),
                                              Container(
                                                padding:
                                                    EdgeInsets.all(spacer2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: kcPrimary
                                                        .withOpacity(0.1)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .getRes()
                                                          .split('~')[0],
                                                      style: TextStyl.subtitle
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(height: spacer4),
                                                    Text(
                                                      controller
                                                          .getRes()
                                                          .split('~')[1],
                                                      style: TextStyl.body,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: spacer4,
                                              ),
                                              Text(
                                                "Advice",
                                                style: TextStyl.subtitle
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              SizedBox(height: spacer4),
                                              ...controller
                                                  .advice()
                                                  .map((e) => Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 32,
                                                                child: controller
                                                                        .adviceIcons[
                                                                    controller
                                                                        .advice()
                                                                        .indexOf(
                                                                            e)],
                                                              ),
                                                              SizedBox(
                                                                width: spacer2,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                e,
                                                                style: TextStyl
                                                                    .body,
                                                              )),
                                                            ],
                                                          ),
                                                          Divider()
                                                        ],
                                                      ))
                                                  .toList(),
                                            ])
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: 400,
                                              child: SvgPicture.asset(
                                                  "assets/images/undraw_activity_tracker.svg"),
                                            ),
                                            Text(
                                              "Curious about the quality of your lifestyle? Answer a few quick questions, receive a personalized score, and unlock valuable advice on enhancing your well-being with the power of AI! Let's get started on your journey to a healthier, happier you!",
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                  SizedBox(
                                    height: spacer5,
                                  ),
                                  Button.block(
                                      key: UniqueKey(),
                                      label: "New",
                                      onTap: (p0) => Get.toNamed(
                                          "/lifestylePlanQuestionnaire")),
                                  SizedBox(height: spacer5),
                                ],
                              ))));
        });
  }
}
