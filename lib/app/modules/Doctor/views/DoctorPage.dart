import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/modules/Doctor/controllers/DoctorController.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/UserModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import 'widgets/DoctorFilterPage.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DoctorController(),
        builder: (DoctorController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'Doctor',
                      actions: [
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0)),
                                  ),
                                  builder: (builder) {
                                    {
                                      return Container(
                                          color: Colors.white,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.60,
                                          child: DoctorFilterPage(
                                              controller: controller));
                                    }
                                  });
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
                                      description:
                                          "See all the doctors available at DQ Care.",
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
                      body: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(spacer2),
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => controller.doctorData.length <= 0
                                      ? Center(
                                          child: NoDataWidget(
                                            message: "No Doctor found!",
                                            icon: SvgPicture.asset(
                                              'assets/icons/doctordark.svg',
                                              width: spacer8,
                                              color: kcDarkAlt,
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          controller:
                                              controller.scrollController,
                                          child: Column(
                                            children: [
                                              ...List.generate(
                                                controller.doctorData.length,
                                                (index) {
                                                  UserModel doctor = controller
                                                      .doctorData[index];
                                                  {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        controller.primaryDoctor
                                                                    .doctorId ==
                                                                '${doctor.id}'
                                                            ? GestureDetector(
                                                                onTap: () =>
                                                                    Get.toNamed(
                                                                        '/doctorProfileDetail',
                                                                        parameters: {
                                                                      "id": doctor
                                                                          .id
                                                                          .toString()
                                                                    }),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        kcSkyBlue,
                                                                    border: Border.all(
                                                                        color: kcBlack.withOpacity(
                                                                            0.1),
                                                                        width:
                                                                            0.52),
                                                                  ),
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  width: screen
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage('${doctor.avatar}'),
                                                                        radius:
                                                                            15,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            spacer2,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${doctor.salutation ?? "Dr."} ${doctor.name}",
                                                                            style:
                                                                                TextStyle(color: kcBlack, fontSize: 15),
                                                                          ),
                                                                          Text(
                                                                            "${doctor.address ?? "Address"}",
                                                                            style:
                                                                                TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 14),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_forward_ios_rounded,
                                                                        size:
                                                                            20,
                                                                        color: kcPrimary
                                                                            .withOpacity(0.75),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () =>
                                                                    Get.toNamed(
                                                                        '/doctorProfileDetail',
                                                                        parameters: {
                                                                      "id": doctor
                                                                          .id
                                                                          .toString()
                                                                    }),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        kcWhite,
                                                                    border: Border.all(
                                                                        color: kcBlack.withOpacity(
                                                                            0.1),
                                                                        width:
                                                                            0.52),
                                                                  ),
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  width: screen
                                                                      .width,
                                                                  child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage('${doctor.avatar}'),
                                                                        radius:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            spacer2,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                220,
                                                                            child:
                                                                                Text(
                                                                              "${doctor.salutation ?? ""} ${doctor.name}",
                                                                              style: TextStyl.bodySm?.copyWith(color: kcPrimary.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w600),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                220,
                                                                            child:
                                                                                Text(
                                                                              "${doctor.address ?? "Address"}",
                                                                              style: TextStyl.bodySm?.copyWith(color: kcDarkAlt.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.w600),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_forward_ios_rounded,
                                                                        size:
                                                                            20,
                                                                        color: kcBlack
                                                                            .withOpacity(0.75),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
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
