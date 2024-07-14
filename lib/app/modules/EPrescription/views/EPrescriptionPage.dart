import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/EPrescriptionController.dart';

class EPrescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: EPrescriptionController(),
        builder: (EPrescriptionController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'ePrescription',
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
                                  // Get.dialog(
                                  //   HelperWidget(
                                  //     description: "You can see your upcoming Follow ups scheduled by your doctor using HealthDetails.",
                                  //   ),
                                  // );
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
                      body: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(spacer2),
                          child: controller.allPrescriptions.isEmpty
                              ? Center(
                                  child: NoDataWidget(
                                    message: "No data",
                                    icon: Image.asset(
                                      'assets/icons/prescription_icon.png',
                                      width: spacer8,
                                      color: kcDarkAlt,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.allPrescriptions.length,
                                  itemBuilder: (context, i) {
                                    final prescription =
                                        controller.allPrescriptions[i];
                                    return InkWell(
                                      onTap: () {
                                        controller.prescriptionDetails =
                                            controller.allPrescriptions[i];
                                        Get.toNamed("/ePrescriptionShow");
                                        // launch(
                                        //     "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        width: screen.width,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    kcDarkAlt.withOpacity(0.15),
                                                blurRadius: 10),
                                          ],
                                          color: kcWhite,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              height: 48,
                                              width: 45,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    "${prescription.doctor!.avatar ?? ""}",
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Dr. ${prescription.doctor!.firstName}  ${prescription.doctor!.lastName}",
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.75),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  Text(
                                                    "${Jiffy(prescription.updatedAt).format("dd MMM yyyy")}",
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                            color: kcBlack,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                              color: kcPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    );
        });
  }
}

class PrescriptionDecoration {
  static decoration() {
    return BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15));
  }
}
