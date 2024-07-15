import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/HelperWidget.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../../../shared/views/widgets/NoDataWidget.dart';
import '../controllers/MyJourneyController.dart';

class MyJourneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyJourneyController(),
      builder: (MyJourneyController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingWidget(message: "Please wait...")
                : MasterLayout(
                    title: 'Medical Journey',
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
                                        "Medical Journey is a detailed description of your medical history created to give detailed view about your health.",
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
                      child: controller.journeyData.id == null
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  NoDataWidget(
                                    message: "To create journey, you need to upload documents first",
                                    icon: SvgPicture.asset(
                                      'assets/icons/notebook.svg',
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
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
                                      Get.toNamed('/blogsHealthTips', parameters: {"healthTip_id": "11"});
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
                                        "How my journey looks like".toUpperCase(),
                                        style: TextStyl.bodySm
                                            ?.copyWith(fontSize: 14, color: kcBlack, fontWeight: FontWeight.w600),
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
                                            'Journey is created according to documents provided. For more accurate information kindly refer to original file.',
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
                          : controller.journeyData.id != null && controller.journeyData.journey == null
                              ? Center(
                                  child: Column(
                                    children: [
                                      NoDataWidget(
                                        icon: SvgPicture.asset(
                                          'assets/icons/notebook.svg',
                                          width: spacer8,
                                          color: kcDarkAlt,
                                        ),
                                        message: "Your journey is under creation",
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
                                                'Journey is created according to documents provided. For more accurate information kindly refer to original file.',
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
                              : auth.user.subscription!.isTrial() ||
                                      auth.user.subscription!.toDate!.isBefore(DateTime.now())
                                  ? Blur(
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
                                            style: TextStyl.bodySm
                                                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: kcPrimary),
                                          ),
                                          Text(
                                            "Subscribing to a plan unlocks this report",
                                            style: TextStyl.bodySm?.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: kcDarkAlt.withOpacity(0.6)),
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
                                                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        //  border: Border.all(width: 1,color: kcPrimary),
                                                        color: kcGreen,
                                                      ),
                                                      child: Text(
                                                        'Take Subscription',
                                                        style: TextStyl.bodySm
                                                            ?.copyWith(color: kcWhite, fontWeight: FontWeight.w600),
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
                                      blur: 2.5,
                                      blurColor: kcWhite,
                                      colorOpacity: 0.5,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                                    'Last Update - ${Jiffy(controller.journeyData.updatedAt).format('dd MMM, yyyy')}',
                                                    style: TextStyl.bodySm?.copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: spacer4, vertical: 0),
                                              child: Text(
                                                'Journey',
                                                style: TextStyl.title?.copyWith(fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: spacer2),
                                                child: HtmlWidget(controller.journeyData.journey)),
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
                                                      'Journey is created according to documents provided. For more accurate information kindly refer to original file.',
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
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
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
                                                  'Last Update - ${Jiffy(controller.journeyData.updatedAt).format('dd MMM, yyyy')}',
                                                  style: TextStyl.bodySm?.copyWith(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (controller.journeyData.remark != null)
                                            SizedBox(
                                              height: 15,
                                            ),
                                          if (controller.journeyData.remark != null)
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
                                                            style: TextStyl.bodySm?.copyWith(
                                                                fontSize: 16,
                                                                color: kcWhite,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                          Text(
                                                            'Sent you a message',
                                                            style: TextStyl.bodySm?.copyWith(
                                                                fontSize: 11,
                                                                color: kcWhite,
                                                                fontWeight: FontWeight.w600),
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
                                                        "${controller.journeyData.remark}",
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
                                          if (controller.journeyData.remark != null)
                                            SizedBox(
                                              height: 10,
                                            ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: spacer4, vertical: 0),
                                            child: Text(
                                              'Journey',
                                              style: TextStyl.title?.copyWith(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: spacer2),
                                              child: HtmlWidget(controller.journeyData.journey)),
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
                                                    'Journey is created according to documents provided. For more accurate information kindly refer to original file.',
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
                                    ),
                    ),
                  );
      },
    );
  }
}
