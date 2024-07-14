import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/FollowupModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/FollowUpController.dart';

class FollowUpPage extends StatelessWidget {
  // final FollowUpController controller = Get.put(FollowUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FollowUpController(),
        builder: (FollowUpController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'Followups',
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
                                          "You can see your upcoming Follow ups scheduled by your doctor using DQ Care.",
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
                        onRefresh: () => controller.getFollowupData(),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(spacer2),
                            child: Obx(
                              () => controller.followupData.length <= 0
                                  ? Center(
                                      child: NoDataWidget(
                                        message: "No Followup found!",
                                        icon: SvgPicture.asset(
                                          'assets/images/calendar-clock.svg',
                                          width: spacer8,
                                          color: kcDarkAlt,
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...List.generate(
                                            controller.followupData.length,
                                            (index) {
                                              FollowupModel followup =
                                                  controller
                                                      .followupData[index];
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Get.toNamed(
                                                        '/doctorProfileDetail',
                                                        parameters: {
                                                          "id": followup
                                                              .doctorId
                                                              .toString()
                                                        }),
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.08),
                                                            width: 0.52),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      elevation: 0.5,
                                                      color: kcWhite,
                                                      margin: EdgeInsets.all(6),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // SvgPicture.asset(
                                                                //   'assets/icons/scale.svg',
                                                                //   color: kcDarkAlt,
                                                                //   height: 30,
                                                                //   width: 25,
                                                                // ),
                                                                // SizedBox(
                                                                //   width: spacer2,
                                                                // ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${followup.doctor?.salutation ?? ''} ${followup.doctor?.name ?? ''}',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kcPrimary,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    Text(
                                                                      '${Jiffy(followup.date).format('dd MMM, yyyy')}',
                                                                      style: TextStyle(
                                                                          color: kcBlack.withOpacity(
                                                                              0.5),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              5),
                                                                  decoration: BoxDecoration(
                                                                      color: followup.status ==
                                                                              'Scheduled'
                                                                          ? kcWarning.withOpacity(
                                                                              0.08)
                                                                          : kcSuccess.withOpacity(
                                                                              0.08),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${followup.status}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: followup.status == 'Scheduled'
                                                                              ? kcWarning.withOpacity(0.6)
                                                                              : kcSuccess.withOpacity(0.75),
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
        });
  }
}
