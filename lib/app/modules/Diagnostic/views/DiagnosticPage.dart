import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/DiagnosticModel.dart';
import 'package:flutter_mvc/app/modules/Diagnostic/controllers/DiagnosticController.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import 'widgets/DiagnosticFilterWidget.dart';

class DiagnosticPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DiagnosticController(),
        builder: (DiagnosticController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'Diagnostic',
                      titleSpacing: 0,
                      actions: [
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                ),
                                builder: (builder) {
                                  return Container(
                                    height: Get.size.height * 0.60,
                                    child: DiagnosticFilterWidget(controller: controller),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.filter_list_sharp,
                              size: 23,
                            )),
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
                      body: Padding(
                        padding: const EdgeInsets.all(spacer2),
                        child: Column(
                              children: [
                                Expanded(
                                  child: Obx(
                                        () => controller.diagnosticData.length <= 0
                                        ? Center(
                                      child: NoDataWidget(
                                        message: "The diagnostic center is currently not available due to work on it.",
                                        icon: SvgPicture.asset(
                                          'assets/images/calendar-clock.svg',
                                          width: spacer8,
                                          color: kcDarkAlt,
                                        ),
                                      ),
                                    )
                                        : SingleChildScrollView(
                                          controller:  controller.scrollController,
                                      child: Column(
                                        children: [
                                          ...List.generate(controller.diagnosticData.length, (index) {
                                            DiagnosticModel diagnostic = controller.diagnosticData[index];
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(color: kcBlack.withOpacity(0.1), width: 0.52),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    elevation: 0.55,
                                                    margin: EdgeInsets.all(5),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/icons/building.svg',
                                                                color: kcDarkAlt,
                                                                height: 20,width: 20,
                                                              ),
                                                              SizedBox(
                                                                width: spacer2,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 220,
                                                                    child: Text(
                                                                      "${diagnostic.name}",
                                                                      style: TextStyle(color: kcBlack, fontSize: 16),
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                                                child: GestureDetector(
                                                                    onTap: () {
                                                                      launch('tel:${diagnostic.mobileNo}');
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                      'assets/icons/phone-call.svg',
                                                                      color: kcdblue.withOpacity(0.75),
                                                                      width: 22,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric( horizontal: 25),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 275,
                                                                  child: Text(
                                                                    "${diagnostic.addressline1}",
                                                                    style: TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 14),
                                                                    // overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${diagnostic.state?.name}, ${diagnostic.city?.name}",
                                                                  style: TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 14),
                                                                  // overflow: TextOverflow.ellipsis,
                                                                ),
                                                                Text(
                                                                  "${diagnostic.country?.name}, ${diagnostic.pincode} ",
                                                                  style: TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 14),
                                                                  //overflow: TextOverflow.ellipsis,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                      () => controller.loadingMore
                                      ? Container(
                                    decoration: BoxDecoration(
                                      color: kcWhite,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    alignment: Alignment.center,
                                    child: LoadingIcon(),
                                  )
                                      : SizedBox.shrink(),
                                ),
                              ],
                            )

                      ),
                    );
        });
  }
}
