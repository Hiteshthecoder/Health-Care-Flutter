import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/controllers/aabha1Controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaAdressScreen extends StatelessWidget {
  const AbhaAdressScreen({super.key});

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
            centerTitle: true,
            title: Text(
              "Enter ABHA Address",
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: Get.size.width * 0.04,
              right: Get.size.width * 0.032,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your ABHA ID",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: spacer2,
                ),
                Text(
                  "This ABHA ID Will Be used For All Your ABHA Healthcare Services",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: spacer3,
                ),
                AbhaAddressDetails(),
                SizedBox(
                  height: spacer2,
                ),
                AbhaAddressSuggestions(),
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
      ),
    );
  }
}

class AbhaAddressDetails extends StatelessWidget {
  const AbhaAddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "ABHA address*",
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kcPrimary.withOpacity(0.8),
          ),
        ),
        SizedBox(
          height: spacer2,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: kcGray, width: 1.5)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: kcGray, width: 1.5),
            ),
            hintText: "rishiashar",
            hintStyle: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            isDense: true,
            fillColor: Colors.transparent,
            // labelText: "@abdm",
            suffix: Text(
              "@abdm",
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: kcPrimary.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: spacer2,
        ),
        Text(
          "This ABHA is available",
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: kcGreen.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class AbhaAddressSuggestions extends StatelessWidget {
  const AbhaAddressSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: kcGray),
      ),
      elevation: 0,
      color: kcPrimary.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.size.width * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: spacer2,
            ),
            Text(
              "Suggestions",
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kcPrimary,
              ),
            ),
            Container(
              height: Get.size.height * 0.08,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: spacer1,
                    ),
                    child: Chip(
                      padding: EdgeInsets.all(8),
                      backgroundColor: kcWhite,
                      elevation: 0,
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      label: Text(
                        "Rishi",
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: kcPrimary.withOpacity(0.5),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
