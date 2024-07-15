import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_x/ui_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/SliderModel.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/HomeController.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        return controller.isBusy
            ? LoadingWidget()
            : MasterLayout(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: spacer10,
                      ),
                      SizedBox(
                        width: spacer2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: spacer2,
                          ),
                          Text(
                            'Welcome,',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: kcBlack),
                          ),
                          Obx(
                            () => Column(
                              children: [
                                Text(
                                  "${auth.user.name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: kcBlack),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                leadingWidth: 50,
                actions: [
                  InkWell(
                    onTap: () => Get.toNamed("/share"),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                        // color: kcPrimary.withOpacity(0.08),
                        color: kcPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: kcLightGray,
                        highlightColor: kcPrimary,
                        child: Row(
                          children: [
                            // SvgPicture.asset("assets/icons/data-transfer.svg",
                            //     color: kcWhite, width: 21),
                            FaIcon(
                              FontAwesomeIcons.qrcode,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "My QR",
                              style: TextStyl.bodySm?.copyWith(
                                  color: kcWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   child: Obx(
                        //     () => controller.sliderOne.length <= 0
                        //         ? SizedBox.shrink()
                        //         : ImageSlideshow(
                        //             width: screen.width,
                        //             height: 180,
                        //             initialPage: 0,
                        //             indicatorRadius: 2,
                        //             indicatorColor: kcPrimary,
                        //             indicatorBackgroundColor: kcPrimary,
                        //             autoPlayInterval: 5000,
                        //             isLoop: true,
                        //             children: [
                        //               ...List.generate(
                        //                   controller.sliderOne.length,
                        //                   (index) {
                        //                 SliderModel slider =
                        //                     controller.sliderOne[index];
                        //                 return ClipRRect(
                        //                   borderRadius:
                        //                       BorderRadius.circular(10),
                        //                   child: Image.network(
                        //                     '${slider.image ?? ''}',
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 );
                        //               })
                        //             ],
                        //           ),
                        //   ),
                        // ),
                        const SizedBox(height: 32),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quick Actions",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: spacer3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/report');
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: SvgPicture.asset(
                                                  //   'assets/icons/inbox.svg',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .fileWaveform,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text(
                                              "Document",
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: spacer4,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.toNamed('/insight'),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: SvgPicture.asset(
                                                  //   'assets/icons/stats.svg',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .chartSimple,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text("Insights"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.toNamed('/mySummary'),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: SvgPicture.asset(
                                                  //   'assets/icons/treatment.svg',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .fileMedical,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text("Summary"),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: spacer4,
                                      ),
                                      //////////////////////////
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/chart');
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: SvgPicture.asset(
                                                  //   'assets/icons/layers.svg',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .chartLine,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text("Reports"),
                                          ],
                                        ),
                                      ),
                                      //follo
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/myJourney');
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: SvgPicture.asset(
                                                  //   'assets/icons/notebook.svg',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.book,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text("Journey"),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: spacer4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/ePrescription');
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                color: kcPrimary.withOpacity(1),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  // child: Image.asset(
                                                  //   'assets/icons/prescription_icon.png',
                                                  //   color: kcPrimary,
                                                  // ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .filePrescription,
                                                      size: 28,
                                                      color: kcWhite,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: spacer1,
                                            ),
                                            Text("ePrescription"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: spacer4,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/followUp');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcPrimary.withOpacity(1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              // child: SvgPicture.asset(
                                              //   'assets/images/calendar-clock.svg',
                                              //   color: kcPrimary,
                                              // ),
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.calendarDay,
                                                  size: 28,
                                                  color: kcWhite,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: spacer1,
                                        ),
                                        Text("Followups"),
                                      ],
                                    ),
                                  ),
                                  // child: GestureDetector(
                                  //   onTap: () {
                                  //     Get.toNamed('/chart');
                                  //   },
                                  //   child: Column(
                                  //     children: [
                                  //       Container(
                                  //         height: 60,
                                  //         width: 75,
                                  //         decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(8.0),
                                  //           color: kcPrimary.withOpacity(1),
                                  //         ),
                                  //         child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(12.0),
                                  //             // child: SvgPicture.asset(
                                  //             //   'assets/icons/layers.svg',
                                  //             //   color: kcPrimary,
                                  //             // ),
                                  //             child: Center(
                                  //               child: FaIcon(
                                  //                 FontAwesomeIcons.chartLine,
                                  //                 size: 28,
                                  //                 color: kcWhite,
                                  //               ),
                                  //             )),
                                  //       ),
                                  //       SizedBox(
                                  //         height: spacer1,
                                  //       ),
                                  //       Text("Reports"),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/rewards');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcPrimary.withOpacity(1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              // child: SvgPicture.asset(
                                              //   'assets/icons/gift-card.svg',
                                              //   color: kcPrimary,
                                              // ),
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.gift,
                                                  size: 28,
                                                  color: kcWhite,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: spacer1,
                                        ),
                                        Text("Rewards"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/lifestylePlan');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcPrimary.withOpacity(1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              // child: SvgPicture.asset(
                                              //   'assets/icons/gift-card.svg',
                                              //   color: kcPrimary,
                                              // ),
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.notesMedical,
                                                  size: 28,
                                                  color: kcWhite,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: spacer1,
                                        ),
                                        Text("Lifestyle Plan"),
                                      ],
                                    ),
                                  ),
                                ),

                                //reportdata
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/chatbot');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: kcPrimary.withOpacity(1),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              // child: SvgPicture.asset(
                                              //   'assets/images/calendar-clock.svg',
                                              //   color: kcPrimary,
                                              // ),
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.robot,
                                                  size: 28,
                                                  color: kcWhite,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: spacer1,
                                        ),
                                        Text("ChatBot"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/aabha1');
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          color: kcPrimary.withOpacity(1),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            // child: SvgPicture.asset(
                                            //   'assets/images/calendar-clock.svg',
                                            //   color: kcPrimary,
                                            // ),
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.robot,
                                                size: 28,
                                                color: kcWhite,
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: spacer1,
                                      ),
                                      Text("Aabha"),
                                    ],
                                  ),
                                ))
                                //reportdata
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          width: screen.width,
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/community');
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                        fit: BoxFit.cover,
                                        'assets/images/dc-1-01.png'),
                                  ),
                                  // ),
                                ),
                              ),
                              // SizedBox(width: 8),
                              // Expanded(
                              //   child: GestureDetector(
                              //     onTap: () => Get.toNamed('/diagnostic'),
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.circular(8),
                              //       child: Image.asset(
                              //           'assets/images/dc-2-01.png'),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   child: Obx(
                        //     () => controller.sliderTwo.length <= 0
                        //         ? SizedBox.shrink()
                        //         : ImageSlideshow(
                        //             width: screen.width,
                        //             height: 150,
                        //             initialPage: 0,
                        //             indicatorRadius: 2,
                        //             indicatorColor: kcPrimary,
                        //             indicatorBackgroundColor: kcPrimary,
                        //             children: [
                        //               ...List.generate(
                        //                   controller.sliderTwo.length,
                        //                   (index) {
                        //                 SliderModel slider =
                        //                     controller.sliderTwo[index];
                        //                 return ClipRRect(
                        //                   borderRadius:
                        //                       BorderRadius.circular(10),
                        //                   child: Image.network(
                        //                     '${slider.image ?? ''}',
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 );
                        //               })
                        //             ],
                        //           ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
