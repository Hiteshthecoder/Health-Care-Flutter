import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/RespectModel.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/RespectCommunityController.dart';

class RespectsCommunity extends StatelessWidget {
  const RespectsCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RespectCommunityController(),
        builder: (RespectCommunityController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: "Respects",
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
                              //         title: 'Title here',
                              //         description:
                              //             "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients.",
                              //       ),
                              //     );
                              //   },
                              //   child: SvgPicture.asset(
                              //     'assets/icons/contact.svg',
                              //     color: kcWhite,
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
                      body: Obx(
                        () => controller.respectData.length <= 0
                            ? Center(
                                child: NoDataWidget(
                                  message: "No Respect Yet!",
                                  icon: SvgPicture.asset(
                                    'assets/icons/social-network.svg',
                                    width: spacer8,
                                    color: kcDarkAlt,
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        controller.respectData.length,
                                        (index) {
                                          RespectModel like = controller.respectData[index];
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                            margin: EdgeInsets.symmetric(vertical: 5),
                                            color: kcWhite,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage('${like.user?.avatar}'),
                                                  radius: 20,
                                                ),
                                                SizedBox(
                                                  width: spacer3,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${like.user?.name}",
                                                      style: TextStyl.body
                                                          ?.copyWith(fontWeight: FontWeight.bold, color: kcBlack.withOpacity(0.7)),
                                                    ),
                                                    Text(
                                                      '${Jiffy(like.createdAt).format("yyyy-MM-dd , hh:mm")}',
                                                      style: TextStyl.body
                                                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13, color: kcDarkAlt),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SvgPicture.asset(
                                                  'assets/icons/thumbs-up.svg',
                                                  width: 15,
                                                  color: kcPrimary,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    );
        });
  }
}
