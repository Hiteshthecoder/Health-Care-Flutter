import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/controllers/aabha1Controller.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaAdharCardPage extends StatefulWidget {
  const AbhaAdharCardPage({super.key});

  @override
  State<AbhaAdharCardPage> createState() => _AbhaAdharCardPageState();
}

class _AbhaAdharCardPageState extends State<AbhaAdharCardPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: aabha1Controller(),
      builder: (aabha1Controller controller) {
        return Scaffold(
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
              Padding(padding: EdgeInsets.only(right: spacer2))
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
                    Image.asset("assets/newImages/aadhaar_logo.png"),
                  ],
                ),
                SizedBox(
                  height: spacer3,
                ),
                Text("Enter Your Aadhaar Number below"),
                SizedBox(
                  height: spacer3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: spacer2),
                        child: TextFormField(
                          cursorColor: Color(0xFF6666FF),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: kcBlack, fontSize: 14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: spacer2),
                        child: TextFormField(
                          cursorColor: Color(0xFF6666FF),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: kcBlack, fontSize: 14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: spacer2),
                        child: TextFormField(
                          cursorColor: Color(0xFF6666FF),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: kcBlack, fontSize: 14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(spacer2),
                                  borderSide:
                                      BorderSide(color: kcGray, width: 1.5))),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: spacer3,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/user-info-agreement");
                  },
                  child: Text(
                    "User Information Agreement",
                    style: TextStyle(
                      color: Color(0xFF6666FF),
                    ),
                  ),
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
                  onTap: () => Get.toNamed("/abha-otp-verify"),
                  child: Container(
                    // margin: EdgeInsets.only(top: h / 100 * 3),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: spacer4),
                    height: MediaQuery.of(context).size.width * 0.11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(spacer2),
                      color: Color(0xFF6666FF).withOpacity(0.7),
                    ),
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
        );
      },
    );
  }
}
