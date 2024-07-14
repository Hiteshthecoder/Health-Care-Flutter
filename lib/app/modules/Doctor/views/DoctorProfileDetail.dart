import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/models/DoctorModel.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';
import '../../../shared/views/widgets/TrackingWidget.dart';
import '../controllers/ProfileDetailsController.dart';

class DoctorProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileDetailsController(),
        builder: (ProfileDetailsController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'Profile',
                      titleSpacing: 0,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: spacer4,
                              ),
                              SizedBox(
                                width: spacer1,
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: RefreshIndicator(
                        onRefresh: () => controller.getDoctorShowDetails(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: screen.height * 0.20,
                              width: screen.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: screen.height * 0.12,
                                    width: screen.width * 0.35,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '${controller.showDetails.avatar ?? ''}'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${controller.showDetails.salutation ?? ""}',
                                        style: TextStyl.subtitle?.copyWith(
                                            color: kcBlack, fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${controller.showDetails.name}',
                                          style: TextStyl.subtitle?.copyWith(
                                              color: kcBlack, fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      if (controller.showDetails.isVerified !=
                                          '0')
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          child: SvgPicture.asset(
                                            'assets/icons/user_verify.svg',
                                            color: kcGreen,
                                            width: 15,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${controller.showDetails.speciality?.name ?? "Speciality"}",
                                    //  "Bone Specailist",
                                    style: TextStyl.body?.copyWith(
                                        color: kcBlack.withOpacity(0.7),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Obx(
                              () => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabPillWidget(
                                    onTap: () => controller.onTapChange(0),
                                    label: "Overview",
                                    active: controller.tapIndex == 0,
                                  ),
                                  TabPillWidget(
                                    onTap: () => controller.onTapChange(1),
                                    label: "Availability",
                                    active: controller.tapIndex == 1,
                                  ),
                                  TabPillWidget(
                                    onTap: () => controller.onTapChange(2),
                                    label: "Schedule",
                                    active: controller.tapIndex == 2,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(() => controller.tapIndex == 0
                                        ? OverViewWidget(
                                            controller: controller,
                                          )
                                        : controller.tapIndex == 1
                                            ? AvailabilityWidget(
                                                controller: controller,
                                              )
                                            : ScheduleWidget(
                                                controller: controller,
                                              ))
                                  ],
                                ),
                              ),
                            ),
                            Button.block(
                                key: UniqueKey(),
                                onTap: (_) async {
                                  launch('tel:${controller.showDetails.phone}');
                                },
                                flat: true,
                                label: "Contact Doctor Now")
                          ],
                        ),
                      ),
                    );
        });
  }
}

/// =================================
/// OverView -----------------------
/// =================================
class OverViewWidget extends StatelessWidget {
  const OverViewWidget({Key? key, required this.controller}) : super(key: key);
  final ProfileDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/marker.svg',
                      color: kcBlack.withOpacity(0.7),
                      width: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Address',
                      style: TextStyl.subtitle
                          ?.copyWith(color: kcBlack, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer1,
                ),
                Text(
                    "${controller.showDetails.address ?? "Address"}, ${controller.showDetails.stateData?.name ?? 'State'} ,${controller.showDetails.cityData?.name ?? 'City'}, ${controller.showDetails.pincode ?? 'Pincode'}",
                    style: TextStyl.body?.copyWith(fontSize: 13)),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/briefcase.svg',
                      color: kcBlack.withOpacity(0.7),
                      width: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Experience',
                      style: TextStyl.subtitle
                          ?.copyWith(color: kcBlack, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer1,
                ),
                if (controller.experienceDetails != null &&
                    controller.experienceDetails.length > 0)
                  ...List.generate(
                    controller.experienceDetails.length,
                    (index) {
                      Experience experience =
                          controller.experienceDetails[index];
                      log.w(controller.experienceDetails.length);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${experience.title}",
                              style: TextStyl.body?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcDarkAlt)),
                          Text(
                              "${Jiffy(experience.startDate).format("yyyy/MM/dd")}-${Jiffy(experience.startDate).format("yyyy/MM/dd")}",
                              style: TextStyl.body?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                          Text("${experience.location}",
                              style: TextStyl.body?.copyWith(fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/graduation-cap.svg',
                      color: kcBlack.withOpacity(0.7),
                      width: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Qualification',
                      style: TextStyl.subtitle
                          ?.copyWith(color: kcBlack, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer1,
                ),
                if (controller.qualificationDetails != null &&
                    controller.qualificationDetails.length > 0)
                  ...List.generate(
                    controller.qualificationDetails.length,
                    (index) {
                      Qualification qualification =
                          controller.qualificationDetails[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${qualification.degree}",
                              style: TextStyl.body?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcDarkAlt)),
                          Text(
                              "${Jiffy(qualification.startDate).format("yyyy/MM/dd")}-${Jiffy(qualification.startDate).format("yyyy/MM/dd")}",
                              style: TextStyl.body?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                          Text("${qualification.collegeName}",
                              style: TextStyl.body?.copyWith(fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/building.svg',
                      color: kcBlack.withOpacity(0.7),
                      width: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Clinic Details',
                      style: TextStyl.subtitle
                          ?.copyWith(color: kcBlack, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer1,
                ),
                Text(
                    "${controller.showDetails.priDrNote?.nameOfClinic ?? 'Clinic Name'} ",
                    style: TextStyl.body?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kcDarkAlt)),
                Text(
                    "${controller.showDetails.priDrNote?.clinicContactNo ?? 'Contact'}",
                    style: TextStyl.body?.copyWith(fontSize: 15)),
                Text(
                    "${controller.showDetails.address ?? 'Address'}, ${controller.showDetails.stateData?.name ?? 'State'} ,${controller.showDetails.cityData?.name ?? "City"}, ${controller.showDetails.pincode ?? "Pincode"}",
                    style: TextStyl.body?.copyWith(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ====================================
/// Availability -----------------------
/// ====================================
class AvailabilityWidget extends StatelessWidget {
  const AvailabilityWidget({Key? key, required this.controller})
      : super(key: key);
  final ProfileDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screen.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kcWarning.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Text(
                      "Last UpdateAt",
                      style: TextStyl.bodySm,
                    ),
                    Spacer(),
                    Text(
                        "${Jiffy(controller.showDetails.updatedAt).format("MMM dd yyyy h:mm a")}"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (controller.showDetails.workingAvailability == 0)
                TrackingWidget(
                  image: "assets/icons/users.png",
                  title: "Available",
                  subTitle:
                      "${controller.showDetails.waitingPeriod} Patients in queue",
                  // date: "${Jiffy(controller.showDetails.updatedAt).format("MMM dd yyyy")}",
                  date:
                      "It takes ${controller.showDetails.appointmentPeriod} minutes to treat a patient.",
                  sideBarColor: kcGreen,
                ),
              if (controller.showDetails.workingAvailability == 0)
                SizedBox(
                  height: 10,
                ),
              if (controller.showDetails.workingAvailability == 1)
                TrackingWidget(
                  image: "assets/icons/users.png",
                  title: "Unavailable",
                  subTitle: "Today Unavailable",
                  // date: "${Jiffy(controller.showDetails.updatedAt).format("MMM dd yyyy")}",
                  date:
                      "It takes ${controller.showDetails.appointmentPeriod} minutes to treat a patient.",
                  sideBarColor: kcDanger,
                ),
              if (controller.showDetails.workingAvailability == 1)
                SizedBox(
                  height: 10,
                ),
              if (controller.showDetails.workingAvailability == 2)
                TrackingWidget(
                  image: "assets/icons/users.png",
                  title: "Busy",
                  subTitle:
                      "${controller.showDetails.waitingPeriod} Patients in queue",
                  // date: "${Jiffy(controller.showDetails.updatedAt).format("MMM dd yyyy")}",
                  date:
                      "It takes ${controller.showDetails.appointmentPeriod} minutes to treat a patient.",
                  sideBarColor: kcWarning,
                ),
              if (controller.showDetails.workingAvailability == 2)
                SizedBox(
                  height: 15,
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: kcPrimary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${controller.showDetails.workingUpdate}",
                  style: TextStyl.bodySm?.copyWith(
                      color: kcBlack.withOpacity(0.8),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ==================================
/// Schedule ----------------------
/// ==================================
class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key, required this.controller}) : super(key: key);

  final ProfileDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(controller.showDetails.schedules!.length, (index) {
            DoctorModelSchedule schedules =
                controller.showDetails.schedules![index];
            return Container(
              padding: const EdgeInsets.only(left: 15, right: 24),
              decoration: BoxDecoration(),
              margin: EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        controller.onTapHide(schedules.day.toString());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.hideSchedule == schedules.day &&
                                  controller.hide
                              ? kcPrimary.withOpacity(0.9)
                              : kcOffWhite,
                        ),
                        width: screen.width,
                        child: Row(
                          children: [
                            Text(
                              "${schedules.day}",
                              style: TextStyl.bodySm?.copyWith(
                                  color: controller.hideSchedule ==
                                              schedules.day &&
                                          controller.hide
                                      ? kcWhite
                                      : kcBlack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Obx(
                              () => Icon(
                                controller.hideSchedule == schedules.day &&
                                        controller.hide
                                    ? Icons.arrow_drop_down_sharp
                                    : Icons.arrow_drop_up_outlined,
                                color: kcWhite,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.hide &&
                            controller.hideSchedule == schedules.day
                        ? SizedBox(
                            height: 15,
                          )
                        : SizedBox(
                            height: 3,
                          ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.hideSchedule == schedules.day,
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.spaceBetween,
                          clipBehavior: Clip.none,
                          runSpacing: 5,
                          spacing: 5,
                          children: [
                            ...List.generate(schedules.schedules!.length,
                                (index) {
                              ScheduleSchedule schedule =
                                  schedules.schedules![index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: kcDarkAlt.withOpacity(0.2),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: kcWhite,
                                ),
                                child: Text(
                                  "${schedule.from}-${schedule.to}",
                                  style: TextStyl.bodySm?.copyWith(
                                      color: kcBlack,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }),
                          ]),
                    ),
                  ),
                  Obx(
                    () => controller.hide &&
                            controller.hideSchedule == schedules.day
                        ? SizedBox(
                            height: 6,
                          )
                        : SizedBox(
                            height: 3,
                          ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
