import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';
import '../controllers/InsightViewController.dart';
import 'package:flutter_mvc/config/Config.dart';

class InsightViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InsightViewController(),
      builder: (InsightViewController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: 'Insight',
                    backgroundColor: kcWhite,
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
                                        "See trends of your different blood reports, helping in better analysis.",
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Obx(() => !controller.hasStory
                                ? SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        NoDataWidget(
                                          message:
                                              "To create insight, you need to upload documents first",
                                          icon: SvgPicture.asset(
                                            'assets/icons/stats.svg',
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: kcPrimary,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                width: screen.width * 0.52,
                                                height: screen.height * 0.05,
                                                child: Text(
                                                  "Start Uploading",
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(
                                                          fontSize: 15,
                                                          color: kcWhite),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                parameters: {
                                                  "healthTip_id": "13"
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: kcOffWhite,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            width: screen.width * 0.68,
                                            height: screen.height * 0.05,
                                            child: Text(
                                              "How my insight looks like"
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
                                                  'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
                                                  style:
                                                      TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : controller.insights.isEmpty
                                    ? Column(
                                        children: [
                                          NoDataWidget(
                                            icon: SvgPicture.asset(
                                              'assets/icons/stats.svg',
                                              width: spacer8,
                                              color: kcDarkAlt,
                                            ),
                                            message:
                                                "Your insight is under creation",
                                          ),
                                          // Spacer(),
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
                                                    'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : auth.user.subscription!.isTrial() ||
                                            auth.user.subscription!.toDate!
                                                .isBefore(DateTime.now())
                                        ? Blur(
                                            overlay: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.lock_outline,
                                                  size: 45,
                                                  color: kcDarkAlt,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "You don't have a subscription",
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: kcPrimary),
                                                ),
                                                Text(
                                                  "Subscribing to a plan unlocks this report",
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: kcDarkAlt
                                                              .withOpacity(
                                                                  0.6)),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                MirrorAnimationBuilder<double>(
                                                  tween:
                                                      Tween(begin: -1, end: 2),
                                                  builder:
                                                      (context, child, value) {
                                                    return Container(
                                                      width: 200,
                                                      height: 65,
                                                      child:
                                                          Transform.translate(
                                                        offset:
                                                            Offset(0, child),
                                                        child: IconButton(
                                                          icon: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        35,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              //  border: Border.all(width: 1,color: kcPrimary),
                                                              color: kcGreen,
                                                            ),
                                                            child: Text(
                                                              'Take Subscription',
                                                              style: TextStyl
                                                                  .bodySm
                                                                  ?.copyWith(
                                                                      color:
                                                                          kcWhite,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                '/buyPlan');
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeInCubic,
                                                ),
                                              ],
                                            ),
                                            blur: 2.5,
                                            blurColor: kcWhite,
                                            colorOpacity: 0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 13,
                                                      vertical: 3),
                                                  color: kcWarning
                                                      .withOpacity(0.2),
                                                  width: screen.width,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Last Update - ${Jiffy(controller.insight.updatedAt).format('dd MMM, yyyy')}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: spacer2,
                                                        vertical: 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Accordion(
                                                            maxOpenSections: 1,
                                                            scaleWhenAnimating:
                                                                true,
                                                            openAndCloseAnimation:
                                                                true,
                                                            children: [
                                                              ///  if(controller.selectedInsight == 'blood')
                                                              AccordionSection(
                                                                scrollIntoViewOfItems:
                                                                    ScrollIntoViewOfItems
                                                                        .fast,
                                                                isOpen: true,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/blood.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),

                                                                // headerBackgroundColor: Colors.black,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                header: Text(
                                                                  'Blood Picture',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'blood').first.items!.keys.first}',
                                                                        'blood'),

                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'blood' ||
                                                                          controller.insights.where((e) => e.name == 'blood').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'blood').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'blood').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'blood').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'blood').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'blood'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Blood reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                                //  contentHorizontalPadding: 20,
                                                                // contentBorderWidth: 1,
                                                                // onOpenSection: () => print('onOpenSection ...'),
                                                                // onCloseSection: () => print('onCloseSection ...'),
                                                              ),

                                                              AccordionSection(
                                                                //  scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                                isOpen: false,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/liver.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),
                                                                header: Text(
                                                                  'Liver Function',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'liver').first.items!.keys.first}',
                                                                        'liver'),
                                                                // headerBackgroundColorOpened: Colors.black54,
                                                                contentBorderColor:
                                                                    Colors
                                                                        .black54,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'liver' ||
                                                                          controller.insights.where((e) => e.name == 'liver').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              // Renders column chart
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'liver').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'liver').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'liver').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'liver').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'liver'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),
                                                              //if(controller.selectedInsight == 'kidney')
                                                              AccordionSection(
                                                                // scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                                isOpen: false,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/kidney.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),

                                                                header: Text(
                                                                  'Kidney Function',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'kidney').first.items!.keys.first}',
                                                                        'kidney'),
                                                                // headerBackgroundColorOpened: Colors.black54,
                                                                contentBorderColor:
                                                                    Colors
                                                                        .black54,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'kidney' ||
                                                                          controller.insights.where((e) => e.name == 'kidney').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              // Renders column chart
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'kidney').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'kidney').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'kidney').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'kidney').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'kidney'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),
                                                              // if(controller.selectedInsight == 'lipid')
                                                              AccordionSection(
                                                                //  scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                                isOpen: false,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/no-fat.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),

                                                                header: Text(
                                                                  'Lipid Profile',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'lipid').first.items!.keys.first}',
                                                                        'lipid'),
                                                                // headerBackgroundColorOpened: Colors.black54,
                                                                contentBorderColor:
                                                                    Colors
                                                                        .black54,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'lipid' ||
                                                                          controller.insights.where((e) => e.name == 'lipid').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              // Renders column chart
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'lipid').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'lipid').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'lipid').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'lipid').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'lipid'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),

                                                              AccordionSection(
                                                                // scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                                isOpen: false,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/diabetes.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),
                                                                header: Text(
                                                                  'Diabetes Screening',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.first}',
                                                                        'diabetes'),
                                                                // headerBackgroundColorOpened: Colors.black54,
                                                                contentBorderColor:
                                                                    Colors
                                                                        .black54,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'diabetes' ||
                                                                          controller.insights.where((e) => e.name == 'diabetes').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              // Renders column chart
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'diabetes').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'diabetes').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'diabetes'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),
                                                              AccordionSection(
                                                                //scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                                isOpen: false,
                                                                leftIcon:
                                                                    Image.asset(
                                                                  'assets/images/throat.png',
                                                                  color:
                                                                      kcWhite,
                                                                  width: 16,
                                                                  height: 16,
                                                                ),
                                                                header: Text(
                                                                  'Thyroid Function',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kcWhite),
                                                                ),
                                                                onOpenSection: () =>
                                                                    controller.onTabSelected(
                                                                        '${controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.first}',
                                                                        'thyroid'),
                                                                // headerBackgroundColorOpened: Colors.black54,
                                                                contentBorderColor:
                                                                    Colors
                                                                        .black54,
                                                                headerBackgroundColorOpened:
                                                                    kcDanger,
                                                                content: Obx(
                                                                  () => controller.selectedInsight !=
                                                                              'thyroid' ||
                                                                          controller.insights.where((e) => e.name == 'thyroid').first.items ==
                                                                              null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text('No Data Yet!'),
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            SfCartesianChart(primaryXAxis: CategoryAxis(), series: <CartesianSeries<ChartData,
                                                                                String>>[
                                                                              // Renders column chart
                                                                              LineSeries<ChartData, String>(
                                                                                dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'thyroid').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'thyroid').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                xValueMapper: (ChartData data, _) => data.x,
                                                                                yValueMapper: (ChartData data, _) => data.y,
                                                                              )
                                                                            ]),
                                                                            Container(
                                                                              color: kcWhite,
                                                                              width: screen.width,
                                                                              height: 65,
                                                                              child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Obx(
                                                                                  () => Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      ...List.generate(controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.length, (index) {
                                                                                        String item = controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.elementAt(index);
                                                                                        return TabPillWidget(
                                                                                          label: "$item".capitalizeFirst.toString(),
                                                                                          onTap: () => controller.onTabSelected(item, 'thyroid'),
                                                                                          active: controller.selectedInsightTab == item,
                                                                                        );
                                                                                      }),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/info.svg',
                                                                                    color: kcBlack.withOpacity(0.65),
                                                                                    width: 20,
                                                                                    height: 20,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Thyroid reports.")),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ),
                                                              ),

                                                              // AccordionSection(
                                                              //   //scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              //   isOpen: false,
                                                              //   leftIcon: Image.asset(
                                                              //     'assets/images/lab.png',
                                                              //     color: kcWhite,
                                                              //     width: 16,
                                                              //     height: 16,
                                                              //   ),
                                                              //   header: Text(
                                                              //     'Urine Test',
                                                              //     style: TextStyle(color: kcWhite),
                                                              //   ),
                                                              //   onOpenSection: () => controller.onTabSelected(
                                                              //       '${controller.insights.where((e) => e.name == 'urineTest').first.items!.keys.first}',
                                                              //       'urineTest'),
                                                              //   // headerBackgroundColorOpened: Colors.black54,
                                                              //   contentBorderColor: Colors.black54,
                                                              //   headerBackgroundColorOpened: kcDanger,
                                                              //   content: Obx(
                                                              //     () => controller.selectedInsight != 'urineTest'  || controller.insights.where((e) => e.name== 'urineTest').first.items == null
                                                              //         ? Padding(
                                                              //           padding: const EdgeInsets.all(8.0),
                                                              //           child: Text('No Data Yet!'),
                                                              //         )
                                                              //         : Column(
                                                              //             children: [
                                                              //               SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries<ChartData, String>>[
                                                              //                 // Renders column chart
                                                              //                 LineSeries<ChartData, String>(
                                                              //                   dataSource: List<ChartData>.from(controller.insights
                                                              //                       .where((e) => e.name == 'urineTest')
                                                              //                       .first
                                                              //                       .items![controller.selectedInsightTab]
                                                              //                       .keys
                                                              //                       .map((e) => ChartData(
                                                              //                           x: e,
                                                              //                           y: double.parse(controller.insights
                                                              //                               .where((e) => e.name == 'urineTest')
                                                              //                               .first
                                                              //                               .items![controller.selectedInsightTab][e]
                                                              //                               .toString())))),
                                                              //                   xValueMapper: (ChartData data, _) => data.x,
                                                              //                   yValueMapper: (ChartData data, _) => data.y,
                                                              //                 )
                                                              //               ]),
                                                              //               Container(
                                                              //                 color: kcWhite,
                                                              //                 width: screen.width,
                                                              //                 height: 65,
                                                              //                 child: SingleChildScrollView(
                                                              //                   scrollDirection: Axis.horizontal,
                                                              //                   child: Obx(
                                                              //                     () => Row(
                                                              //                       mainAxisSize: MainAxisSize.min,
                                                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                       mainAxisAlignment: MainAxisAlignment.start,
                                                              //                       children: [
                                                              //                         ...List.generate(
                                                              //                             controller.insights
                                                              //                                 .where((e) => e.name == 'urineTest')
                                                              //                                 .first
                                                              //                                 .items!
                                                              //                                 .keys
                                                              //                                 .length, (index) {
                                                              //                           String item = controller.insights
                                                              //                               .where((e) => e.name == 'urineTest')
                                                              //                               .first
                                                              //                               .items!
                                                              //                               .keys
                                                              //                               .elementAt(index);
                                                              //                           return TabPillWidget(
                                                              //                             label: "$item".capitalizeFirst.toString(),
                                                              //                             onTap: () => controller.onTabSelected(item, 'urineTest'),
                                                              //                             active: controller.selectedInsightTab == item,
                                                              //                           );
                                                              //                         }),
                                                              //                       ],
                                                              //                     ),
                                                              //                   ),
                                                              //                 ),
                                                              //               ),
                                                              //               Row(
                                                              //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                 mainAxisAlignment: MainAxisAlignment.start,
                                                              //                 children: [
                                                              //                   Padding(
                                                              //                     padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                              //                     child: SvgPicture.asset(
                                                              //                       'assets/icons/info.svg',
                                                              //                       color: kcBlack.withOpacity(0.65),
                                                              //                       width: 20,
                                                              //                       height: 20,
                                                              //                     ),
                                                              //                   ),
                                                              //                   SizedBox(
                                                              //                     width: 5,
                                                              //                   ),
                                                              //                   Flexible(
                                                              //                       flex: 1,
                                                              //                       child:
                                                              //                           Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                              //                 ],
                                                              //               ),
                                                              //             ],
                                                              //           ),
                                                              //   ),
                                                              // ),
                                                              // AccordionSection(
                                                              //   isOpen: false,
                                                              //   leftIcon:
                                                              //   Image.asset('assets/images/test.png' , color: kcWhite,
                                                              //     width: 16,height: 16,),
                                                              //   header: Text('Other' ,style: TextStyle(color: kcWhite),),
                                                              //   // headerBackgroundColorOpened: Colors.black54,
                                                              //   contentBorderColor: Colors.black54,
                                                              //   headerBackgroundColorOpened: kcDanger,
                                                              //   content: Column(
                                                              //     children: [
                                                              //       SfCartesianChart(
                                                              //           primaryXAxis: CategoryAxis(),
                                                              //           series: <ChartSeries<ChartData, String>>[
                                                              //             // Renders column chart
                                                              //             LineSeries<ChartData, String>(
                                                              //                 dataSource: List<ChartData>.from(controller.insightData.other!.keys.map((e) => ChartData(x: e, y: double.parse(controller.insightData.other![e].toString())))),
                                                              //                 xValueMapper: (ChartData data, _) => data.x,
                                                              //                 yValueMapper: (ChartData data, _) => data.y
                                                              //             )
                                                              //           ]
                                                              //       ),
                                                              //       Row(
                                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                                              //         children: [
                                                              //           Padding(
                                                              //             padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                                              //             child: SvgPicture.asset(
                                                              //               'assets/icons/info.svg', color: kcBlack.withOpacity(0.65),
                                                              //               width: 20,height: 20,
                                                              //             ),
                                                              //           ),
                                                              //           SizedBox(width: 5,),
                                                              //           Flexible(
                                                              //               flex:1,
                                                              //               child: Text("The chart below illustrates how frequently you submit Other reports.")),
                                                              //         ],
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 210,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
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
                                                          'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
                                                          style: TextStyl.bodySm
                                                              ?.copyWith(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 13,
                                                    vertical: 3),
                                                color:
                                                    kcWarning.withOpacity(0.2),
                                                width: screen.width,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Last Update - ${Jiffy(controller.insight.updatedAt).format('dd MMM, yyyy')}',
                                                      style: TextStyl.bodySm
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: spacer2,
                                                      vertical: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Accordion(
                                                          maxOpenSections: 1,
                                                          scaleWhenAnimating:
                                                              true,
                                                          openAndCloseAnimation:
                                                              true,
                                                          children: [
                                                            ///  if(controller.selectedInsight == 'blood')
                                                            AccordionSection(
                                                              scrollIntoViewOfItems:
                                                                  ScrollIntoViewOfItems
                                                                      .fast,
                                                              isOpen: true,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/blood.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),
                                                              // headerBackgroundColor: Colors.black,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              header: Text(
                                                                'Blood Picture',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'blood').first.items}',
                                                                      'blood'),

                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'blood' ||
                                                                        controller.insights.where((e) => e.name == 'blood').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'blood').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'blood').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'blood').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'blood').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'blood').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'blood'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Blood reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                              //  contentHorizontalPadding: 20,
                                                              // contentBorderWidth: 1,
                                                              // onOpenSection: () => print('onOpenSection ...'),
                                                              // onCloseSection: () => print('onCloseSection ...'),
                                                            ),

                                                            AccordionSection(
                                                              //  scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              isOpen: false,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/liver.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),
                                                              header: Text(
                                                                'Liver Function',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'liver').first.items!.keys.first}',
                                                                      'liver'),
                                                              // headerBackgroundColorOpened: Colors.black54,
                                                              contentBorderColor:
                                                                  Colors
                                                                      .black54,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'liver' ||
                                                                        controller.insights.where((e) => e.name == 'liver').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'liver').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                // Renders column chart
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'liver').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'liver').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'liver').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'liver').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'liver'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                            //if(controller.selectedInsight == 'kidney')
                                                            AccordionSection(
                                                              // scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              isOpen: false,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/kidney.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),

                                                              header: Text(
                                                                'Kidney Function',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'kidney').first.items!.keys.first}',
                                                                      'kidney'),
                                                              // headerBackgroundColorOpened: Colors.black54,
                                                              contentBorderColor:
                                                                  Colors
                                                                      .black54,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'kidney' ||
                                                                        controller.insights.where((e) => e.name == 'kidney').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'kidney').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                // Renders column chart
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'kidney').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'kidney').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'kidney').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'kidney').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'kidney'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                            // if(controller.selectedInsight == 'lipid')
                                                            AccordionSection(
                                                              //  scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              isOpen: false,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/no-fat.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),

                                                              header: Text(
                                                                'Lipid Profile',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'lipid').first.items!.keys.first}',
                                                                      'lipid'),
                                                              // headerBackgroundColorOpened: Colors.black54,
                                                              contentBorderColor:
                                                                  Colors
                                                                      .black54,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'lipid' ||
                                                                        controller.insights.where((e) => e.name == 'lipid').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'lipid').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                // Renders column chart
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'lipid').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'lipid').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'lipid').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'lipid').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'lipid'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),

                                                            AccordionSection(
                                                              // scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              isOpen: false,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/diabetes.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),
                                                              header: Text(
                                                                'Diabetes Screening',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.first}',
                                                                      'diabetes'),
                                                              // headerBackgroundColorOpened: Colors.black54,
                                                              contentBorderColor:
                                                                  Colors
                                                                      .black54,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'diabetes' ||
                                                                        controller.insights.where((e) => e.name == 'diabetes').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'diabetes').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                // Renders column chart
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'diabetes').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'diabetes').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'diabetes').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'diabetes'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                            AccordionSection(
                                                              //scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                              isOpen: false,
                                                              leftIcon:
                                                                  Image.asset(
                                                                'assets/images/throat.png',
                                                                color: kcWhite,
                                                                width: 16,
                                                                height: 16,
                                                              ),
                                                              header: Text(
                                                                'Thyroid Function',
                                                                style: TextStyle(
                                                                    color:
                                                                        kcWhite),
                                                              ),
                                                              onOpenSection: () =>
                                                                  controller.onTabSelected(
                                                                      '${controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.first}',
                                                                      'thyroid'),
                                                              // headerBackgroundColorOpened: Colors.black54,
                                                              contentBorderColor:
                                                                  Colors
                                                                      .black54,
                                                              headerBackgroundColorOpened:
                                                                  kcDanger,
                                                              content: Obx(
                                                                () => controller.selectedInsight !=
                                                                            'thyroid' ||
                                                                        controller.insights.where((e) => e.name == 'thyroid').first.items ==
                                                                            null
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            'No Data Yet!'),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          SfCartesianChart(
                                                                              enableAxisAnimation: true,
                                                                              primaryXAxis: CategoryAxis(
                                                                                labelStyle: TextStyle(fontSize: 12),
                                                                                maximumLabels: 1000,
                                                                                autoScrollingDelta: 4,
                                                                                // majorGridLines: MajorGridLines(width: 0),
                                                                                // majorTickLines: MajorTickLines(width: 0),
                                                                              ),
                                                                              primaryYAxis: CategoryAxis(
                                                                                minimum: 0,
                                                                                maximum: double.parse(highestValue(controller.insights.where((e) => e.name == 'thyroid').first.items![controller.selectedInsightTab].values.join(", ")).toString()),
                                                                              ),
                                                                              zoomPanBehavior: ZoomPanBehavior(
                                                                                enablePanning: true,
                                                                              ),
                                                                              series: <CartesianSeries<ChartData, String>>[
                                                                                // Renders column chart
                                                                                LineSeries<ChartData, String>(
                                                                                  dataSource: List<ChartData>.from(controller.insights.where((e) => e.name == 'thyroid').first.items![controller.selectedInsightTab].keys.map((e) => ChartData(x: e, y: double.parse(controller.insights.where((e) => e.name == 'thyroid').first.items![controller.selectedInsightTab][e].toString())))),
                                                                                  xValueMapper: (ChartData data, _) => data.x,
                                                                                  yValueMapper: (ChartData data, _) => data.y,
                                                                                )
                                                                              ]),
                                                                          Container(
                                                                            color:
                                                                                kcWhite,
                                                                            width:
                                                                                screen.width,
                                                                            height:
                                                                                65,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Obx(
                                                                                () => Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    ...List.generate(controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.length, (index) {
                                                                                      String item = controller.insights.where((e) => e.name == 'thyroid').first.items!.keys.elementAt(index);
                                                                                      return TabPillWidget(
                                                                                        label: "$item".capitalizeFirst.toString(),
                                                                                        onTap: () => controller.onTabSelected(item, 'thyroid'),
                                                                                        active: controller.selectedInsightTab == item,
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                                                child: SvgPicture.asset(
                                                                                  'assets/icons/info.svg',
                                                                                  color: kcBlack.withOpacity(0.65),
                                                                                  width: 20,
                                                                                  height: 20,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Flexible(flex: 1, child: Text("The chart below illustrates how frequently you submit Thyroid reports.")),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),

                                                            // AccordionSection(
                                                            //   //scrollIntoViewOfItems: ScrollIntoViewOfItems.values.last,
                                                            //   isOpen: false,
                                                            //   leftIcon: Image.asset(
                                                            //     'assets/images/lab.png',
                                                            //     color: kcWhite,
                                                            //     width: 16,
                                                            //     height: 16,
                                                            //   ),
                                                            //   header: Text(
                                                            //     'Urine Test',
                                                            //     style: TextStyle(color: kcWhite),
                                                            //   ),
                                                            //   onOpenSection: () => controller.onTabSelected(
                                                            //       '${controller.insights.where((e) => e.name == 'urineTest').first.items!.keys.first}',
                                                            //       'urineTest'),
                                                            //   // headerBackgroundColorOpened: Colors.black54,
                                                            //   contentBorderColor: Colors.black54,
                                                            //   headerBackgroundColorOpened: kcDanger,
                                                            //   content: Obx(
                                                            //     () => controller.selectedInsight != 'urineTest'  || controller.insights.where((e) => e.name== 'urineTest').first.items == null
                                                            //         ? Padding(
                                                            //           padding: const EdgeInsets.all(8.0),
                                                            //           child: Text('No Data Yet!'),
                                                            //         )
                                                            //         : Column(
                                                            //             children: [
                                                            //               SfCartesianChart(
                                                            //              enableAxisAnimation: true,
                                                            //                                                                           primaryXAxis: CategoryAxis(
                                                            //                                                                             labelStyle: TextStyle(fontSize: 12),
                                                            //                                                                             maximumLabels: 1000,
                                                            //                                                                             autoScrollingDelta: 4,
                                                            //                                                                             // majorGridLines: MajorGridLines(width: 0),
                                                            //                                                                             // majorTickLines: MajorTickLines(width: 0),
                                                            //                                                                           ),
                                                            //                                                                           primaryYAxis: CategoryAxis(),
                                                            //                                                                           zoomPanBehavior: ZoomPanBehavior(
                                                            //                                                                             enablePanning: true,
                                                            //                                                                           ),
                                                            //               series: <ChartSeries<ChartData, String>>[
                                                            //                 // Renders column chart
                                                            //                 LineSeries<ChartData, String>(
                                                            //                   dataSource: List<ChartData>.from(controller.insights
                                                            //                       .where((e) => e.name == 'urineTest')
                                                            //                       .first
                                                            //                       .items![controller.selectedInsightTab]
                                                            //                       .keys
                                                            //                       .map((e) => ChartData(
                                                            //                           x: e,
                                                            //                           y: double.parse(controller.insights
                                                            //                               .where((e) => e.name == 'urineTest')
                                                            //                               .first
                                                            //                               .items![controller.selectedInsightTab][e]
                                                            //                               .toString())))),
                                                            //                   xValueMapper: (ChartData data, _) => data.x,
                                                            //                   yValueMapper: (ChartData data, _) => data.y,
                                                            //                 )
                                                            //               ]),
                                                            //               Container(
                                                            //                 color: kcWhite,
                                                            //                 width: screen.width,
                                                            //                 height: 65,
                                                            //                 child: SingleChildScrollView(
                                                            //                   scrollDirection: Axis.horizontal,
                                                            //                   child: Obx(
                                                            //                     () => Row(
                                                            //                       mainAxisSize: MainAxisSize.min,
                                                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                            //                       mainAxisAlignment: MainAxisAlignment.start,
                                                            //                       children: [
                                                            //                         ...List.generate(
                                                            //                             controller.insights
                                                            //                                 .where((e) => e.name == 'urineTest')
                                                            //                                 .first
                                                            //                                 .items!
                                                            //                                 .keys
                                                            //                                 .length, (index) {
                                                            //                           String item = controller.insights
                                                            //                               .where((e) => e.name == 'urineTest')
                                                            //                               .first
                                                            //                               .items!
                                                            //                               .keys
                                                            //                               .elementAt(index);
                                                            //                           return TabPillWidget(
                                                            //                             label: "$item".capitalizeFirst.toString(),
                                                            //                             onTap: () => controller.onTabSelected(item, 'urineTest'),
                                                            //                             active: controller.selectedInsightTab == item,
                                                            //                           );
                                                            //                         }),
                                                            //                       ],
                                                            //                     ),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //               Row(
                                                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                            //                 mainAxisAlignment: MainAxisAlignment.start,
                                                            //                 children: [
                                                            //                   Padding(
                                                            //                     padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                                                            //                     child: SvgPicture.asset(
                                                            //                       'assets/icons/info.svg',
                                                            //                       color: kcBlack.withOpacity(0.65),
                                                            //                       width: 20,
                                                            //                       height: 20,
                                                            //                     ),
                                                            //                   ),
                                                            //                   SizedBox(
                                                            //                     width: 5,
                                                            //                   ),
                                                            //                   Flexible(
                                                            //                       flex: 1,
                                                            //                       child:
                                                            //                           Text("The chart below illustrates how frequently you submit Liver reports.")),
                                                            //                 ],
                                                            //               ),
                                                            //             ],
                                                            //           ),
                                                            //   ),
                                                            // ),
                                                            // AccordionSection(
                                                            //   isOpen: false,
                                                            //   leftIcon:
                                                            //   Image.asset('assets/images/test.png' , color: kcWhite,
                                                            //     width: 16,height: 16,),
                                                            //   header: Text('Other' ,style: TextStyle(color: kcWhite),),
                                                            //   // headerBackgroundColorOpened: Colors.black54,
                                                            //   contentBorderColor: Colors.black54,
                                                            //   headerBackgroundColorOpened: kcDanger,
                                                            //   content: Column(
                                                            //     children: [
                                                            //       SfCartesianChart(
                                                            //           primaryXAxis: CategoryAxis(),
                                                            //           series: <ChartSeries<ChartData, String>>[
                                                            //             // Renders column chart
                                                            //             LineSeries<ChartData, String>(
                                                            //                 dataSource: List<ChartData>.from(controller.insightData.other!.keys.map((e) => ChartData(x: e, y: double.parse(controller.insightData.other![e].toString())))),
                                                            //                 xValueMapper: (ChartData data, _) => data.x,
                                                            //                 yValueMapper: (ChartData data, _) => data.y
                                                            //             )
                                                            //           ]
                                                            //       ),
                                                            //       Row(
                                                            //         crossAxisAlignment: CrossAxisAlignment.start,
                                                            //         mainAxisAlignment: MainAxisAlignment.start,
                                                            //         children: [
                                                            //           Padding(
                                                            //             padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                                            //             child: SvgPicture.asset(
                                                            //               'assets/icons/info.svg', color: kcBlack.withOpacity(0.65),
                                                            //               width: 20,height: 20,
                                                            //             ),
                                                            //           ),
                                                            //           SizedBox(width: 5,),
                                                            //           Flexible(
                                                            //               flex:1,
                                                            //               child: Text("The chart below illustrates how frequently you submit Other reports.")),
                                                            //         ],
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 210,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 13,
                                                    vertical: 3),
                                                color:
                                                    kcWarning.withOpacity(0.2),
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
                                                        'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                          ],
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}

class ChartData {
  ChartData({required this.x, required this.y});

  final String x;
  final double y;
}
