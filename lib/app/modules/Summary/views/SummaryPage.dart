import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/SummaryController.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SummaryController(),
      builder: (SummaryController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: 'My Summary',
                    //   title: 'View HSD001 Story',
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
                                        "My Summary is a short description about your medical history giving a quick insight about your health.",
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
                        onRefresh: () async {},
                        child: Obx(() => controller.summaryData.id == null
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    NoDataWidget(
                                      message:
                                          "To create summary, you need to upload documents first",
                                      icon: SvgPicture.asset(
                                        'assets/icons/treatment.svg',
                                        width: spacer8,
                                        color: kcDarkAlt,
                                      ),
                                      action: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.offNamed('/upload');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: kcPrimary,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: screen.width * 0.52,
                                            height: screen.height * 0.05,
                                            child: Text(
                                              "Start Uploading",
                                              style: TextStyl.bodySm?.copyWith(
                                                  fontSize: 15, color: kcWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.tips_and_updates,
                                          size: 25,
                                          color: kcWarning,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Have a look",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: kcDarkAlt),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/blogsHealthTips',
                                            parameters: {"healthTip_id": "9"});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: kcOffWhite,
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: screen.width * 0.68,
                                        height: screen.height * 0.05,
                                        child: Text(
                                          "How my summary looks like"
                                              .toUpperCase(),
                                          style: TextStyl.bodySm?.copyWith(
                                              fontSize: 14,
                                              color: kcBlack,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 3),
                                      color: kcWarning.withOpacity(0.2),
                                      width: screen.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/info.svg'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Summary is created according to documents provided. For more accurate information kindly refer to original file.',
                                              style: TextStyl.bodySm?.copyWith(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                            : controller.summaryData.summaryDetail == null &&
                                    controller.summaryData.id != null
                                ? Center(
                                    child: Column(
                                      children: [
                                        NoDataWidget(
                                          icon: SvgPicture.asset(
                                            'assets/icons/treatment.svg',
                                            width: spacer8,
                                            color: kcDarkAlt,
                                          ),
                                          message:
                                              "Your summary is under creation",
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 3),
                                          color: kcWarning.withOpacity(0.2),
                                          width: screen.width,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/icons/info.svg'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'Summary is created according to documents provided. For more accurate information kindly refer to original file.',
                                                  style:
                                                      TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 3),
                                      color: kcWarning.withOpacity(0.2),
                                      width: screen.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Last Update -  ${Jiffy(controller.summaryData.updatedAt).format('dd MMM, yyyy')}',
                                            style: TextStyl.bodySm?.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (controller.summaryData.remark != null)
                                      SizedBox(
                                        height: 15,
                                      ),
                                    if (controller.summaryData.remark != null)
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(13),
                                                topLeft: Radius.circular(13),
                                              ),
                                              color: kcBlue,
                                            ),
                                            width: screen.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kcWhite,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/icons/support.png',
                                                    width: 35,
                                                    color: kcPrimary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'DQ Care Support',
                                                      style: TextStyl.bodySm
                                                          ?.copyWith(
                                                              fontSize: 16,
                                                              color: kcWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      'Sent you a message',
                                                      style: TextStyl.bodySm
                                                          ?.copyWith(
                                                              fontSize: 11,
                                                              color: kcWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 6),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: kcDarkAlt
                                                        .withOpacity(0.5),
                                                    blurRadius: 15.0,
                                                    blurStyle: BlurStyle.outer,
                                                  )
                                                ]
                                                // border: Border(
                                                //   bottom: BorderSide(color: kcBlue,width: 0.5,style: BorderStyle.solid),
                                                // ),
                                                ),
                                            width: screen.width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${controller.summaryData.remark}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyl.body
                                                      ?.copyWith(
                                                          fontSize: 14,
                                                          color: kcBlack),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (controller.summaryData.remark != null)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: spacer4,
                                                      vertical: spacer4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        "${controller.summaryData.user?.avatar}"),
                                                    radius: 25,
                                                  ),
                                                  SizedBox(
                                                    height: spacer2,
                                                  ),
                                                  Text(
                                                    '${auth.user.name}',
                                                    style: TextStyl.body
                                                        ?.copyWith(
                                                            fontSize: 16,
                                                            color: kcPrimary
                                                                .withOpacity(
                                                                    0.6),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  SizedBox(
                                                    height: spacer1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (controller.summaryData
                                                              .age !=
                                                          null)
                                                        Text(
                                                          '${controller.summaryData.age ?? 'Age'}',
                                                          style: TextStyl.bodySm
                                                              ?.copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      if (controller.summaryData
                                                              .age !=
                                                          null)
                                                        Text(
                                                          ' | ',
                                                          style: TextStyl.bodySm
                                                              ?.copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                      if (controller.summaryData
                                                              .user?.gender !=
                                                          null)
                                                        Text(
                                                          '${controller.summaryData.user?.gender ?? 'Gender'}',
                                                          style: TextStyl.bodySm
                                                              ?.copyWith(
                                                                  fontSize: 13),
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: spacer1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'DOB | ',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(
                                                                fontSize: 13),
                                                      ),
                                                      Text(
                                                        '${Jiffy(controller.summaryData.dob).format('yyyy-MM-dd')}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(
                                                                fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                                child:
                                                    Column(children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                  ),
                                                  child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Known case of',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .known_cases
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .known_cases[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ])),
                                            ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Family History',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .family_history
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .family_history[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Operative History',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .operative_history
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .operative_history[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Habit History',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .habit_history
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .habit_history![i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Any Allergy',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .any_allergy
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .any_allergy![i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Current Medication',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .current_medication!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .current_medication[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Vaccination History',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .vaccination_history!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .vaccination_history[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Last OPD Visit',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .opd_visit
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .opd_visit[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                                child: Column(
                                                    children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Last Admitted',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .last_admitted!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .last_admitted[i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              }),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                            Center(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    child: Table(
                                                      defaultColumnWidth:
                                                          FixedColumnWidth(
                                                              screen.width *
                                                                  0.92),
                                                      border: TableBorder.all(
                                                          color: kcDarkAlt
                                                              .withOpacity(0.4),
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: kcPrimary
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Blood Group',
                                                                  style: TextStyl
                                                                      .body
                                                                      ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kcWhite,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          ListView.builder(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8),
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .summaryData!
                                                                  .summaryDetail!
                                                                  .bloodGroup
                                                                  .length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                final item = controller
                                                                    .summaryData!
                                                                    .summaryDetail!
                                                                    .bloodGroup![i];
                                                                return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            4),
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: item.split(',').length,
                                                                        itemBuilder: (context, i) {
                                                                          final text =
                                                                              item.split(',')[i];
                                                                          return Text(
                                                                            " \u2022 ${text}",
                                                                            style: TextStyl.bodySm?.copyWith(
                                                                                color: kcBlack,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }));
                                                              })
                                                        ])
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: spacer,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 13,
                                                            vertical: 3),
                                                    color: kcWarning
                                                        .withOpacity(0.2),
                                                    width: screen.width,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/icons/info.svg'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            'Summary is created according to documents provided. For more accurate information kindly refer to original file.',
                                                            style: TextStyl
                                                                .bodySm
                                                                ?.copyWith(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]))));
      },
    );
  }
}
