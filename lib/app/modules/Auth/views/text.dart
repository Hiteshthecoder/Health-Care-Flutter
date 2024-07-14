import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvc/config/Config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/Global.dart';
import '../../../shared/views/layouts/AuthLayout.dart';
import '../controllers/LoginController.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  Widget bottomSheetContent(BuildContext context) {
    return Container(child: Text("Data"));
  }

  CarouselController carouselController = CarouselController();
  PageController pageController = PageController();
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    var screen = Get.size;
    double w = screen.width, h = screen.height;
    return AuthLayout(
      bottomSheet: BottomSheet(onClosing: () {}, builder: bottomSheetContent),
      body:
          // SafeArea(
          //     child: SingleChildScrollView(
          //         child: InkWell(
          //             onTap: () => Keyboard.hide(context),
          //             child: Container(
          //               padding: EdgeInsets.symmetric(
          //                   horizontal: w * 0.02, vertical: h * 0.02),
          //               child: Column(children: [
          //                 Container(
          //                     margin: EdgeInsets.only(top: h / 100 * 6),
          //                     child: CarouselSlider(
          //                         items: [
          //                           Image.asset(
          //                             "assets/newImages/medical_prescription.png",
          //                             // width: w * 0.9,
          //                             // height: h * 0.5,
          //                             // fit: BoxFit.contain,
          //                           ),
          //                           Image.asset(
          //                             "assets/newImages/online_doctor.png",
          //                           ),
          //                           Image.asset(
          //                             "assets/newImages/qr_code.png",
          //                           ),
          //                           Image.asset(
          //                             "assets/newImages/gift_card.png",
          //                           ),
          //                         ],
          //                         carouselController: carouselController,
          //                         options: CarouselOptions(
          //                             height: h * 0.45,
          //                             // padEnds: true,
          //                             viewportFraction: 1))),
          //                 Container(
          //                     margin: EdgeInsets.only(top: h / 100 * 5),
          //                     child: SmoothPageIndicator(
          //                         controller: pageController,
          //                         // activeIndex: index,
          //                         // controller: pageController,
          //                         //     as PageController, // PageController
          //                         count: 4,
          //                         effect: WormEffect(
          //                             dotColor: Color(0xffc1c1ff),
          //                             dotHeight: w / 100 * 2,
          //                             dotWidth: w / 100 * 2,
          //                             activeDotColor: Color(
          //                                 0xFF6666FF)), // your preferred effect
          //                         onDotClicked: (index) {
          //                           // print
          //                           carouselController.nextPage(
          //                               duration: Duration(milliseconds: 600),
          //                               curve: Curves.fastOutSlowIn);

          //                           // index++;
          //                           pageController.nextPage(
          //                               duration: Duration(milliseconds: 600),
          //                               curve: Curves.fastOutSlowIn);
          //                         })),

          //                 // carouselController: carouselController,
          //                 Container(
          //                     margin: EdgeInsets.only(top: h / 100 * 5),
          //                     child: Text("Organize health reports",
          //                         style: TextStyle(
          //                             fontSize: w / 100 * 6,
          //                             fontWeight: FontWeight.bold))),
          //                 Container(
          //                     alignment: Alignment.center,
          //                     width: w,
          //                     margin: EdgeInsets.only(top: h / 100 * 2),
          //                     child: Text(
          //                         "Take control of your health data with seamless organization, right at your fingertips.",
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontSize: w / 100 * 4,
          //                           // fontWeight: FontWeight.bold
          //                         ))),
          //                 InkWell(
          //                   onTap: () {
          //                     showBottomSheet(
          //                         context: context,
          //                         builder: (context) {
          //                           return bottonSheetWidget(w, h, context);
          //                         });
          //                   },
          //                   child: Container(
          //                       width: w * 0.9,
          //                       margin: EdgeInsets.only(top: h / 100 * 3),
          //                       alignment: Alignment.center,
          //                       height: h * 0.065,
          //                       decoration: BoxDecoration(
          //                           borderRadius:
          //                               BorderRadius.circular(w / 100 * 3),
          //                           color: Color(0xFF6666FF)),
          //                       child: Text("Get Started",
          //                           style: TextStyle(
          //                               color: kcWhite,
          //                               fontSize: w / 100 * 3.5,
          //                               fontWeight: FontWeight.w600))),
          //                 ),
          //               ]),
          //             ))))

          SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => Keyboard.hide(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              color: Colors.transparent,
              width: double.infinity,
              height: screen.height - 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Image.asset(
                        image('logo.png'),
                        width: 75,
                      ),
                      const SizedBox(height: spacer),
                      Text("Welcome to DQCare,",
                          style: TextStyl.subtitle!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: spacer1),
                      Text("Enter your Mobile Number to get started",
                          style: TextStyl.body!
                              .copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: spacer10,
                  ),
                  Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.phoneNumber,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Phone Number',
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text('+91')),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validator("Phone", value!)
                              .specialCharacter()
                              .between(10, 10)
                              .required()
                              .validate(),
                        ),
                        SizedBox(height: 25),
                        Button.block(
                          key: UniqueKey(),
                          label: "Get OTP",
                          onTap: (btn) async {
                            // btn.setBusy(true).setDisabled(true);
                            // await controller.submit();
                            // btn.setBusy(false).setDisabled(false);
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return bottonSheetWidget(w, h, context);
                                });
                          },
                        ),
                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () => Get.offNamed("/enquiry"),
                          child: Text.rich(
                            TextSpan(
                              text: "Having trouble signing in?",
                              style: TextStyl.button
                                  ?.copyWith(color: kcPrimary.withOpacity(0.7)),
                            ),
                          ),
                        ),
                        SizedBox(height: 150),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'By proceeding, you agree to our',
                                  style: TextStyl.button?.copyWith(
                                    color: kcBlack.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(Config.privacyPolicyUrl);
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyl.button?.copyWith(
                                      color: kcPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'and',
                                  style: TextStyl.button?.copyWith(
                                    color: kcBlack.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(Config.termsAndConditionUrl);
                                  },
                                  child: Text(
                                    'Terms and Conditions.',
                                    style: TextStyl.button?.copyWith(
                                      color: kcPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottonSheetWidget(double w, double h, BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        // height: h*0.54,
        width: w,
        alignment: Alignment.topCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(top: h / 100 * 1),
            width: w * 0.4,
            height: h / 100 * 0.5,
            decoration: BoxDecoration(
                color: kcGray,
                borderRadius: BorderRadius.circular(w / 100 * 10)),
          ),
          Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
              margin: EdgeInsets.only(top: h / 100 * 2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone Number",
                        style: TextStyle(
                            fontSize: w / 100 * 5,
                            color: kcBlack,
                            fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        Get.close(1);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: w / 100 * 4,
                              color: kcBlack,
                              fontWeight: FontWeight.w600)),
                    ),
                  ])),
          Container(
            width: w,
            margin: EdgeInsets.only(top: h / 100 * 1),
            child: Divider(color: kcGray, thickness: 1),
          ),
          Container(
              width: w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
              child: Text("Enter your phone number to get started",
                  style: TextStyle(
                      fontSize: w / 100 * 3.5,
                      color: kcBlack,
                      fontWeight: FontWeight.w500))),
          Container(
            width: w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5),
            height: h * 0.065,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            child: Row(children: [
              Container(
                width: w * 0.2,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(color: kcBlack, fontSize: w / 100 * 4),
                  decoration: InputDecoration(
                    hintText: "+91",
                    hintStyle: TextStyle(color: kcBlack, fontSize: w / 100 * 4),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w / 100 * 3),
                        borderSide: BorderSide(color: kcGray, width: 1.5)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w / 100 * 3),
                        borderSide: BorderSide(color: kcGray, width: 1.5)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: w / 100 * 2),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(color: kcBlack, fontSize: w / 100 * 4),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w / 100 * 3),
                            borderSide: BorderSide(color: kcGray, width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w / 100 * 3),
                            borderSide: BorderSide(color: kcGray, width: 1.5))),
                  ),
                ),
              )
            ]),
          ),
          Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            margin: EdgeInsets.only(top: h / 100 * 1),
            child: Container(
                alignment: Alignment.center,
                height: h * 0.065,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w / 100 * 3),
                    color: Color(0xFF6666FF)),
                child: Text("Get OTP",
                    style: TextStyle(
                        color: kcWhite,
                        fontSize: w / 100 * 3.5,
                        fontWeight: FontWeight.w600))),
          ),
          Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
              margin: EdgeInsets.only(top: h / 100 * 3),
              child: Row(children: [
                Expanded(child: Divider(thickness: 1, endIndent: 5)),
                Text("OR",
                    style: TextStyle(fontSize: w / 100 * 3, color: kcBlack)),
                Expanded(child: Divider(thickness: 1, indent: 5)),
              ])),
          Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            margin: EdgeInsets.only(top: h / 100 * 3),
            child: Container(
              height: h * 0.07,
              decoration: BoxDecoration(
                  border: Border.all(color: kcGray),
                  borderRadius: BorderRadius.circular(w / 100 * 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      "https://img.icons8.com/fluency/96/google-logo.png",
                      width: w / 100 * 8,
                      height: h / 100 * 4,
                      fit: BoxFit.fill),
                  Container(
                    margin: EdgeInsets.only(left: w / 100 * 2),
                    child: Text("Continue With Google",
                        style:
                            TextStyle(fontSize: w / 100 * 4, color: kcBlack)),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: w,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            margin: EdgeInsets.only(top: h / 100 * 3, bottom: h / 100 * 4),
            child: Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: w / 100 * 3),
                TextSpan(text: "By continuing you accept our ", children: [
                  TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(Config.privacyPolicyUrl);
                        },
                      children: [
                        TextSpan(
                            text: " and ",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal),
                            children: [
                              TextSpan(
                                  text: "Term of Use",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(Config.termsAndConditionUrl);
                                    })
                            ])
                      ])
                ])),
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom))
        ]),
      ),
    );
  }
}
