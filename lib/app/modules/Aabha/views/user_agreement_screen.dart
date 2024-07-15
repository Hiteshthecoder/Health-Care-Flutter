import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: spacer4, right: spacer4, top: spacer6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User information Agreement",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: spacer2,
              ),
              Text(
                  "l, hereby declare that I am voluntarily sharing my identity information with the National Health Authority (NHA) for the sole purpose of creating a Ayushman Bharat Health Account (ABHAAddress). I understand my ABHA Address can be used in any healthcare interaction across India. I consciously choose the option of KYC (Name, Address, Age, Date of Birth, Gender and Photograph) through Govt. of India (GOI) issued identity proof document. I understand that my personal identifiable information, relevant to this transaction, will be stored by National Health Authority (NHA) solely for the purpose of Ayushman Bharat Health Account (ABHA Address) which, in turn, can be used in any health care interaction across India.",
                  style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600)),
              SizedBox(
                height: spacer5,
              ),
              Text(
                "I am aware that my personal identifiable information (Name, Address, Age, Date of Birth, Gender and Photograph) may be made available to the entities working in the National Digital Health Mission (NDHM) framework for enabling the healthcare services to me across India. I reserve the right to revoke the given consent at any time from the National Health Authority (NHA) at my own discretion",
                style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                    // margin: EdgeInsets.only(top: h / 100 * 3),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: spacer4),
                    height: MediaQuery.of(context).size.width * 0.09,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(spacer2), color: Color(0xFF6666FF).withOpacity(0.7)),
                    child: Text("Close", style: TextStyle(color: kcWhite, fontSize: 14, fontWeight: FontWeight.w600))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
