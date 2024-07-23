import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaMainScreen extends StatelessWidget {
  const AbhaMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: spacer3,
      ),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: spacer3,
        ),
        Image.asset(
          "assets/newImages/aabha_card.png",
          height: Get.size.height * 0.20,
          fit: BoxFit.cover,
          width: Get.size.width,
        ),
        SizedBox(
          height: spacer3,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: kcPrimary.withOpacity(0.5)),
          ),
          leading: Image.asset(
            "assets/newImages/qr_code.png",
            height: Get.size.height * 0.04,
            width: Get.size.height * 0.05,
          ),
          title: Text(
            "Get appointment token",
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right_sharp,
            color: kcPrimary.withOpacity(0.7),
            size: 35,
          ),
        ),
      ],
    );
  }
}
