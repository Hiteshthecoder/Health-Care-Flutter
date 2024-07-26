import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaConsentPinSetup extends StatelessWidget {
  const AbhaConsentPinSetup({super.key});

  @override
  Widget build(BuildContext context) {
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: spacer3,
          ),
          Text(
            textAlign: TextAlign.center,
            "Setup Consent PIN",
            style: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: spacer3,
          ),
          Text(
            textAlign: TextAlign.center,
            "Enter Your 4 Digit Consent PIN",
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: spacer4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.25),
            child: PinFieldAutoFill(
              codeLength: 4,
              decoration: BoxLooseDecoration(
                gapSpace: 10,
                hintText: "9999",
                radius: Radius.circular(12),
                textStyle: TextStyle(color: kcDark, fontSize: 18),
                strokeColorBuilder: FixedColorBuilder(
                  kcDark,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            height: spacer6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.loop,
                  color: kcPrimary,
                ),
              ),
              SizedBox(
                width: spacer1,
              ),
              Text(
                "Re-enter Your 4 Digit Consent PIN",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: spacer2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.25),
            child: PinFieldAutoFill(
              codeLength: 4,
              decoration: BoxLooseDecoration(
                gapSpace: 10,
                hintText: "9999",
                radius: Radius.circular(12),
                textStyle: TextStyle(color: kcDark, fontSize: 18),
                strokeColorBuilder: FixedColorBuilder(
                  kcDark,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Get.size.width * 0.05,
                vertical: Get.size.height * 0.02,
              ),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.11,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spacer2),
                  color: Color(0xFF6666FF).withOpacity(0.7)),
              child: Text(
                "Confirm",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: kcWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
