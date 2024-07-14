import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';
import '../controllers/UploadReportController.dart';

class UploadReportPage extends StatelessWidget {
  const UploadReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UploadReportController(),
        builder: (UploadReportController controller) {
          if (!controller.isConnected) {
            return NotConnectedErrorPage();
          } else {
            return controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: "Upload Documents",
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: spacer4,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.dialog(
                            //       HelperWidget(
                            //         description:
                            //             "Here, you can upload your documents by selecting their report category. You can use doc builder for generating PDF of your documents.",
                            //       ),
                            //     );
                            //   },
                            //   child: SvgPicture.asset(
                            //     'assets/icons/contact.svg',
                            //     height: 20,
                            //     width: 20,
                            //   ),
                            // ),
                            SizedBox(
                              width: spacer1,
                            ),
                          ],
                        ),
                      ),
                    ],
                    titleSpacing: 0,
                    backgroundColor: kcWhite,
                    body: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              controller.clearImages();
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: spacer5, vertical: spacer3),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/help.png',
                                          width: 20,
                                          color: kcBlack.withOpacity(0.6),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                            child: Text(
                                          'Select files in the following formats: PNG, JPEG, JPG, PDF, DOCX. Make sure they are at least 10MB in size.',
                                          style: TextStyle(fontSize: 13),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => controller.hide
                                        ? Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.dialog(
                                                    Dialog(
                                                      backgroundColor: kcWhite.withOpacity(0.6),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: Colors.transparent,
                                                        ),
                                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Expanded(
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      controller.captureImage();
                                                                    },
                                                                    child: Container(
                                                                      padding: EdgeInsets.symmetric(vertical: 18),
                                                                      decoration: BoxDecoration(
                                                                        color: kcPrimary.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                      width: screen.width,
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.camera_alt_outlined,
                                                                            size: 36,
                                                                            color: kcWhite,
                                                                          ),
                                                                          const SizedBox(height: 4),
                                                                          Text(
                                                                            "Take Picture",
                                                                            style: TextStyl.bodySm
                                                                                ?.copyWith(fontSize: 15, color: kcWhite, fontWeight: FontWeight.w600),
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 8),
                                                                Expanded(
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      Get.back();
                                                                      controller.getImage();
                                                                    },
                                                                    child: Container(
                                                                      padding: EdgeInsets.symmetric(vertical: 18),
                                                                      width: screen.width,
                                                                      decoration: BoxDecoration(
                                                                        color: kcDanger.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.image_outlined,
                                                                            size: 36,
                                                                            color: kcWhite,
                                                                          ),
                                                                          const SizedBox(height: 4),
                                                                          Text(
                                                                            "Choose Picture",
                                                                            style: TextStyl.bodySm
                                                                                ?.copyWith(fontSize: 15, color: kcWhite, fontWeight: FontWeight.w600),
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                                                      child: Row(
                                                        children: [
                                                          controller.tabIndex == 0
                                                              ? Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        'assets/icons/data-storage.png',
                                                                        width: 20,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text(
                                                                        'Document',
                                                                        style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : controller.tabIndex == 1
                                                                  ? Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                      decoration:
                                                                          BoxDecoration(borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                      child: Row(
                                                                        children: [
                                                                          Image.asset(
                                                                            'assets/icons/blood-analysis.png',
                                                                            width: 20,
                                                                          ),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(
                                                                            'Blood',
                                                                            style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : controller.tabIndex == 2
                                                                      ? Container(
                                                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                          decoration:
                                                                              BoxDecoration(borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                          child: Row(
                                                                            children: [
                                                                              Image.asset(
                                                                                'assets/icons/ecg.png',
                                                                                width: 20,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                'ECG',
                                                                                style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : controller.tabIndex == 3
                                                                          ? Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                              child: Row(
                                                                                children: [
                                                                                  Image.asset(
                                                                                    'assets/icons/x-ray.png',
                                                                                    width: 20,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    'Radiology',
                                                                                    style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : controller.tabIndex == 4
                                                                              ? Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        'assets/images/health-insurance.png',
                                                                                        width: 20,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        'Health Insurance',
                                                                                        style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5), color: kcPrimary),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        'assets/images/other_report.png',
                                                                                        width: 20,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        'Others',
                                                                                        style: TextStyl.bodySm?.copyWith(color: kcWhite),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.onShowCategory(false);
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/icons/cross.svg',
                                                              width: 18,
                                                              color: kcDanger,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: screen.width,
                                                      height: screen.height * 0.25,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        color: kcLightGray.withOpacity(0.35),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                            'assets/icons/uploadDoc.png',
                                                            width: 85,
                                                          ),
                                                          SizedBox(
                                                            height: spacer1,
                                                          ),
                                                          Text(
                                                            controller.selectedImages.length > 0
                                                                ? "${controller.selectedImages.length} Files Selected"
                                                                : "Choose Files",
                                                            style: TextStyl.bodySm?.copyWith(fontSize: 13, color: kcBlack.withOpacity(0.6)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: spacer5),
                                                child: Column(
                                                  children: [
                                                    ...List.generate(controller.selectedImages.length, (index) {
                                                      File file = controller.selectedImages[index];
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${index + 1}.',
                                                            ),
                                                            SizedBox(
                                                              width: spacer1,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.allowAccess(
                                                                  file.path
                                                                      .split(
                                                                        '.',
                                                                      )
                                                                      .last,
                                                                );
                                                                if (file.path
                                                                        .split(
                                                                          '.',
                                                                        )
                                                                        .last !=
                                                                    'pdf') {
                                                                  Get.dialog(Dialog(
                                                                      child: Image.file(
                                                                    file,
                                                                    width: 45,
                                                                  )));
                                                                } else if (file.path
                                                                        .split(
                                                                          '.',
                                                                        )
                                                                        .last ==
                                                                    'pdf') {
                                                                  var snackBar = SnackBar(
                                                                      backgroundColor: kcDanger,
                                                                      content: Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(
                                                                            topRight: Radius.circular(15),
                                                                            topLeft: Radius.circular(15),
                                                                          )),
                                                                          height: 28,
                                                                          width: screen.width,
                                                                          child: Text(
                                                                            'There are only images available for viewing',
                                                                            textAlign: TextAlign.start,
                                                                            style: TextStyl.bodySm?.copyWith(fontSize: 16, color: kcWhite),
                                                                          )));
                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                }
                                                              },
                                                              child: Container(
                                                                width: screen.width * 0.4,
                                                                child: Text(
                                                                  '${file.path.split(
                                                                        '/',
                                                                      ).last}',
                                                                  // overflow: TextOverflow.ellipsis,
                                                                  // maxLines: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () => controller.showImage(),
                                                            //   child: SvgPicture.asset(
                                                            //     'assets/icons/eye.svg',
                                                            //     color: kcGreen,
                                                            //     width: 20,
                                                            //   ),
                                                            // ),

                                                            Spacer(),
                                                            GestureDetector(
                                                              onTap: () => controller.deleteFile(index),
                                                              child: SvgPicture.asset(
                                                                'assets/icons/trash.svg',
                                                                color: kcPrimaryLight,
                                                                width: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                    SizedBox(
                                                      height: spacer12,
                                                    ),
                                                    if (controller.selectedImages.length > 0)
                                                      GestureDetector(
                                                        onTap: () => controller.clearImages(),
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: kcOffWhite,
                                                          ),
                                                          child: Text(
                                                            'Remove all selected files',
                                                            style: TextStyl.bodySm?.copyWith(color: kcBlack),
                                                          ),
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: spacer,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: screen.width,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: kcWarning.withOpacity(0.06)),
                                                child: Text(
                                                  'Select Category',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyl.bodySm?.copyWith(color: kcWarning.withOpacity(0.75), fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(
                                                height: spacer,
                                              ),
                                              Obx(
                                                () => Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                                  child: Wrap(
                                                    spacing: 8,
                                                    runSpacing: 20,
                                                    alignment: WrapAlignment.start,
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: [
                                                      TabPillWidget(
                                                        image: Image.asset('assets/icons/data-storage.png'),
                                                        label: "Document",
                                                        onTap: () {
                                                          controller.tapSelect(0);
                                                        },
                                                        active: controller.tabIndex == 0,
                                                        // activeColor: kcOffWhite,
                                                      ),
                                                      TabPillWidget(
                                                        image: Image.asset('assets/icons/blood-analysis.png'),
                                                        label: "Blood",
                                                        onTap: () {
                                                          controller.tapSelect(1);
                                                        },
                                                        active: controller.tabIndex == 1,
                                                        //activeColor: kcWarning.withOpacity(0.1),
                                                      ),
                                                      TabPillWidget(
                                                        image: Image.asset('assets/icons/ecg.png'),
                                                        label: "ECG",
                                                        onTap: () {
                                                          controller.tapSelect(2);
                                                        },
                                                        active: controller.tabIndex == 2,
                                                        //activeColor: kcWarning.withOpacity(0.1),
                                                      ),
                                                      TabPillWidget(
                                                        image: Image.asset('assets/icons/x-ray.png'),
                                                        label: "Radiology",
                                                        onTap: () {
                                                          controller.tapSelect(3);
                                                        },
                                                        active: controller.tabIndex == 3,
                                                        //activeColor: kcWarning.withOpacity(0.1),
                                                      ),
                                                      TabPillWidget(
                                                        image: Image.asset('assets/images/health-insurance.png'),
                                                        label: "Health Insurance",
                                                        onTap: () {
                                                          controller.tapSelect(4);
                                                        },
                                                        active: controller.tabIndex == 4,
                                                        // activeColor: kcWarning.withOpacity(0.1),
                                                      ),
                                                      TabPillWidget(
                                                        image: Image.asset('assets/images/other_report.png'),
                                                        label: "Others",
                                                        onTap: () {
                                                          controller.tapSelect(5);
                                                        },
                                                        active: controller.tabIndex == 5,
                                                        // activeColor: kcWarning.withOpacity(0.1),
                                                      ),
                                                    ],
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
                        ),
                        // GestureDetector(
                        //   onTap: () => Get.toNamed('/pdfGenerate'),
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(vertical: 10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: kcGreen,
                        //     ),
                        //     width: screen.width * 0.5,
                        //     height: screen.height * 0.05,
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SvgPicture.asset(
                        //           'assets/icons/pdf.svg',
                        //           color: kcWhite,
                        //         ),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         Text(
                        //           "Use Doc Builder",
                        //           style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: spacer,
                        // ),
                        Button.block(
                          key: UniqueKey(),
                          label: "Start Secure Upload",
                          leading: SvgPicture.asset(
                            'assets/icons/arrow-small-up.svg',
                            color: kcWhite,
                            height: 18,
                            width: 18,
                          ),
                          flat: true,
                          onTap: (btn) async {
                            if (controller.selectedImages.length > 0) btn.setBusy(true).setDisabled(true);
                            await controller.documentUpload();
                            btn.setBusy(false).setDisabled(false);
                          },
                        ),
                      ],
                    ),
                  );
          }
        });
  }
}
