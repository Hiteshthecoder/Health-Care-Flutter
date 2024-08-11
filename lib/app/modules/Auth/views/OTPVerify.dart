import 'package:flutter/material.dart';
import 'package:flutter_countr/Countr.dart';
import 'package:flutter_countr/CountrDuration.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/AuthLayout.dart';
import '../controllers/LoginController.dart';

class OTPVerify extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var screen = Get.size;
    return !controller.isConnected
        ? NotConnectedErrorPage()
        : AuthLayout(
            body: SafeArea(
              child: Obx(
                () => SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => Keyboard.hide(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                      color: Colors.transparent,
                      width: double.infinity,
                      height: screen.height - 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: spacer16),
                              Text("Please enter the OTP sent to",
                                  style: TextStyl.subtitle!.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text("+91 ${controller.phoneNumber.text}",
                                  style: TextStyl.subtitle!.copyWith(fontSize: 15, color: kcBlack.withOpacity(0.5))),
                              const SizedBox(height: 70),
                              Center(
                                child: PinFieldAutoFill(
                                  currentCode: controller.number == controller.phoneNumber.text ? controller.otp : "",
                                  controller: controller.otpInput,
                                  codeLength: 4,
                                  decoration: UnderlineDecoration(
                                      colorBuilder: FixedColorBuilder(kcDarkAlt),
                                      gapSpace: 20,
                                      textStyle: TextStyle(color: kcDarkAlt, fontSize: 35, height: -0.0010)),
                                  onCodeSubmitted: (code) {},
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => controller.timeUp == true
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
                                                  style: TextStyl.bodySm
                                                      ?.copyWith(color: kcBlack, fontWeight: FontWeight.bold),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              controller.resentTime();
                                              controller.setStartTimeUp();
                                              controller.submit();
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
                                label: "Verify OTP",
                                onTap: (btn) async {
                                  btn.setBusy(true).setDisabled(true);
                                  await controller.submitOtp();
                                  btn.setBusy(false).setDisabled(false);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kcLightGreen,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: SvgPicture.asset(
                                      'assets/icons/shield-check.svg',
                                      color: kcBlack.withOpacity(0.5),
                                      width: 1,
                                      height: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'All your personal information is safely\nencrypted and secured',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kcLightGreen,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: SvgPicture.asset(
                                      'assets/icons/shield-check.svg',
                                      color: kcBlack.withOpacity(0.5),
                                      width: 1,
                                      height: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'We use your data purely for purchase and \ntransaction updates',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
