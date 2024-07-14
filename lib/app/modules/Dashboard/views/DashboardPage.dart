import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/ExitPopup.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/DashboardController.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DashboardController(),
        builder: (DashboardController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingIconWidget(message: "Please wait...")
                  : WillPopScope(
                      onWillPop: () => showExitPopup(context),
                      child: DefaultTabController(
                          initialIndex: controller.tabIndex,
                          length: 0,
                          child: Scaffold(
                            body: Obx(
                                () => controller.pageList[controller.tabIndex]),
                            floatingActionButton: FloatingActionButton(
                              shape: CircleBorder(),
                              elevation: 1.0,
                              // child: SvgPicture.asset(
                              //   'assets/icons/cloud-upload.svg',
                              //   color: kcWhite,
                              // ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.cloudArrowUp,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: kcPrimary,
                              onPressed: () {
                                Get.toNamed('/upload');
                              },
                            ),
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.centerDocked,
                            bottomNavigationBar: BottomAppBar(
                              padding: EdgeInsets.zero,
                              notchMargin: 10,
                              color: kcWhite,
                              shape: CircularNotchedRectangle(),
                              child: Container(
                                width: screen.width,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: kcWhite,
                                  boxShadow: [
                                    BoxShadow(
                                        color: kcBlack.withOpacity(0.15),
                                        blurRadius: 12,
                                        spreadRadius: -1),
                                  ],
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              controller.onTabChanged(0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: controller.tabIndex == 0
                                                ? Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/images/house.svg',
                                                      //   width: 20,
                                                      //   height: 20,
                                                      //   color: kcPrimary,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons.house,
                                                        color: kcPrimary,
                                                        // size: screen.width/100*6,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Home",
                                                        style: TextStyle(
                                                            color: kcPrimary,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/images/home.svg',
                                                      //   color: kcBlack
                                                      //       .withOpacity(0.5),
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons.house,
                                                        color: kcBlack
                                                            .withOpacity(0.25),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Home",
                                                        style: TextStyle(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.onTabChanged(1),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: controller.tabIndex == 1
                                                ? Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/doctordark.svg',
                                                      //   width: 20,
                                                      //   height: 20,
                                                      //   color: kcPrimary,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .userDoctor,
                                                        color: kcPrimary,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Doctors",
                                                        style: TextStyle(
                                                            color: kcPrimary,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/doctor.svg',
                                                      //   color: kcBlack
                                                      //       .withOpacity(0.5),
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .userDoctor,
                                                        color: kcBlack
                                                            .withOpacity(0.25),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Doctors",
                                                        style: TextStyle(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                        Text(''),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.onTabChanged(2),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: controller.tabIndex == 2
                                                ? Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/dark-hand-holding-heart.svg',
                                                      //   color: kcPrimary,
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .solidLightbulb,
                                                        color: kcPrimary,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Health Tips",
                                                        style: TextStyle(
                                                            color: kcPrimary,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/hand-holding-heart.svg',
                                                      //   color: kcBlack
                                                      //       .withOpacity(0.5),
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .solidLightbulb,
                                                        color: kcBlack
                                                            .withOpacity(0.25),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "Health Tips",
                                                        style: TextStyle(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.onTabChanged(3),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 11),
                                            child: controller.tabIndex == 3
                                                ? Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/menu-burgerdark.svg',
                                                      //   color: kcPrimary,
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons.bars,
                                                        color: kcPrimary,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "More",
                                                        style: TextStyle(
                                                            color: kcPrimary,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      // SvgPicture.asset(
                                                      //   'assets/icons/menu-burger.svg',
                                                      //   color: kcBlack
                                                      //       .withOpacity(0.5),
                                                      //   width: 20,
                                                      //   height: 20,
                                                      // ),
                                                      FaIcon(
                                                        FontAwesomeIcons.bars,
                                                        color: kcBlack
                                                            .withOpacity(0.25),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        "More",
                                                        style: TextStyle(
                                                            color: kcBlack
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    );
        });
  }
}
