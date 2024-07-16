import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/controllers/aabha1Controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaOtpVerificationScreen extends StatelessWidget {
  const AbhaOtpVerificationScreen({super.key});

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
              horizontal: spacer5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/newImages/aadhaar_logo.png"),
                SizedBox(
                  height: spacer3,
                ),
                Text(
                  "Enter OTP Recieved on mobile number",
                  style: GoogleFonts.openSans(fontSize: 16),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "+91",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " 9999999999",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " Linked with Adhaar",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: spacer3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.size.width * 0.08,
                  ),
                  child: PinFieldAutoFill(
                    codeLength: 6,
                    decoration: BoxLooseDecoration(
                      gapSpace: 10,
                      hintText: "999999",
                      radius: Radius.circular(12),
                      textStyle: TextStyle(color: kcDark, fontSize: 18),
                      strokeColorBuilder: FixedColorBuilder(
                        kcDark,
                      ),
                    ),
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: spacer2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Resend OTP in"),
                    Text("1:29"),
                  ],
                ),
                Spacer(),
                Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
