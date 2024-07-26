import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/controllers/aabha1Controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaPhoneScreen extends StatelessWidget {
  const AbhaPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: aabha1Controller(),
      builder: (aabha1Controller controller) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                iconSize: 34,
                icon: Icon(Icons.close),
              ),
              Padding(
                padding: EdgeInsets.only(right: spacer2),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacer3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/newImages/aabha_phone.png",
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer5,
                ),
                Text(
                  "Abha Will Send You 6 Digit Code to Verify Your Mobile Number",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: spacer3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        cursorColor: Color(0xFF6666FF),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: kcBlack, fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "+91",
                          hintStyle: TextStyle(color: kcGray, fontSize: 12),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        cursorColor: Color(0xFF6666FF),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: kcDark,
                        ),
                        decoration: InputDecoration(
                          hintText: "9999999999",
                          hintStyle: TextStyle(color: kcGray, fontSize: 12),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5)),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Checkbox(
                          value: controller.abhaHealthLockerCheckValue.value,
                          fillColor: WidgetStatePropertyAll(Colors.transparent),
                          activeColor: Color.fromRGBO(102, 102, 255, 1),
                          checkColor: Color.fromRGBO(102, 102, 255, 1),
                          side: BorderSide(
                            color: Color(0xFF6666FF),
                            width: 2,
                          ),
                          onChanged: (value) =>
                              controller.changeAbhaHealthLockerCheckValue(),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Wrap(
                          children: [
                            Text(
                              "I Authorize DQ Care To Setup My ABHA Health Locker Account",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: spacer3,
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Checkbox(
                          value: controller.abhaLinkMyHealthCheckValue.value,
                          fillColor: WidgetStatePropertyAll(Colors.transparent),
                          activeColor: Color.fromRGBO(102, 102, 255, 1),
                          checkColor: Color.fromRGBO(102, 102, 255, 1),
                          side: BorderSide(
                            color: Color(0xFF6666FF),
                            width: 2,
                          ),
                          // fillColor: WidgetStatePropertyAll(Colors.white),
                          onChanged: (value) =>
                              controller.changeAbhaLinkMyHealthCheckValue(),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Wrap(
                          children: [
                            Text(
                              "Link My Health Data from DQ Care With My ABHA Automatically",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: spacer3,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(""),
                  child: Container(
                    // margin: EdgeInsets.only(top: h / 100 * 3),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: spacer4),
                    height: MediaQuery.of(context).size.width * 0.11,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(spacer2),
                        color: Color(0xFF6666FF).withOpacity(0.7)),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: kcWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
