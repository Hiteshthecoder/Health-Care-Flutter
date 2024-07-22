import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/Helpers.dart';

class AbhaProvidersScreen extends StatelessWidget {
  const AbhaProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: spacer3,
        vertical: spacer3,
      ),
      shrinkWrap: true,
      children: [
        TextFormField(
          style: TextStyle(color: kcBlack, fontSize: 12),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.transparent,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: kcGray.withOpacity(0.7), width: 1.5)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: kcGray.withOpacity(0.7), width: 1.5)),
            prefixIcon: Icon(
              Icons.search,
              color: kcGray,
              size: Get.size.width * 0.05,
            ),
            hintText: "Search Your Hospital, clinic or Lab Name",
            hintStyle: GoogleFonts.openSans(
              fontSize: 12,
              color: kcDark,
            ),
          ),
        ),
        SizedBox(
          height: spacer3,
        ),
        Text(
          "Government Programs",
          style: GoogleFonts.openSans(
            fontSize: 18,
            color: kcDark,
          ),
        ),
        SizedBox(
          height: spacer2,
        ),
        Column(
          children: [0, 1, 2, 3, 4, 5]
              .map(
                (e) => ListTile(
                  contentPadding: EdgeInsets.only(
                    left: spacer1,
                    right: spacer1,
                    bottom: spacer3,
                  ),
                  tileColor: kcWhite,
                  leading: Image.asset(
                    "assets/newImages/cowin_image.png",
                    width: Get.size.width * 0.11,
                    height: Get.size.height * 0.06,
                  ),
                  title: Text(
                    "Government Program Name",
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: kcDark,
                    size: Get.size.width * 0.06,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
