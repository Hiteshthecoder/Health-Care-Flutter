import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:flutter_countr/CountrDuration.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/LinkMemberController.dart';

class LinkMemberPage extends StatelessWidget {
  bool isTextFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LinkMemberController(),
      builder: (LinkMemberController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : controller.isBusy
            ? LoadingWidget(message: "Please wait...")
            : MasterLayout(
          title: 'Link Family Member',
          actions: [],
          titleSpacing: 0,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.linkMember();
            },
            child: SingleChildScrollView(
              child: Obx(
                    () =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: spacer6, vertical: spacer4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            // "If your family member have already register & you have a subscription, You can directly link family member by login with their phone number."
                              "If your family member have already downloaded and registered with app and you want to share subscription with them, you can directly link family member by login with their phone number."
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: controller.formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: controller.phoneInput,
                                  readOnly: controller.hide == true ? true : false,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Phone Number',
                                    prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+91')),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => Validator("Phone", value!).specialCharacter().between(10, 12).required().validate(),
                                ),
                                SizedBox(height: 25),
                                Obx(
                                      () =>
                                  controller.hide == true
                                      ? SizedBox.shrink()
                                      : Button.block(
                                    key: UniqueKey(),
                                    // label: "Get OTP",
                                    label: "Get OTP",
                                    onTap: (btn) async {
                                      btn.setBusy(true).setDisabled(true);
                                      await controller.linkMember();
                                      btn.setBusy(false).setDisabled(false);
                                    },
                                  ),
                                ),
                                Obx(() =>
                                controller.hide
                                    ? Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Please enter the OTP",
                                          style: TextStyl.subtitle!.copyWith(fontWeight: FontWeight.bold, fontSize: 17)),

                                      const SizedBox(height: 40),
                                      Center(
                                        child: PinFieldAutoFill(
                                          autoFocus: true,
                                          codeLength: 4,
                                          decoration: UnderlineDecoration(
                                              colorBuilder: FixedColorBuilder(kcDarkAlt),
                                              gapSpace: 20,
                                              textStyle: TextStyle(color: kcDarkAlt, fontSize: 35, height: -0.0010)),
                                          onCodeSubmitted: (code) {},
                                          controller: controller.otpInput,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Obx(
                                            () =>
                                        controller.timeUp == true
                                            ? Row(
                                          children: [
                                            Spacer(),
                                            Text(
                                              'RESENDING CODE IN',
                                              style: TextStyl.subtitle!.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Countr(
                                                controller: controller.countrController!,
                                                onTimerComplete: () {
                                                  controller.setTimeUp();
                                                },
                                                builder: (BuildContext context, CountrDuration remainingTime) {
                                                  return Container(
                                                    child: Text(
                                                      "${remainingTime.minutes}:${remainingTime.seconds}",
                                                      style: TextStyl.bodySm?.copyWith(color: kcBlack, fontWeight: FontWeight.bold),
                                                    ),
                                                  );
                                                })
                                          ],
                                        )
                                            : Row(
                                          children: [
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                controller.resentTime();
                                                controller.setStartTimeUp();
                                                controller.linkMember();
                                              },
                                              child: Text(
                                                'Resent Code',
                                                style: TextStyl.bodySm,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),
                                      Button.block(
                                        key: UniqueKey(),
                                        label: "Verify OTP to Link Member",
                                        onTap: (btn) async {
                                          btn.setBusy(true).setDisabled(true);
                                          await controller.linkMemberOtp();
                                          btn.setBusy(false).setDisabled(false);
                                        },
                                      ),
                                      // SizedBox(
                                      //     height: 50,
                                      //     width: 350,
                                      //     child: ElevatedButton(
                                      //         style:ElevatedButton.styleFrom(
                                      //           primary:kcGreen,
                                      //         ),
                                      //
                                      //         onPressed: (){
                                      //           Get.offAllNamed('/profile');
                                      //         }, child: Text("Verify OTP"))),
                                      // SizedBox(height: 20,),
                                      // SizedBox(
                                      //     height: 50,
                                      //     width: 350,
                                      //     child: ElevatedButton(
                                      //         style:ElevatedButton.styleFrom(
                                      //           primary: kcMLightBlue,
                                      //         ),
                                      //
                                      //         onPressed: (){}, child: Text("Resend"))),
                                    ],
                                  ),
                                )
                                    : SizedBox.shrink())
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
      },
    );
  }
}
