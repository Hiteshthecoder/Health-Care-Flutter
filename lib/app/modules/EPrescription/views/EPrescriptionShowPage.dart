import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/modules/EPrescription/views/EPrescriptionPage.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_mvc/config/Config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/EPrescriptionController.dart';

class EPrescriptionShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: EPrescriptionController(),
        builder: (EPrescriptionController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'ePrescription Details',
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
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
                      body: Container(
                          padding: const EdgeInsets.all(spacer2),
                          child: Column(children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 8),
                                      child: SizedBox(
                                        width: Config.screenWidth / 2,
                                        child: Image.asset(
                                            "assets/images/dark_logo_nobg.png"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: EPrescriptionWidget(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            title:
                                                '${controller.prescriptionDetails?.doctor?.priDrNote?.nameOfClinic ?? ""}',
                                            description:
                                                '${controller.prescriptionDetails?.doctor?.priDrNote?.address ?? ""}, ${controller.prescriptionDetails?.doctor?.priDrNote?.city ?? ""}, ${controller.prescriptionDetails?.doctor?.priDrNote?.state ?? ""}',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Expanded(
                                          child: EPrescriptionWidget(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              title:
                                                  'Dr ${controller.prescriptionDetails?.doctor?.firstName} ${controller.prescriptionDetails?.doctor?.lastName}',
                                              description: controller
                                                      .prescriptionDetails
                                                      ?.doctor
                                                      ?.speciality
                                                      ?.name ??
                                                  ""),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration:
                                          PrescriptionDecoration.decoration(),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: EPrescriptionWidget(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  title: '${auth.user.name}',
                                                  description:
                                                      "${auth.user.gender}"),
                                            ),
                                            Expanded(
                                              child: EPrescriptionWidget(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  title: 'Age',
                                                  description:
                                                      "${auth.user.age ?? ''} years"),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            EPrescriptionWidget(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                title: 'Weight',
                                                description:
                                                    "${auth.user.weight ?? ""} kg"),
                                            EPrescriptionWidget(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                title: 'Height',
                                                description:
                                                    "${auth.user.height ?? ""} cm"),
                                            Column(children: [
                                              Text(
                                                "BMI",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        color: kcBlack
                                                            .withOpacity(0.75),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                  "${getBMICalculation(weight: auth.user.weight ?? "", height: auth.user.height ?? "")}",
                                                  style: TextStyl
                                                      .bodySm
                                                      ?.copyWith(
                                                          color: getBMIColor(
                                                              weight: auth.user
                                                                      .weight ??
                                                                  "",
                                                              height: auth.user
                                                                      .height ??
                                                                  ""),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                              Text(
                                                "(${getBMIText(weight: auth.user.weight ?? "", height: auth.user.height ?? "")})",
                                                style: TextStyl.bodySm
                                                    ?.copyWith(
                                                        color: kcBlack,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration:
                                          PrescriptionDecoration.decoration(),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Any Allergy -',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        controller.summaryData != null &&
                                                controller.summaryData!
                                                        .summaryDetail !=
                                                    null
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .summaryData!
                                                    .summaryDetail!
                                                    .any_allergy!
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  final item = controller
                                                      .summaryData!
                                                      .summaryDetail!
                                                      .any_allergy[i];
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: item
                                                              .split(',')
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            final text = item
                                                                .split(',')[i];
                                                            return Text(
                                                              " \u2022 ${text}",
                                                              style: TextStyl
                                                                  .bodySm
                                                                  ?.copyWith(
                                                                      color:
                                                                          kcBlack,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            );
                                                          }));
                                                })
                                            : Container(),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Known Case of -',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        controller.summaryData != null &&
                                                controller.summaryData!
                                                        .summaryDetail !=
                                                    null
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .summaryData!
                                                    .summaryDetail!
                                                    .known_cases
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  final item = controller
                                                      .summaryData!
                                                      .summaryDetail!
                                                      .known_cases![i];
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: item
                                                              .split(',')
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            final text = item
                                                                .split(',')[i];
                                                            return Text(
                                                              " \u2022 ${text}",
                                                              style: TextStyl
                                                                  .bodySm
                                                                  ?.copyWith(
                                                                      color:
                                                                          kcBlack,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            );
                                                          }));
                                                })
                                            : Container(),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Current Medication -',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        controller.summaryData != null &&
                                                controller.summaryData!
                                                        .summaryDetail !=
                                                    null
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .summaryData!
                                                    .summaryDetail!
                                                    .current_medication
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  final item = controller
                                                      .summaryData!
                                                      .summaryDetail!
                                                      .current_medication[i];
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: item
                                                              .split(',')
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            final text = item
                                                                .split(',')[i];
                                                            return Text(
                                                              " \u2022 ${text}",
                                                              style: TextStyl
                                                                  .bodySm
                                                                  ?.copyWith(
                                                                      color:
                                                                          kcBlack,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            );
                                                          }));
                                                })
                                            : Container(),
                                      ]),
                                    ),
                                    //-- Symptoms
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration:
                                          PrescriptionDecoration.decoration(),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Symptoms',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller
                                                  .prescriptionDetails!
                                                  .symptoms!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                final item = controller
                                                    .prescriptionDetails!
                                                    .symptoms![i];
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Chip(
                                                      label: Text(
                                                          "${item.name} ${item.duration} ${item.durationType}"),
                                                    ));
                                              }),
                                        ),
                                        Divider(),

                                        //-- Tests
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tests to take',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller
                                                  .prescriptionDetails!
                                                  .testsToTake!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                final item = controller
                                                    .prescriptionDetails!
                                                    .testsToTake![i];
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Chip(
                                                      label: Text(item),
                                                    ));
                                              }),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Diagnosis',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        SizedBox(
                                          height: 50,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller
                                                  .prescriptionDetails!
                                                  .diagnosis!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                final item = controller
                                                    .prescriptionDetails!
                                                    .diagnosis![i];
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Chip(
                                                      label: Text(item),
                                                    ));
                                              }),
                                        ),
                                      ]),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    //-- Medicines
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration:
                                          PrescriptionDecoration.decoration(),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Medicines',
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(
                                                          color: kcBlack
                                                              .withOpacity(
                                                                  0.75),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3),
                                            Column(
                                                children: controller
                                                    .prescriptionDetails!
                                                    .medications!
                                                    .map((e) => Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width:
                                                              double.maxFinite,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color:
                                                                  kcLightGray),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  e.name ??
                                                                      "Medicine name",
                                                                  style: TextStyl
                                                                      .bodySm
                                                                      ?.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                ),
                                                                SizedBox(
                                                                    height: 3),
                                                                Text(
                                                                    "${e.duration ?? 0} ${e.durationType}"),
                                                                SizedBox(
                                                                    height: 3),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Before Meal: "),
                                                                    Flexible(
                                                                        child: Text(
                                                                            "${(e.beforeMealMorning!) ? 'Breakfast, ' : ''}${e.beforeMealLunch! ? 'Lunch, ' : ''}${e.beforeMealEvening! ? 'Evening, ' : ''}${e.beforeMealNight! ? 'Night' : ''}"))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "After Meal: "),
                                                                    Flexible(
                                                                        child: Text(
                                                                            "${(e.afterMealMorning!) ? 'Breakfast, ' : ''}${e.afterMealLunch! ? 'Lunch, ' : ''}${e.afterMealEvening! ? 'Evening, ' : ''}${e.afterMealNight! ? 'Night' : ''}"))
                                                                  ],
                                                                ),
                                                                Row(children: [
                                                                  Text(
                                                                      "Remarks: "),
                                                                  Text(
                                                                      e.remarks ??
                                                                          "")
                                                                ])
                                                                // Text(
                                                                //     "${e.afterMeal != null && e.afterMeal! ? 'After' : 'Before'}: ${e.breakfast != null ? 'Breakfast ' : ''} ${e.lunch != null ? 'Lunch ' : ''} ${e.dinner != null ? 'Dinner ' : ''}"),
                                                              ]),
                                                        ))
                                                    .toList()),
                                            SizedBox(height: 4),
                                            Divider(),
                                            Text(
                                              'Advise - ',
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.75),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .prescriptionDetails!
                                                    .advice!
                                                    .split(',')
                                                    .length,
                                                itemBuilder: (context, i) {
                                                  final item = controller
                                                      .prescriptionDetails!
                                                      .advice!
                                                      .split(',')[i];
                                                  return Row(
                                                    children: [
                                                      Text("\u2022 "),
                                                      Text(item)
                                                    ],
                                                  );
                                                }),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Obx(() => InkWell(
                                  onTap: () {
                                    controller.getePrescriptionPdfAPI(
                                        controller.prescriptionDetails!.id!);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 1),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.downloadLoading
                                            ? kcofffWhite
                                            : kcPrimary,
                                        borderRadius: BorderRadius.circular(8)),
                                    width: screen.width,
                                    height: screen.height * 0.05,
                                    child: controller.downloadLoading
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icons/loading.gif',
                                                height: 14.0,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.download,
                                                  size: 18, color: kcWhite),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Download",
                                                style: TextStyl.button
                                                    ?.copyWith(
                                                        color: kcWhite,
                                                        fontSize: 15),
                                              ),
                                            ],
                                          ),
                                  ),
                                ))
                          ])));
        });
  }
}

class EPrescriptionWidget extends StatelessWidget {
  const EPrescriptionWidget(
      {Key? key,
      required this.title,
      required this.description,
      this.crossAxisAlignment})
      : super(key: key);

  final String title;
  final String description;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyl.bodySm?.copyWith(
                color: kcBlack.withOpacity(0.75),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          if (description != "")
            SizedBox(
              height: 3,
            ),
          if (description != "")
            Text(
              "$description",
              style: TextStyl.bodySm?.copyWith(
                  color: kcBlack, fontSize: 15, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.title,
      this.onTap,
      required this.icon,
      required this.active})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: active ? kcofffWhite : kcPrimary,
              borderRadius: BorderRadius.circular(8)),
          width: screen.width,
          height: screen.height * 0.05,
          child: active
              ? LoadingIcon()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 18, color: kcWhite),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$title",
                      style: TextStyl.button
                          ?.copyWith(color: kcWhite, fontSize: 15),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
