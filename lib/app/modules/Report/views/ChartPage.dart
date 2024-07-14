import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/shared/views/widgets/LoadingWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';
import '../controllers/ChartController.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChartController(),
      builder: (ChartController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
            ? LoadingWidget(message: "Please wait...")
            : MasterLayout(
          title: 'Master Report',
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
                          description: "See all your blood reports in date wise tabular format, making it easy for comparison.",
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
            child: Obx(() =>
            controller.chartData.id == null
                ? SingleChildScrollView(
              child: Column(
                children: [
                  NoDataWidget(
                    message: "To create report, you need to upload documents first",
                    icon: SvgPicture.asset(
                      'assets/icons/layers.svg',
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: kcPrimary,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: screen.width * 0.52,
                          height: screen.height * 0.05,
                          child: Text(
                            "Start Uploading",
                            style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: kcDarkAlt),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/blogsHealthTips', parameters: {"healthTip_id": "12"});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: kcOffWhite,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: screen.width * 0.68,
                      height: screen.height * 0.05,
                      child: Text(
                        "How my report looks like".toUpperCase(),
                        style: TextStyl.bodySm?.copyWith(fontSize: 14, color: kcBlack, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    color: kcWarning.withOpacity(0.2),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/info.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
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
                : controller.chartData.chart == null && controller.chartData.id != null
                ? Center(
                child: Column(
                  children: [
                    NoDataWidget(
                      icon: SvgPicture.asset(
                        'assets/icons/layers.svg',
                        width: spacer8,
                        color: kcDarkAlt,
                      ),
                      message: "Your report is under creation",
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                      color: kcWarning.withOpacity(0.2),
                      width: screen.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/info.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
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
                ))
                : auth.user.subscription!.isTrial() || auth.user.subscription!.toDate!.isBefore(DateTime.now())
            // auth.user.subscription!.isTrial() && auth.user.subscription!.toDate!.isBefore(DateTime.now())
                ? Blur(
              // overlay: auth.user.subscription!.isTrial() || auth.user.subscription!.isExpired()
              //     ?
              overlay: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    style: TextStyl.bodySm?.copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: kcPrimary),
                  ),
                  Text(
                    "Subscribing to a plan unlocks this report",
                    style:
                    TextStyl.bodySm?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: kcDarkAlt.withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MirrorAnimationBuilder<double>(
                    tween: Tween(begin: -1, end: 2),
                    builder: (context, child, value) {
                      return Container(
                        width: 200,
                        height: 65,
                        child: Transform.translate(
                          offset: Offset(0, child),
                          child: IconButton(
                            icon: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //  border: Border.all(width: 1,color: kcPrimary),
                                color: kcGreen,
                              ),
                              child: Text(
                                'Take Subscription',
                                style: TextStyl.bodySm?.copyWith(color: kcWhite, fontWeight: FontWeight.w600),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed('/buyPlan');
                            },
                          ),
                        ),
                      );
                    },
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCubic,
                  ),
                ],
              ),
              // : SizedBox.shrink(),
              // blur: auth.user.subscription!.isTrial() || auth.user.subscription!.toDate!.isBefore(DateTime.now()) ? 2.5 : 0,
              blur: 2.5,
              blurColor: kcWhite,
              colorOpacity: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    color: kcWarning.withOpacity(0.2),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Last Update - ${Jiffy(controller.chartData.updatedAt).format('dd MMM, yyyy')}',
                          style: TextStyl.bodySm?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: kcWhite,
                    width: screen.width,
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: spacer, vertical: spacer3),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                            () =>
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/blood.png',
                                    color: controller.tabIndex == 0 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Blood Picture",
                                  onTap: () => controller.onTabChanged(0),
                                  active: controller.tabIndex == 0,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/liver.png',
                                    color: controller.tabIndex == 1 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Liver Function",
                                  onTap: () => controller.onTabChanged(1),
                                  active: controller.tabIndex == 1,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/kidney.png',
                                    color: controller.tabIndex == 2 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Kidney Function",
                                  onTap: () => controller.onTabChanged(2),
                                  active: controller.tabIndex == 2,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/no-fat.png',
                                    color: controller.tabIndex == 3 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Lipid Profile",
                                  onTap: () => controller.onTabChanged(3),
                                  active: controller.tabIndex == 3,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/diabetes.png',
                                    color: controller.tabIndex == 4 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Diabetes Screening",
                                  onTap: () => controller.onTabChanged(4),
                                  active: controller.tabIndex == 4,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/throat.png',
                                    color: controller.tabIndex == 5 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Thyroid Function",
                                  onTap: () => controller.onTabChanged(5),
                                  active: controller.tabIndex == 5,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/lab.png',
                                    color: controller.tabIndex == 6 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Urine Test",
                                  onTap: () => controller.onTabChanged(6),
                                  active: controller.tabIndex == 6,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/test.png',
                                    color: controller.tabIndex == 7 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Other",
                                  onTap: () => controller.onTabChanged(7),
                                  active: controller.tabIndex == 7,
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        controller.tabIndex == 0
                            ? Center(
                            child: Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    defaultColumnWidth: FixedColumnWidth(112.0),
                                    border: TableBorder.all(
                                        color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                            color: kcPrimary.withOpacity(0.7),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Date',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text(
                                                'Haemoglobin (Hb)',
                                                style: TextStyl.body?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: kcWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'WBC',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'RBC',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Platlets',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Retic count',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Hematocrit (Hct)',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'MCV',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                          ]),
                                      ...List.generate(controller.chartData.chart!['blood']!.length, (index) {
                                        Map<String, dynamic> blooddata = controller.chartData.chart!['blood']![index];
                                        return TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: blooddata['date'] == "null"
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text(
                                              '${blooddata['date']}',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['haemoglobin']}' == "null"
                                                  ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  : Text('${blooddata['haemoglobin']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['haemoglobin'].toString()) >= 12 &&
                                                          double.parse(blooddata['haemoglobin'].toString()) <= 15
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: '${blooddata['wbc']}' == "null"
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text('${blooddata['wbc']}',
                                                style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                    color: double.parse(blooddata['wbc'].toString()) >= 4000 &&
                                                        double.parse(blooddata['wbc'].toString()) <= 11000
                                                        ? kcBlack
                                                        : kcDanger)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: '${blooddata['rbc']}' == "null"
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text('${blooddata['rbc']}',
                                                style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                    color: double.parse(blooddata['rbc'].toString()) >= 4 &&
                                                        double.parse(blooddata['rbc'].toString()) <= 5.5
                                                        ? kcBlack
                                                        : kcDanger)),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['platlets']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['platlets']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['platlets'].toString()) >= 150000 &&
                                                          double.parse(blooddata['platlets'].toString()) <= 400000
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['retic']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['retic']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['retic'].toString()) >= 0.5 &&
                                                          double.parse(blooddata['retic'].toString()) <= 2.5
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['hematocrit']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['hematocrit']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['hematocrit'].toString()) >= 37 &&
                                                          double.parse(blooddata['hematocrit'].toString()) <= 47
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['mcv']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  :
                                              Text('${blooddata['mcv']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['mcv'].toString()) >= 83 &&
                                                          double.parse(blooddata['mcv'].toString()) <= 101
                                                          ? kcBlack
                                                          : kcDanger))),
                                        ]);
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ]))
                            : controller.tabIndex == 1
                            ? Center(
                          //liver
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Direct Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Indirect Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total protein',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Albumin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'SGOT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'SGPT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Alkaline Phosphatase (ALP)',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['liver']!.length, (index) {
                                          Map<String, dynamic> liverData = controller.chartData.chart!['liver']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['date']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                    ))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['tot Bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['tot Bili']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(liverData['tot Bili'].toString()) >= 0 &&
                                                            double.parse(liverData['tot Bili'].toString()) <= 1
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['direct bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['direct bili']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['direct bili'].toString()) >=
                                                          0 &&
                                                          double.parse(liverData['direct bili'].toString()) <=
                                                              0.4
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['indirect bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['indirect bili']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(liverData['indirect bili'].toString()) >=
                                                            0 &&
                                                            double.parse(liverData['indirect bili'].toString()) <=
                                                                0.6
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['protein']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['protein']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['protein'].toString()) >= 6.3 &&
                                                          double.parse(liverData['protein'].toString()) <= 8.3
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['albumin']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['albumin']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['albumin'].toString()) >= 3.6 &&
                                                          double.parse(liverData['albumin'].toString()) <= 4.5
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['ast']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['ast']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['ast'].toString()) >= 0 &&
                                                          double.parse(liverData['ast'].toString()) <= 40
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['alt']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['alt']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['alt'].toString()) >= 10 &&
                                                          double.parse(liverData['alt'].toString()) <= 40
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['alp']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['alp']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['alp'].toString()) >= 40 &&
                                                          double.parse(liverData['alp'].toString()) <= 140
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 2
                            ? Center(
                          // Kidney
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Urea',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Creatinine',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'BUN',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Sodium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Potassium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Calcium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'uric acid',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['kidney']!.length, (index) {
                                          Map<String, dynamic> kidneyData =
                                          controller.chartData.chart!['kidney']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${kidneyData['date']}',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['urea']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['urea']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['urea'].toString()) >=
                                                            15 &&
                                                            double.parse(kidneyData['urea'].toString()) <= 40
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['creatinine']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['creatinine']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(
                                                            kidneyData['creatinine'].toString()) >=
                                                            0.5 &&
                                                            double.parse(
                                                                kidneyData['creatinine'].toString()) <=
                                                                1.2
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['bun']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['bun']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['bun'].toString()) >= 6 &&
                                                            double.parse(kidneyData['bun'].toString()) <= 24
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['sodium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['sodium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['sodium'].toString()) >=
                                                            135 &&
                                                            double.parse(kidneyData['sodium'].toString()) <=
                                                                145
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['potassium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['potassium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['potassium'].toString()) >=
                                                            3 &&
                                                            double.parse(
                                                                kidneyData['potassium'].toString()) <=
                                                                5.5
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['calcium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['calcium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['calcium'].toString()) >=
                                                            8.5 &&
                                                            double.parse(kidneyData['calcium'].toString()) <=
                                                                10.2
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['uric']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['uric']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['uric'].toString()) >=
                                                            1.3 &&
                                                            double.parse(kidneyData['uric'].toString()) <= 6
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 3
                            ? Center(
                          // lipid
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total Cholesterol',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Triglyceride',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'HDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'LDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'VLDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'LDL/ HDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['lipid']!.length, (index) {
                                          Map<String, dynamic> lipidData =
                                          controller.chartData.chart!['lipid']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${lipidData['date']}',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['cholesterol']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['cholesterol']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['cholesterol']
                                                            .toString()) >=
                                                            0 &&
                                                            double.parse(lipidData['cholesterol']
                                                                .toString()) <=
                                                                200
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['triglyceride']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['triglyceride']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['triglyceride']
                                                            .toString()) >=
                                                            25 &&
                                                            double.parse(lipidData['triglyceride']
                                                                .toString()) <=
                                                                175
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['hdl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['hdl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['hdl'].toString()) >=
                                                            60 &&
                                                            double.parse(lipidData['hdl'].toString()) <=
                                                                1000
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['ldl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['ldl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['ldl'].toString()) >=
                                                            0 &&
                                                            double.parse(lipidData['ldl'].toString()) <=
                                                                100
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['vldl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['vldl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['vldl'].toString()) >=
                                                            7 &&
                                                            double.parse(lipidData['vldl'].toString()) <=
                                                                35
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['ldl-hdl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['ldl-hdl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(
                                                            lipidData['ldl-hdl'].toString()) >=
                                                            0.5 &&
                                                            double.parse(
                                                                lipidData['ldl-hdl'].toString()) <=
                                                                3
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 4
                            ? Center(
                          // diabetes
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'FBS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'PP2BS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'RBS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'OGT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'HbA1c',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['diabetes']!.length,
                                                (index) {
                                              Map<String, dynamic> diabetesData =
                                              controller.chartData.chart!['diabetes']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${diabetesData['date']}',
                                                      style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['fbs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['fbs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['fbs'].toString()) >=
                                                                60 &&
                                                                double.parse(
                                                                    diabetesData['fbs'].toString()) <=
                                                                    126
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['pp2bs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['pp2bs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(diabetesData['pp2bs']
                                                                .toString()) >=
                                                                60 &&
                                                                double.parse(diabetesData['pp2bs']
                                                                    .toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['rbs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['rbs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['rbs'].toString()) >=
                                                                60 &&
                                                                double.parse(
                                                                    diabetesData['rbs'].toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['ogt']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['ogt']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['ogt'].toString()) >=
                                                                0 &&
                                                                double.parse(
                                                                    diabetesData['ogt'].toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['hba1c']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['hba1c']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(diabetesData['hba1c']
                                                                .toString()) >=
                                                                4.8 &&
                                                                double.parse(diabetesData['hba1c']
                                                                    .toString()) <=
                                                                    6.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 5
                            ? Center(
                          // thyroid
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'TSH',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'T3',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'T4',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Free T3',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Free T4',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'TBG',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Anti TPO',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['thyroid']!.length,
                                                (index) {
                                              Map<String, dynamic> thyroidData =
                                              controller.chartData.chart!['thyroid']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${thyroidData['date']}',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['tsh']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['tsh']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['tsh']
                                                                .toString()) >=
                                                                0.4 &&
                                                                double.parse(thyroidData['tsh']
                                                                    .toString()) <=
                                                                    5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['t3']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['t3']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['t3']
                                                                .toString()) >=
                                                                70 &&
                                                                double.parse(thyroidData['t3']
                                                                    .toString()) <=
                                                                    204
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['t4']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['t4']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['t4']
                                                                .toString()) >=
                                                                4.8 &&
                                                                double.parse(thyroidData['t4']
                                                                    .toString()) <=
                                                                    13.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['freet3']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['freet3']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['freet3']
                                                                .toString()) >=
                                                                2.1 &&
                                                                double.parse(thyroidData['freet3']
                                                                    .toString()) <=
                                                                    4.4
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['freet4']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['freet4']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['freet4']
                                                                .toString()) >=
                                                                0.9 &&
                                                                double.parse(thyroidData['freet4']
                                                                    .toString()) <=
                                                                    2.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['tbg']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['tbg']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['tbg']
                                                                .toString()) >=
                                                                1.5 &&
                                                                double.parse(thyroidData['tbg']
                                                                    .toString()) <=
                                                                    3.4
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['anti tpo']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['anti tpo']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['anti tpo']
                                                                .toString()) >=
                                                                0 &&
                                                                double.parse(thyroidData['anti tpo']
                                                                    .toString()) <=
                                                                    0.8
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 6
                            ? Center(
                          // urineTest
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'PH',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Color',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Sugar',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Ketones',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Protein',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Pus cells',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Cast',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Epithelial cell',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(
                                            controller.chartData.chart!['urineTest']!.length,
                                                (index) {
                                              Map<String, dynamic> urineTestData =
                                              controller.chartData.chart!['urineTest']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${urineTestData['date']}',
                                                      style:
                                                      TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['ph']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['ph']}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(fontSize: 13, color: kcBlack))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['color']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['color']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                          fontSize: 13,
                                                          // color:  double.parse(urineTestData['color'].toString()) >=
                                                          // 4.6 && double.parse(urineTestData['color'].toString()) <= 8 ? kcBlack : kcDanger
                                                        ))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['sugar']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['sugar']}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(fontSize: 13, color: kcBlack))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['ketones']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['ketones']}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(fontSize: 13, color: kcBlack))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['protein']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${urineTestData['protein']}',
                                                      style: TextStyl.bodySm
                                                          ?.copyWith(fontSize: 13, color: kcBlack),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['puscells']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['puscells']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                urineTestData['puscells']
                                                                    .toString()) >=
                                                                1 &&
                                                                double.parse(
                                                                    urineTestData['puscells']
                                                                        .toString()) <=
                                                                    5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['cast']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['cast']}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(fontSize: 13, color: kcBlack))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${urineTestData['epithelial']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${urineTestData['epithelial']}',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(fontSize: 13, color: kcBlack))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : Center(
                          //others
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(125.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Name',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Result',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['other']!.length,
                                                (index) {
                                              Map<String, dynamic> otherData =
                                              controller.chartData.chart!['other']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${otherData['date']}',
                                                      style:
                                                      TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['name']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${otherData['name']}',
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['result']}' == "null"
                                                        ? Text("N/A",
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${otherData['result']}',
                                                        style:
                                                        TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            )),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    color: kcWarning.withOpacity(0.2),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/info.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
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
                  )
                ],
              ),
            )
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    color: kcWarning.withOpacity(0.2),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Last Update - ${Jiffy(controller.chartData.updatedAt).format('dd MMM, yyyy')}',
                          style: TextStyl.bodySm?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.chartData.remark != null)
                    SizedBox(
                      height: 15,
                    ),
                  if (controller.chartData.remark != null)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
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
                                margin: EdgeInsets.symmetric(horizontal: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'DQ Care Support',
                                    style: TextStyl.bodySm?.copyWith(fontSize: 16, color: kcWhite, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Sent you a message',
                                    style: TextStyl.bodySm?.copyWith(fontSize: 11, color: kcWhite, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(13),
                                bottomLeft: Radius.circular(13),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kcDarkAlt.withOpacity(0.5),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${controller.chartData.remark}",
                                textAlign: TextAlign.start,
                                style: TextStyl.body?.copyWith(fontSize: 14, color: kcBlack),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (controller.chartData.remark != null)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    color: kcWhite,
                    width: screen.width,
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: spacer, vertical: spacer3),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                            () =>
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/blood.png',
                                    color: controller.tabIndex == 0 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Blood Picture",
                                  onTap: () => controller.onTabChanged(0),
                                  active: controller.tabIndex == 0,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/liver.png',
                                    color: controller.tabIndex == 1 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Liver Function",
                                  onTap: () => controller.onTabChanged(1),
                                  active: controller.tabIndex == 1,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/kidney.png',
                                    color: controller.tabIndex == 2 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Kidney Function",
                                  onTap: () => controller.onTabChanged(2),
                                  active: controller.tabIndex == 2,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/no-fat.png',
                                    color: controller.tabIndex == 3 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Lipid Profile",
                                  onTap: () => controller.onTabChanged(3),
                                  active: controller.tabIndex == 3,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/diabetes.png',
                                    color: controller.tabIndex == 4 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Diabetes Screening",
                                  onTap: () => controller.onTabChanged(4),
                                  active: controller.tabIndex == 4,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/throat.png',
                                    color: controller.tabIndex == 5 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Thyroid Function",
                                  onTap: () => controller.onTabChanged(5),
                                  active: controller.tabIndex == 5,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/lab.png',
                                    color: controller.tabIndex == 6 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Urine Test",
                                  onTap: () => controller.onTabChanged(6),
                                  active: controller.tabIndex == 6,
                                ),
                                TabPillWidget(
                                  image: Image.asset(
                                    'assets/images/test.png',
                                    color: controller.tabIndex == 7 ? kcWhite : kcDark,
                                    width: 16,
                                    height: 16,
                                  ),
                                  label: "Other",
                                  onTap: () => controller.onTabChanged(7),
                                  active: controller.tabIndex == 7,
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        controller.tabIndex == 0
                            ? Center(
                            child: Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    defaultColumnWidth: FixedColumnWidth(112.0),
                                    border:
                                    TableBorder.all(color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                            color: kcPrimary.withOpacity(0.7),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Date',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text(
                                                'Haemoglobin (Hb)',
                                                style: TextStyl.body?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: kcWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'WBC',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'RBC',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Platlets',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Retic count',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Hematocrit (Hct)',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                            Padding(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'MCV',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                          ]),
                                      ...List.generate(controller.chartData.chart!['blood']!.length, (index) {
                                        Map<String, dynamic> blooddata = controller.chartData.chart!['blood']![index];
                                        return TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: blooddata['date'] == null
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text(
                                              '${blooddata['date']}',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['haemoglobin']}' == "null"
                                                  ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  : Text('${blooddata['haemoglobin']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['haemoglobin'].toString()) >= 12 &&
                                                          double.parse(blooddata['haemoglobin'].toString()) <= 15
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: '${blooddata['wbc']}' == "null"
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text('${blooddata['wbc']}',
                                                style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                    color: double.parse(blooddata['wbc'].toString()) >= 4000 &&
                                                        double.parse(blooddata['wbc'].toString()) <= 11000
                                                        ? kcBlack
                                                        : kcDanger)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: '${blooddata['rbc']}' == "null"
                                                ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                : Text('${blooddata['rbc']}',
                                                style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                    color: double.parse(blooddata['rbc'].toString()) >= 4 &&
                                                        double.parse(blooddata['rbc'].toString()) <= 5.5
                                                        ? kcBlack
                                                        : kcDanger)),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['platlets']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['platlets']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['platlets'].toString()) >= 150000 &&
                                                          double.parse(blooddata['platlets'].toString()) <= 400000
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['retic']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['retic']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['retic'].toString()) >= 0.5 &&
                                                          double.parse(blooddata['retic'].toString()) <= 2.5
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['hematocrit']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['hematocrit']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['hematocrit'].toString()) >= 37 &&
                                                          double.parse(blooddata['hematocrit'].toString()) <= 47
                                                          ? kcBlack
                                                          : kcDanger))),
                                          Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: '${blooddata['mcv']}' == "null"
                                                  ? Text("N/A",
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 13,
                                                  ))
                                                  : Text('${blooddata['mcv']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(blooddata['mcv'].toString()) >= 83 &&
                                                          double.parse(blooddata['mcv'].toString()) <= 101
                                                          ? kcBlack
                                                          : kcDanger))),
                                        ]);
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ]))
                            : controller.tabIndex == 1
                            ? controller.chartData.chart!['liver'] == null
                            ? Center(
                            child: NoDataWidget(message: 'No Liver Data Found!', icon: Image.asset('assets/images/liver.png', height: 35, width: 35,)))
                            : Center(
                          //liver
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Direct Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Indirect Bilirubin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total protein',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Albumin',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'SGOT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'SGPT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Alkaline Phosphatase (ALP)',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['liver']!.length, (index) {
                                          Map<String, dynamic> liverData = controller.chartData.chart!['liver']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['date']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                    ))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['tot Bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['tot Bili']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(liverData['tot Bili'].toString()) >= 0 &&
                                                            double.parse(liverData['tot Bili'].toString()) <= 1
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['direct bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['direct bili']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['direct bili'].toString()) >= 0 &&
                                                          double.parse(liverData['direct bili'].toString()) <= 0.4
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['indirect bili']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${liverData['indirect bili']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(liverData['indirect bili'].toString()) >=
                                                            0 &&
                                                            double.parse(liverData['indirect bili'].toString()) <=
                                                                0.6
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['protein']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['protein']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['protein'].toString()) >= 6.3 &&
                                                          double.parse(liverData['protein'].toString()) <= 8.3
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['albumin']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['albumin']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['albumin'].toString()) >= 3.6 &&
                                                          double.parse(liverData['albumin'].toString()) <= 4.5
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['ast']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['ast']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['ast'].toString()) >= 0 &&
                                                          double.parse(liverData['ast'].toString()) <= 40
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['alt']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['alt']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['alt'].toString()) >= 10 &&
                                                          double.parse(liverData['alt'].toString()) <= 40
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${liverData['alp']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${liverData['alp']}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      color: double.parse(liverData['alp'].toString()) >= 40 &&
                                                          double.parse(liverData['alp'].toString()) <= 140
                                                          ? kcBlack
                                                          : kcDanger),
                                                )
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 2
                            ? Center(
                          // Kidney
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Urea',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Creatinine',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'BUN',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Sodium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Potassium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Calcium',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'uric acid',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['kidney']!.length, (index) {
                                          Map<String, dynamic> kidneyData =
                                          controller.chartData.chart!['kidney']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${kidneyData['date']}',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['urea']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['urea']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['urea'].toString()) >= 15 &&
                                                            double.parse(kidneyData['urea'].toString()) <= 40
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['creatinine']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['creatinine']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['creatinine'].toString()) >=
                                                            0.5 &&
                                                            double.parse(kidneyData['creatinine'].toString()) <=
                                                                1.2
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['bun']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['bun']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['bun'].toString()) >= 6 &&
                                                            double.parse(kidneyData['bun'].toString()) <= 24
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['sodium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['sodium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['sodium'].toString()) >=
                                                            135 &&
                                                            double.parse(kidneyData['sodium'].toString()) <= 145
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['potassium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['potassium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['potassium'].toString()) >=
                                                            3 &&
                                                            double.parse(kidneyData['potassium'].toString()) <=
                                                                5.5
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['calcium']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['calcium']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['calcium'].toString()) >=
                                                            8.5 &&
                                                            double.parse(kidneyData['calcium'].toString()) <=
                                                                10.2
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${kidneyData['uric']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${kidneyData['uric']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(kidneyData['uric'].toString()) >= 1.3 &&
                                                            double.parse(kidneyData['uric'].toString()) <= 6
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 3
                            ? Center(
                          // lipid
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Total Cholesterol',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Triglyceride',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'HDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'LDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'VLDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'LDL/ HDL',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['lipid']!.length, (index) {
                                          Map<String, dynamic> lipidData =
                                          controller.chartData.chart!['lipid']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['date']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${lipidData['date']}',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['cholesterol']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['cholesterol']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(
                                                            lipidData['cholesterol'].toString()) >=
                                                            0 &&
                                                            double.parse(
                                                                lipidData['cholesterol'].toString()) <=
                                                                200
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['triglyceride']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['triglyceride']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(
                                                            lipidData['triglyceride'].toString()) >=
                                                            25 &&
                                                            double.parse(
                                                                lipidData['triglyceride'].toString()) <=
                                                                175
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['hdl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['hdl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color:
                                                        double.parse(lipidData['hdl'].toString()) >= 60 &&
                                                            double.parse(lipidData['hdl'].toString()) <=
                                                                1000
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['ldl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['ldl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['ldl'].toString()) >= 0 &&
                                                            double.parse(lipidData['ldl'].toString()) <= 100
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['vldl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['vldl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['vldl'].toString()) >=
                                                            7 &&
                                                            double.parse(lipidData['vldl'].toString()) <= 35
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${lipidData['ldl-hdl']}' == "null"
                                                    ? Text("N/A", style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${lipidData['ldl-hdl']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(lipidData['ldl-hdl'].toString()) >=
                                                            0.5 &&
                                                            double.parse(lipidData['ldl-hdl'].toString()) <=
                                                                3
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 4
                            ? Center(
                          // diabetes
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'FBS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'PP2BS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'RBS',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'OGT',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'HbA1c',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['diabetes']!.length,
                                                (index) {
                                              Map<String, dynamic> diabetesData =
                                              controller.chartData.chart!['diabetes']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${diabetesData['date']}',
                                                      style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['fbs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['fbs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['fbs'].toString()) >=
                                                                60 &&
                                                                double.parse(
                                                                    diabetesData['fbs'].toString()) <=
                                                                    126
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['pp2bs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['pp2bs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['pp2bs'].toString()) >=
                                                                60 &&
                                                                double.parse(
                                                                    diabetesData['pp2bs'].toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['rbs']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['rbs']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['rbs'].toString()) >=
                                                                60 &&
                                                                double.parse(
                                                                    diabetesData['rbs'].toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['ogt']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['ogt']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['ogt'].toString()) >=
                                                                0 &&
                                                                double.parse(
                                                                    diabetesData['ogt'].toString()) <=
                                                                    200
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${diabetesData['hba1c']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${diabetesData['hba1c']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                diabetesData['hba1c'].toString()) >=
                                                                4.8 &&
                                                                double.parse(
                                                                    diabetesData['hba1c'].toString()) <=
                                                                    6.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 5
                            ? Center(
                          // thyroid
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'TSH',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'T3',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'T4',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Free T3',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Free T4',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'TBG',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Anti TPO',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['thyroid']!.length,
                                                (index) {
                                              Map<String, dynamic> thyroidData =
                                              controller.chartData.chart!['thyroid']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${thyroidData['date']}',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['tsh']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['tsh']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['tsh']
                                                                .toString()) >=
                                                                0.4 &&
                                                                double.parse(thyroidData['tsh']
                                                                    .toString()) <=
                                                                    5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['t3']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['t3']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                thyroidData['t3'].toString()) >=
                                                                70 &&
                                                                double.parse(
                                                                    thyroidData['t3'].toString()) <=
                                                                    204
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['t4']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['t4']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(
                                                                thyroidData['t4'].toString()) >=
                                                                4.8 &&
                                                                double.parse(
                                                                    thyroidData['t4'].toString()) <=
                                                                    13.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['freet3']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['freet3']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['freet3']
                                                                .toString()) >=
                                                                2.1 &&
                                                                double.parse(thyroidData['freet3']
                                                                    .toString()) <=
                                                                    4.4
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['freet4']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['freet4']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['freet4']
                                                                .toString()) >=
                                                                0.9 &&
                                                                double.parse(thyroidData['freet4']
                                                                    .toString()) <=
                                                                    2.5
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['tbg']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['tbg']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['tbg']
                                                                .toString()) >=
                                                                1.5 &&
                                                                double.parse(thyroidData['tbg']
                                                                    .toString()) <=
                                                                    3.4
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${thyroidData['anti tpo']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${thyroidData['anti tpo']}',
                                                        style: TextStyl.bodySm?.copyWith(
                                                            fontSize: 13,
                                                            color: double.parse(thyroidData['anti tpo']
                                                                .toString()) >=
                                                                0 &&
                                                                double.parse(thyroidData['anti tpo']
                                                                    .toString()) <=
                                                                    0.8
                                                                ? kcBlack
                                                                : kcDanger))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : controller.tabIndex == 6
                            ? Center(
                          // urineTest
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(115.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'PH',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Color',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Sugar',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Ketones',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Protein',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Pus cells',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Cast',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Epithelial cell',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(
                                            controller.chartData.chart!['urineTest']!.length, (index) {
                                          Map<String, dynamic> urineTestData =
                                          controller.chartData.chart!['urineTest']![index];
                                          return TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['date']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text(
                                                  '${urineTestData['date']}',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['ph']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['ph']}',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(fontSize: 13, color: kcBlack))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['color']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['color']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 13,
                                                      // color:  double.parse(urineTestData['color'].toString()) >=
                                                      // 4.6 && double.parse(urineTestData['color'].toString()) <= 8 ? kcBlack : kcDanger
                                                    ))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['sugar']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['sugar']}',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(fontSize: 13, color: kcBlack))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['ketones']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['ketones']}',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(fontSize: 13, color: kcBlack))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['protein']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['protein']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: kcBlack
                                                    ))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['puscells']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['puscells']}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                        fontSize: 13,
                                                        color: double.parse(
                                                            urineTestData['puscells']
                                                                .toString()) >=
                                                            1 &&
                                                            double.parse(
                                                                urineTestData['puscells']
                                                                    .toString()) <=
                                                                5
                                                            ? kcBlack
                                                            : kcDanger))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['cast']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['cast']}',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(fontSize: 13, color: kcBlack))
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                '${urineTestData['epithelial']}' == "null"
                                                    ? Text("N/A",
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                    : Text('${urineTestData['epithelial']}',
                                                    style: TextStyl.bodySm
                                                        ?.copyWith(fontSize: 13, color: kcBlack))
                                              ]),
                                            ),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ))
                            : Center(
                          //others
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(125.0),
                                      border: TableBorder.all(
                                          color: kcDarkAlt.withOpacity(0.4),
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: kcPrimary.withOpacity(0.7),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Date',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Name',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Result',
                                                      style: TextStyl.body?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: kcWhite,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                              ),
                                            ]),
                                        ...List.generate(controller.chartData.chart!['other']!.length,
                                                (index) {
                                              Map<String, dynamic> otherData =
                                              controller.chartData.chart!['other']![index];
                                              return TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['date']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text(
                                                      '${otherData['date']}',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['name']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${otherData['name']}',
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(children: [
                                                    '${otherData['result']}' == "null"
                                                        ? Text("N/A",
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                        : Text('${otherData['result']}',
                                                        style: TextStyl.bodySm?.copyWith(fontSize: 13))
                                                  ]),
                                                ),
                                              ]);
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    color: kcWarning.withOpacity(0.2),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/info.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            'Reference range values may differ according to Age, Gender and laboratory methods.\nFor more accurate information kindly refer to original reports.',
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
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
