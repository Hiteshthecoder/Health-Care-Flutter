import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      title: Text(
        'Referral',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: kcWhite),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.filter_list_sharp,
                    size: 25,
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: spacer4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            child: Container(
                              width: 500,
                              margin: EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          "Title here ",
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: spacer2,
                                        ),
                                        Text(
                                            "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients. ")
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          radius: 14.0,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          barrierDismissible: false,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/contact.svg',
                        color: kcWhite,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: spacer1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(spacer2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Name or Phone No.',
                    prefixIcon: Icon(
                      Icons.search,
                      color: kcBlack,
                    ),
                    fillColor: kcOffWhite,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    //Get.toNamed('/patientdetails');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: kcBlack.withOpacity(0.1), width: 0.52),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0.25,
                    margin: EdgeInsets.all(5),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: kcdblue, width: 5)),
                        ),
                        width: 350,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.all(5),
                                  //   width: 70,
                                  //   height: 70,
                                  //   decoration: BoxDecoration(
                                  //     // shape: BoxShape.circle,
                                  //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                  //     image: DecorationImage(
                                  //         image: AssetImage('assets/images/patientprofile.jpg'),
                                  //         fit: BoxFit.cover
                                  //     ),
                                  //   ),
                                  // ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Medical Store Name',
                                        style: TextStyle(color: kcBlack, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Patient Name",
                                        style: TextStyle(color: kcBlack.withOpacity(0.6), fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: kcdblue.withOpacity(0.75),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
