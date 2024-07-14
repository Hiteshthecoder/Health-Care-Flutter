import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingIconWidget.dart';
import '../controllers/SettingController.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (SettingController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
                ? LoadingIconWidget(message: "Please wait...")
                : MasterLayout(
                    title: "Settings",
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
                                  Dialog(
                                    child: Container(
                                      width: 500,
                                      margin: EdgeInsets.only(
                                          left: 0.0, right: 0.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Text(
                                                  "Title here ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: spacer2,
                                                ),
                                                Text(
                                                    "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients. ")
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0.0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: CircleAvatar(
                                                  radius: 14.0,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  barrierDismissible: false,
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/contact.svg',
                                color: kcWhite,
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
                    body: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: kcDGreen.withOpacity(0.75),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        'assets/images/referralnav.svg',
                                        color: kcWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Account ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Manage Your Account Details",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: kcBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed('/bmicalculator');
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: kcBlack.withOpacity(0.05),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 0.75,
                                margin: EdgeInsets.all(5),
                                color: kcWhite,
                                child: Container(
                                  width: 400,
                                  height: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Doctor's Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                        Divider(),
                                        Text(
                                          "Phone No.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: kcBlack.withOpacity(0.6)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "8180929653",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: kcDGreen.withOpacity(0.75),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        'assets/images/referralnav.svg',
                                        color: kcWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Profile Setup",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Manage Your Experience Details",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: kcBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: kcBlack.withOpacity(0.05), width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0.75,
                              margin: EdgeInsets.all(5),
                              color: kcWhite,
                              child: Container(
                                width: 400,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              "Experience",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 20,
                                              color: kcBlack.withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              "Details",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 20,
                                              color: kcBlack.withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: kcDGreen.withOpacity(0.75),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        'assets/images/referralnav.svg',
                                        color: kcWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Get Support",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "We're here to help you",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: kcBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: kcBlack.withOpacity(0.05), width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0.75,
                              margin: EdgeInsets.all(5),
                              color: kcWhite,
                              child: Container(
                                width: 400,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              "Get Support via Email",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 20,
                                              color: kcBlack.withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              "Get Support via Call",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 20,
                                              color: kcBlack.withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "App Version - 4.9 ",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: kcBlack.withOpacity(0.6),
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                height: 40,
                                width: 150,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          kcPrimary.withOpacity(0.5),
                                    ),
                                    onPressed: () {
                                      Get.toNamed('/otpVerify');
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text("LOGOUT"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.logout_outlined),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
