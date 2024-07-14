import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/EPrescription/views/EPrescriptionShowPage.dart';
import 'package:flutter_mvc/app/modules/LifestylePlan/controllers/LifestylePlanController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';

class LifestylePlanQuestionnaire extends StatelessWidget {
  const LifestylePlanQuestionnaire({super.key});

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
                      title: "Lifestyle Plan Results",
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() => Column(
                                  children: List.generate(
                                          controller.questions.length,
                                          (index) => index)
                                      .map((idx) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .questions[idx].question,
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              SizedBox(height: spacer2),
                                              RadioListTile(
                                                title: Text(controller
                                                    .questions[idx].option1),
                                                value: 3,
                                                groupValue:
                                                    controller.choices[idx],
                                                onChanged: (value) =>
                                                    controller.updateChoices(
                                                        index: idx, value: 3),
                                                dense: true,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                              ),
                                              RadioListTile(
                                                title: Text(controller
                                                    .questions[idx].option2),
                                                value: 2,
                                                groupValue:
                                                    controller.choices[idx],
                                                onChanged: (value) =>
                                                    controller.updateChoices(
                                                        index: idx, value: 2),
                                                dense: true,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                              ),
                                              RadioListTile(
                                                title: Text(controller
                                                    .questions[idx].option3),
                                                value: 1,
                                                groupValue:
                                                    controller.choices[idx],
                                                onChanged: (value) =>
                                                    controller.updateChoices(
                                                        index: idx, value: 1),
                                                dense: true,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                              ),
                                              Divider(),
                                            ],
                                          ))
                                      .toList(),
                                )),
                            Row(
                              children: [
                                ButtonWidget(
                                    title: "Submit",
                                    icon: Icons.done,
                                    active: false,
                                    onTap: () {
                                      debugPrint(controller.choices.toString());
                                      if (controller.allSelected) {
                                        controller.box.write("choices",
                                            controller.choices.toString());
                                        Get.back();
                                      } else {
                                        Toastr.show(
                                            message:
                                                "Please select an option from all questions.");
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ]),
                        ),
                      ));
        });
  }
}
