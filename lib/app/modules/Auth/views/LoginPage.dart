import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/config/Config.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ui_x/ui_x.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/views/layouts/AuthLayout.dart';
import '../controllers/LoginController.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    var screen = Get.size;
    double w = screen.width, h = screen.height;
    return AuthLayout(
        body: SafeArea(
            child: Container(
      height: h,
      width: w,
      child: SingleChildScrollView(
          child: InkWell(
              onTap: () => Keyboard.hide(context),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: h * 0.88,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: h / 100 * 8),
                              child: CarouselSlider(
                                  items: [
                                    Image.asset(
                                      "assets/newImages/medical_prescription.png",
                                      // width: w * 0.9,
                                      // height: h * 0.5,
                                      // fit: BoxFit.contain,
                                    ),
                                    Image.asset(
                                      "assets/newImages/online_doctor.png",
                                    ),
                                    Image.asset(
                                      "assets/newImages/qr_code.png",
                                    ),
                                    Image.asset(
                                      "assets/newImages/gift_card.png",
                                    ),
                                  ],
                                  carouselController:
                                      controller.carouselController,
                                  options: CarouselOptions(
                                      height: h * 0.45,
                                      onPageChanged: (index, reason) {
                                        controller.imageCurrentIndex.value =
                                            index;
                                        // controller.pageController.animateTo(
                                        //     controller.imageCurrentIndex.value
                                        //         .toDouble(),
                                        //     duration: Duration(microseconds: 300),
                                        //     curve: Curves.fastOutSlowIn);
                                      },
                                      // padEnds: true,
                                      viewportFraction: 1))),
                          Obx(
                            () => Container(
                                margin: EdgeInsets.only(top: h / 100 * 5),
                                child: AnimatedSmoothIndicator(
                                  // controller: controller.pageController,
                                  activeIndex:
                                      controller.imageCurrentIndex.value,
                                  // controller: pageController,
                                  //     as PageController, // PageController
                                  count: 4,
                                  effect: WormEffect(
                                      dotColor: Color(0xffc1c1ff),
                                      dotHeight: w / 100 * 2,
                                      dotWidth: w / 100 * 2,
                                      activeDotColor: Color(0xFF6666FF)),
                                )),
                          ),

                          // carouselController: carouselController,
                          Obx(
                            () => Container(
                                width: w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: w / 100 * 4),
                                margin: EdgeInsets.only(top: h / 100 * 5),
                                // alignment: Alignment.center,
                                child: Text(
                                    controller.getCurrentTitleAccToSlider(
                                        controller.imageCurrentIndex.value),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: w / 100 * 6,
                                        fontWeight: FontWeight.bold))),
                          ),
                          Obx(
                            () => Container(
                                // alignment: Alignment.center,
                                width: w,
                                margin: EdgeInsets.only(top: h / 100 * 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: w / 100 * 2),
                                child: Text(
                                    controller.getCurrentSubTitleAccToSlider(
                                        controller.imageCurrentIndex.value),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: w / 100 * 4,
                                      // fontWeight: FontWeight.bold
                                    ))),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return bottonSheetWidget(w, h, context);
                            });
                      },
                      child: Container(
                          width: w * 0.9,
                          // margin: EdgeInsets.only(top: h / 100 * 3),
                          alignment: Alignment.center,
                          height: h * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w / 100 * 3),
                              color: Color(0xFF6666FF)),
                          child: Text("Get Started",
                              style: TextStyle(
                                  color: kcWhite,
                                  fontSize: w / 100 * 3.5,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ]))),
    )));
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
            // margin: EdgeInsets.only(top: 1),
            // height: h * 0.065,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Row(children: [
                Container(
                  width: w * 0.2,
                  child: TextFormField(
                    readOnly: true,
                    // validator: (value) => Validator("Phone", value!)
                    //     .specialCharacter()
                    //     .between(2, 3)
                    //     .required()
                    //     .validate(),
                    cursorColor: Color(0xFF6666FF),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: kcBlack, fontSize: w / 100 * 4),
                    decoration: InputDecoration(
                      hintText: "+91",
                      hintStyle:
                          TextStyle(color: kcGray, fontSize: w / 100 * 4),
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
                      controller: controller.phoneNumber,
                      validator: (value) => Validator("Phone", value!)
                          .specialCharacter()
                          .between(10, 10)
                          .required()
                          .validate(),
                      onChanged: (value) {
                        if (value.length >= 10) {
                          controller.phoneNumber.text = value.substring(0, 10);
                        }
                      },
                      cursorColor: Color(0xFF6666FF),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(color: kcBlack, fontSize: w / 100 * 4),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w / 100 * 3),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w / 100 * 3),
                              borderSide:
                                  BorderSide(color: kcGray, width: 1.5))),
                    ),
                  ),
                )
              ]),
            ),
          ),
          Container(
            width: w,
            padding: EdgeInsets.symmetric(horizontal: w / 100 * 4),
            margin: EdgeInsets.only(top: h / 100 * 1),
            child: InkWell(
              onTap: () async {
                // btn.setBusy(true).setDisabled(true);
                controller.loading.value = true;
                await controller.submit();
                controller.loading.value = false;
                // btn.setBusy(false).setDisabled(false);
              },
              child: Obx(
                () => Container(
                    alignment: Alignment.center,
                    height: h * 0.065,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w / 100 * 3),
                        color: Color(0xFF6666FF)),
                    child: (controller.loading.value)
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: kcWhite, size: w / 100 * 10)
                        : Text("Get OTP",
                            style: TextStyle(
                                color: kcWhite,
                                fontSize: w / 100 * 3.5,
                                fontWeight: FontWeight.w600))),
              ),
            ),
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
