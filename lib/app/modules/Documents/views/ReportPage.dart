import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/ReportModel.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/ReportController.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ReportController(),
        builder: (ReportController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "My Documents",
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
                                          "Once you finish upload, you can see all your documents arranged in a well organised manner here. Once you click on Organise My reports, your request will go for approval.",
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
                        onRefresh: () => controller.getReportData(),
                        child: Obx(
                          () => controller.reportData.length <= 0 ||
                                  controller.reportData.where((element) => element.patientFiles!.length > 0).length <= 0
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: spacer2),
                                    child: NoDataWidget(
                                      message: "No Document Uploaded Yet!\nUpload your medical document to request story creation",
                                      icon: SvgPicture.asset(
                                        'assets/icons/inbox.svg',
                                        width: spacer8,
                                        color: kcDarkAlt,
                                      ),
                                      action: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/upload");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: kcPrimary,
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 13),
                                            width: screen.width * 0.52,
                                            height: screen.height * 0.06,
                                            child: Text(
                                              "Start Uploading",
                                              style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                                      color: kcWarning.withOpacity(0.2),
                                      width: screen.width,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Last Update - ${Jiffy(controller.report.updatedAt).format('dd MMM, yyyy')}',
                                            style: TextStyl.bodySm?.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(controller.reportData.length, (index) {
                                                ReportModel category = controller.reportData[index];
                                                return category.patientFiles!.length <= 0
                                                    ? SizedBox.shrink()
                                                    : Container(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "${category.name}",
                                                              style: TextStyl.body?.copyWith(
                                                                  color: kcBlack.withOpacity(0.7), fontSize: 18, fontWeight: FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: spacer1,
                                                            ),
                                                            ...List.generate(
                                                              category.patientFiles!.length,
                                                              (index) {
                                                                PatientFile file = category.patientFiles![index];
                                                                return Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 4),
                                                                            child: SvgPicture.asset(
                                                                              'assets/icons/document-signed.svg',
                                                                              color: kcInfo,
                                                                              width: 25,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 15,
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                file.title == null ? 'HDPFID${file.id}' : '${file.title}',
                                                                                style: TextStyle(color: kcDarkAlt, fontSize: 12),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Text(
                                                                                file.date == null
                                                                                    ? '----'
                                                                                    : '${Jiffy(file.date).format("dd MMM, yyyy")}',
                                                                                style: TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 10),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Spacer(),
                                                                          if (file.date != null)
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 1),
                                                                              child: Text(
                                                                                '+1SP',
                                                                                style: TextStyl.bodySm
                                                                                    ?.copyWith(color: kcWarning, fontWeight: FontWeight.w800),
                                                                              ),
                                                                            ),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          GestureDetector(
                                                                            // onTap: () {
                                                                            //   Get.dialog(
                                                                            //     Dialog(
                                                                            //       child: Image.network("${file.file}"),
                                                                            //     ),
                                                                            //   );
                                                                            // },
                                                                            onTap: () => controller.launchUrlStart(url: "${file.file}"),
                                                                            child: SvgPicture.asset(
                                                                              'assets/icons/eye.svg',
                                                                              color: kcGreen,
                                                                              width: 20,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    !auth.user.subscription!.isExpired()
                                        ? Column(
                                            children: [
                                              Obx(
                                                () => Container(
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: controller.isChecked,
                                                        onChanged: (value) {
                                                          controller.isCheck = value ?? true;
                                                        },
                                                      ),
                                                      Flexible(
                                                          child: GestureDetector(
                                                        onTap: () => controller.tapChecked(),
                                                        child: Text(
                                                          "To create a medical story, I checked, acknowledged and\nuploaded all my relevant documents.",
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              controller.isChecked == true && !auth.user.subscription!.isExpired()
                                                  ? Button.block(
                                                      key: UniqueKey(),
                                                      onTap: (_) async {
                                                        //log.w(userController.subscribe.isExpired());
                                                        if (userController.subscribe.isExpired()) {
                                                          Toastr.show(message: 'Your package is expired, please renew to request organise my report');
                                                        } else {
                                                          await controller.organiseReport(authId: int.parse(auth.user.id.toString()));
                                                        }
                                                      },
                                                      flat: true,
                                                      label: "Organise My Report")
                                                  : Button.light(key: UniqueKey(), block: true, label: "Organise My Report")
                                            ],
                                          )
                                        : InkWell(
                                            onTap: () => Get.toNamed('/buyPlan'),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/info.svg',
                                                        width: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'By purchasing a subscription, you can unlock the option to organise my report.',
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: screen.height * 0.055,
                                                  width: screen.width,
                                                  decoration: BoxDecoration(color: kcGreen),
                                                  child: Center(
                                                    child: Text(
                                                      'Take Subscription',
                                                      style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                      ),
                    );
        });
  }
}
