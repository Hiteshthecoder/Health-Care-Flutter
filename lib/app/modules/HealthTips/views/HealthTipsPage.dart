import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/HealthTipsIndexModel.dart';
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
import '../controllers/HealthTipsController.dart';

class HealthTipsPage extends StatelessWidget {
  const HealthTipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HealthTipsController(),
        builder: (HealthTipsController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Health Tips",
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
                                          "Read various health related tips here.",
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
                      body: RefreshIndicator(
                        // onRefresh: () =>
                        // controller.getHealthTipsData(immediate: true),
                        onRefresh: () =>
                            Future.delayed(const Duration(seconds: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => controller.health.length <= 0
                                      ? Center(
                                          child: NoDataWidget(
                                            message: "No HealthTips found!",
                                            icon: SvgPicture.asset(
                                              'assets/icons/dark-hand-holding-heart.svg',
                                              width: spacer8,
                                              color: kcDarkAlt,
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          controller:
                                              controller.scrollController,
                                          child: Column(
                                            children: [
                                              // ...List.generate(
                                              //   controller.health.length,
                                              //   (index) {
                                              //     HealthTipsIndexModel
                                              //         healthTip =
                                              //         controller.health[index];
                                              //     return Padding(
                                              //       padding: const EdgeInsets
                                              //           .symmetric(
                                              //           horizontal: 2,
                                              //           vertical: 8),
                                              //       child: Column(
                                              //         children: [
                                              //           GestureDetector(
                                              //             onTap: () {
                                              //               Get.toNamed(
                                              //                   '/blogsHealthTips',
                                              //                   parameters: {
                                              //                     "healthTip_id":
                                              //                         healthTip
                                              //                             .id
                                              //                             .toString()
                                              //                   });
                                              //             },
                                              //             child: Container(
                                              //               padding:
                                              //                   EdgeInsets.all(
                                              //                       13),
                                              //               width: screen.width,
                                              //               decoration:
                                              //                   BoxDecoration(
                                              //                 // border: Border.all(
                                              //                 //   width: 1.0,
                                              //                 //   color: kcOrange.withOpacity(0.5),
                                              //                 // ),
                                              //                 borderRadius:
                                              //                     BorderRadius.all(
                                              //                         Radius.circular(
                                              //                             8.0) //                 <--- border radius here
                                              //                         ),
                                              //                 boxShadow: [
                                              //                   BoxShadow(
                                              //                     color: Colors
                                              //                         .grey
                                              //                         .withOpacity(
                                              //                             0.5),
                                              //                     blurRadius:
                                              //                         2.0,
                                              //                   ),
                                              //                 ],
                                              //                 color: kcWhite,
                                              //               ),
                                              //               child: Column(
                                              //                 crossAxisAlignment:
                                              //                     CrossAxisAlignment
                                              //                         .start,
                                              //                 children: [
                                              //                   Row(
                                              //                     children: [
                                              //                       // Container(
                                              //                       //   width: 18,
                                              //                       //   height: 18,
                                              //                       //   child: healthTip.category?.icon != null ? Image.network(
                                              //                       //     '${healthTip.category?.icon}',
                                              //                       //     width: screen.width * 0.08,
                                              //                       //   ) : Text('')
                                              //                       // ),
                                              //                       // SizedBox(
                                              //                       //   width: spacer3,
                                              //                       // ),
                                              //                       Text(
                                              //                         "${healthTip.category?.name}", //name
                                              //                         style: TextStyl.body?.copyWith(
                                              //                             fontWeight: FontWeight
                                              //                                 .bold,
                                              //                             color:
                                              //                                 kcBlack.withOpacity(0.7)),
                                              //                       ),
                                              //                       Spacer(),
                                              //                       Text(
                                              //                         '${Jiffy(healthTip.createdAt).format('MMMM do yy, h:mm')}',
                                              //                         style: TextStyl.body?.copyWith(
                                              //                             fontWeight: FontWeight
                                              //                                 .w500,
                                              //                             fontSize:
                                              //                                 13,
                                              //                             color:
                                              //                                 kcDarkAlt),
                                              //                       ),
                                              //                     ],
                                              //                   ),
                                              //                   SizedBox(
                                              //                     height:
                                              //                         spacer4,
                                              //                   ),
                                              //                   ClipRRect(
                                              //                       // borderRadius: BorderRadius.circular(10),
                                              //                       // "${report.file?.split('/').last}",
                                              //                       child: Image
                                              //                           .network(
                                              //                     '${healthTip.descriptionBanner}',
                                              //                     //fit: BoxFit.fill,
                                              //                     width: screen
                                              //                         .width,
                                              //                     height: screen
                                              //                             .height *
                                              //                         0.25,
                                              //                   )),
                                              //                   SizedBox(
                                              //                     height:
                                              //                         spacer4,
                                              //                   ),
                                              //                   Text(
                                              //                     "${healthTip.title}",
                                              //                     style: TextStyl
                                              //                         .subtitle
                                              //                         ?.copyWith(
                                              //                       fontWeight:
                                              //                           FontWeight
                                              //                               .bold,
                                              //                       fontSize:
                                              //                           18,
                                              //                       color: kcBlack
                                              //                           .withOpacity(
                                              //                               0.7),
                                              //                     ),
                                              //                   ),
                                              //                   SizedBox(
                                              //                     height:
                                              //                         spacer1,
                                              //                   ),
                                              //                   Text(
                                              //                     "${(healthTip.description)?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '')}", //subtitle
                                              //                     style: TextStyl
                                              //                         .bodySm
                                              //                         ?.copyWith(
                                              //                             fontSize:
                                              //                                 15,
                                              //                             color:
                                              //                                 kcDarkAlt),
                                              //                     maxLines: 4,
                                              //                     overflow:
                                              //                         TextOverflow
                                              //                             .ellipsis,
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     );
                                              //   },
                                              // ),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        alignment: Alignment.center,
                                        child: LoadingIcon(),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        });
  }
}
