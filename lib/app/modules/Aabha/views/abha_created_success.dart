import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/controllers/aabha1Controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaCreatedSuccess extends StatelessWidget {
  const AbhaCreatedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: aabha1Controller(),
      builder: (aabha1Controller controller) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacer4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    "assets/newImages/green_tick.png",
                    // height: Get.size.height * 0.09,
                    // width: Get.size.width * 0.32,
                  ),
                  SizedBox(
                    height: spacer2,
                  ),
                  Text(
                    "ABHA Created Successfully",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: spacer2,
                  ),
                  Text(
                    "ABHA will allow you to access and share your health data with your consent, with participating healthcare prroviders.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
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
        );
      },
    );
  }
}
