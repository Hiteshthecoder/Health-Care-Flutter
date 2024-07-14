import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_mvc/app/shared/views/widgets/Widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../controllers/ShareController.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ShareController(),
        builder: (ShareController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingIconWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Share",
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
                                          "Share your medical details by just showing your QR code with your doctor using HealthDetails.",
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
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Column(
                            children: [
                              Screenshot(
                                controller: controller.screenshotController,
                                child: Container(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Container(
                                        width: screen.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kcDarkAlt.withOpacity(0.3),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kcWhite,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: spacer13,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${auth.user.name}",
                                                  style: TextStyl.subtitle
                                                      ?.copyWith(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: spacer1,
                                                ),
                                                if (auth.user.isVerified != '0')
                                                  SvgPicture.asset(
                                                    'assets/icons/user_verify.svg',
                                                    color: kcPrimary,
                                                    width: 15,
                                                  )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "HDUID:",
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  width: spacer1,
                                                ),
                                                Text(
                                                  "#${auth.user.id}",
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: spacer2,
                                            ),
                                            Obx(
                                              () => QrImageView(
                                                data: controller.qrcode,
                                                version: QrVersions.auto,
                                                size: 270,
                                                gapless: true,
                                                padding: EdgeInsets.all(25),
                                              ),
                                            ),
                                            SizedBox(
                                              height: spacer5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                "I use DQ Care to organize the medical history of my family and myself. By downloading the DQ Care for Doctors App, you will be able to access them.",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kcDarkAlt),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Link: ",
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: kcDarkAlt),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      try {
                                                        await launchUrl(
                                                            Uri.parse(
                                                          "https://DQcare.in",
                                                        ));
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    },
                                                    child: Text(
                                                      "https://DQcare.in",
                                                      style: TextStyl.bodySm
                                                          ?.copyWith(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.blue),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Text(
                                                "Scan valid for 10 minutes.",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: kcDarkAlt),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: spacer2,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 55),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.shareQRProgress();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: kcPrimary,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.share,
                                                        size: 15,
                                                        color: kcDarkAlt,
                                                      ),
                                                      SizedBox(
                                                        width: spacer1,
                                                      ),
                                                      Text(
                                                        'Share my report with doctor',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(
                                                                color:
                                                                    kcDarkAlt,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: spacer2,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Text(
                                                "Powerded By DQ Care",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kcDarkAlt),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: spacer3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -50,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${auth.user.avatar}'),
                                          radius: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: spacer6,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/data-transfer.svg',
                                    color: kcBlack.withOpacity(0.5),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Share your Medical Records with your doctor.',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        });
  }
}
