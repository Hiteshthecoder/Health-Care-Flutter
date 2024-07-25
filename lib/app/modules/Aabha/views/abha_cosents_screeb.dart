import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaConsentsScreen extends StatelessWidget {
  const AbhaConsentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Get.size.width * 0.02,
      ),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: spacer3,
        ),
        ConsentMainHeader(),
        SizedBox(height: spacer8),
        ConsentTiles(),
        SizedBox(height: spacer7),
        ConsentFooter(),
      ],
    );
  }
}

class ConsentFooter extends StatelessWidget {
  const ConsentFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/newImages/consent_security_image.png",
          height: 65,
          width: 66,
        ),
        SizedBox(
          height: spacer3,
        ),
        Text(
          "Your personal health information is safeguarded with DQ Care. It will never be shared without your explicit consent.",
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: spacer3,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: Get.size.width * 0.05,
            ),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.width * 0.11,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(spacer2), color: Color(0xFF6666FF).withOpacity(0.7)),
            child: Text(
              "Setup Consent PIN",
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: kcWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConsentTiles extends StatelessWidget {
  const ConsentTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Image.asset(
                "assets/newImages/consent_mail_image.png",
                height: 46,
                width: 53,
              ),
            ),
            Expanded(
              flex: 4,
              child: Wrap(
                children: [
                  Text(
                    "Stay informed about incoming consent requests from your healthcare providers.",
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacer5),
        Row(
          children: [
            Expanded(
              child: Image.asset(
                "assets/newImages/consent_check_image.png",
                height: 46,
                width: 53,
              ),
            ),
            Expanded(
              flex: 4,
              child: Wrap(
                children: [
                  Text(
                    "Stay informed about incoming consent requests from your healthcare providers.",
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacer3),
        Row(
          children: [
            Expanded(
              child: Image.asset(
                "assets/newImages/consent_lock_image.png",
                height: 46,
                width: 53,
              ),
            ),
            Expanded(
              flex: 4,
              child: Wrap(
                children: [
                  Text(
                    "Grant access to your medical records with your approval. Set up your Consent PIN now.",
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConsentMainHeader extends StatelessWidget {
  const ConsentMainHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/newImages/consent_main_head.png",
          height: Get.size.height * 0.08,
          width: Get.size.width * 0.20,
        ),
        SizedBox(
          height: spacer3,
        ),
        Text(
          "Consent Manager",
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: spacer1,
        ),
        Text(
          textAlign: TextAlign.center,
          "Centralized platform for handling permission requests to access your medical information.",
          style: GoogleFonts.openSans(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
