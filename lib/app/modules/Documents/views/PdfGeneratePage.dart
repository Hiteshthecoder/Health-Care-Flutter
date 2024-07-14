import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NotificationServices.dart';
import '../controllers/PdfGenerateController.dart';

final NotificationServices notificationServices =
    Get.put(NotificationServices());

class PdfGeneratePage extends StatelessWidget {
  const PdfGeneratePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PdfGenerateController(),
        builder: (PdfGenerateController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "HD PDF Builder ",
                      actions: [],
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
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          Dialog(
                                            backgroundColor:
                                                kcWhite.withOpacity(0.6),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.transparent,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () => controller
                                                              .captureImage(),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        18),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            width: screen.width,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .camera_alt_outlined,
                                                                  size: 36,
                                                                  color:
                                                                      kcWhite,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  "Take Picture",
                                                                  style: TextStyl.bodySm?.copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          kcWhite,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              controller
                                                                  .getImage(),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        18),
                                                            width: screen.width,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcDanger
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .image_outlined,
                                                                  size: 36,
                                                                  color:
                                                                      kcWhite,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  "Choose Picture",
                                                                  style: TextStyl.bodySm?.copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          kcWhite,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                      child: Container(
                                        width: screen.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: kcLightGray
                                            // color: kcLightGray.withOpacity(0.35),
                                            ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/gallery.png',
                                              width: 65,
                                            ),
                                            SizedBox(height: 12),
                                            // Text("Add Image", style: TextStyl.bodySm,),
                                            // SizedBox(height: spacer1),
                                            Obx(
                                              () => Text(
                                                controller.selectedImages
                                                            .length >
                                                        0
                                                    ? "${controller.selectedImages.length} Files Selected"
                                                    : "Choose Files",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: kcDarkAlt,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    flex: 1,
                                                    child: Text(
                                                      "Select multiple images & download a PDF",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: kcBlack,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        "To download your report, Attach all pages pictures and click on Save PDF.",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: kcDarkAlt,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Obx(
                                      () => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: spacer5),
                                          child: controller
                                                      .selectedImages.length >
                                                  0
                                              ? Column(
                                                  children: [
                                                    ...List.generate(
                                                        controller
                                                            .selectedImages
                                                            .length, (index) {
                                                      File file = controller
                                                              .selectedImages[
                                                          index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 8),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${index + 1}.',
                                                            ),
                                                            SizedBox(
                                                              width: spacer,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '${file.path.split('/').last}',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 12),
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .deleteFile(
                                                                          index),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/icons/trash.svg',
                                                                color:
                                                                    kcPrimaryLight,
                                                                width: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                    Divider(),
                                                    SizedBox(
                                                      height: spacer4,
                                                    ),
                                                    controller.selectedImages
                                                                .length >
                                                            0
                                                        ? GestureDetector(
                                                            onTap: () => controller
                                                                .clearImages(),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color:
                                                                    kcOffWhite,
                                                              ),
                                                              child: Text(
                                                                'Remove all selected files',
                                                                style: TextStyl
                                                                    .bodySm
                                                                    ?.copyWith(
                                                                        color:
                                                                            kcBlack),
                                                              ),
                                                            ),
                                                          )
                                                        : Text(''),
                                                    SizedBox(
                                                      height: spacer,
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 150,
                                                    ),
                                                    Text(
                                                      "No File Selected ",
                                                      style: TextStyle(
                                                          color: kcBlack),
                                                    ),
                                                  ],
                                                )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Button.block(
                            key: UniqueKey(),
                            label: "Save PDF",
                            leading: SvgPicture.asset(
                              'assets/icons/download.svg',
                              color: kcWhite,
                              height: 18,
                              width: 18,
                            ),
                            flat: true,
                            onTap: (btn) async {
                              btn.setBusy(true).setDisabled(true);
                              controller.savePDF();
                              notificationServices.sendNotification(
                                  "DQ Care", "PDF Downloaded Successfully");
                              btn.setBusy(false).setDisabled(false);
                            },
                          ),
                        ],
                      ),
                    );
        });
  }
}
