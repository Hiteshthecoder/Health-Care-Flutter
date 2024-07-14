import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/WorldController.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/DoctorProfileController.dart';

class DoctorProfilePage extends StatelessWidget {
  final DoctorProfileController controller = Get.put(DoctorProfileController());

  final WorldController worldController = Get.put(WorldController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DoctorProfileController(),
        builder: (DoctorProfileController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : Scaffold(
                      body: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: spacer9,
                                ),
                                Container(
                                  height: screen.height * 0.11,
                                  width: screen.width,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: kcBlack.withOpacity(0.3),
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    color: kcWhite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: spacer5,
                                              height: spacer5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: kcGreen,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: kcWhite,
                                              ),
                                            ),
                                            Text(
                                              "Registration",
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.5)),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward),
                                        Column(
                                          children: [
                                            Container(
                                              width: spacer5,
                                              height: spacer5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: kcGreen,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: kcWhite,
                                              ),
                                            ),
                                            Text(
                                              "Profile Setup",
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.5)),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward),
                                        Column(
                                          children: [
                                            Container(
                                              width: spacer5,
                                              height: spacer5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: kcPrimary,
                                              ),
                                              child: Text(
                                                '3',
                                                style: TextStyl.bodySm
                                                    ?.copyWith(color: kcWhite),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Text("My Doctor"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: spacer9,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: controller.formKey,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Phone No.',
                                                      style: TextStyl.bodySm,
                                                    ),
                                                    SizedBox(
                                                      width: screen.width * 0.6,
                                                      child: FormInput.number(
                                                        controller: controller
                                                            .doctorPhoneInput,
                                                        placeholder:
                                                            'Enter Number',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 17,
                                                      ),
                                                      Obx(
                                                        () =>
                                                            controller.verified
                                                                ? Container(
                                                                    width: 85,
                                                                    height: 45,
                                                                    child: Button
                                                                        .block(
                                                                      key:
                                                                          UniqueKey(),
                                                                      label:
                                                                          "Reset",
                                                                      flat:
                                                                          true,
                                                                      onTap:
                                                                          (btn) async {
                                                                        btn.setBusy(true).setDisabled(
                                                                            true);
                                                                        controller
                                                                            .clearFields();
                                                                        btn.setBusy(false).setDisabled(
                                                                            false);
                                                                      },
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    width: 85,
                                                                    height: 45,
                                                                    child: Button
                                                                        .block(
                                                                      key:
                                                                          UniqueKey(),
                                                                      label:
                                                                          "Find",
                                                                      flat:
                                                                          true,
                                                                      onTap:
                                                                          (btn) async {
                                                                        btn.setBusy(true).setDisabled(
                                                                            true);
                                                                        controller
                                                                            .linkDoctor();
                                                                        btn.setBusy(false).setDisabled(
                                                                            false);
                                                                      },
                                                                    ),
                                                                  ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Doctor Name',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.text(
                                                  controller: controller
                                                      .doctorNameInput,
                                                  // onlyRead: controller.readOnly,
                                                  placeholder:
                                                      'Enter Doctor Name',
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'State',
                                                  style: TextStyl.bodySm,
                                                ),
                                                Obx(
                                                  () => FormSelect(
                                                    autoFocus: true,
                                                    options: <DropdownMenuItem>[
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          'Select State',
                                                          style:
                                                              TextStyl.bodySm,
                                                        ),
                                                        value: '0',
                                                      ),
                                                      ...List.generate(
                                                          controller.allState
                                                              .length, (index) {
                                                        StateModel state =
                                                            controller.allState[
                                                                index];
                                                        return DropdownMenuItem(
                                                          child: Text(
                                                            '${state.name}',
                                                            style:
                                                                TextStyl.bodySm,
                                                          ),
                                                          value: state.id
                                                              .toString(),
                                                        );
                                                      }),
                                                    ],
                                                    value: controller
                                                        .selectedState,
                                                    onChanged: (value) =>
                                                        controller
                                                            .onStateSelect(
                                                                value),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'City',
                                                  style: TextStyl.bodySm,
                                                ),
                                                Obx(
                                                  () => FormSelect(
                                                    autoFocus: true,
                                                    options: <DropdownMenuItem>[
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          'Select City',
                                                          style:
                                                              TextStyl.bodySm,
                                                        ),
                                                        value: '0',
                                                      ),
                                                      ...List.generate(
                                                          controller.allCity
                                                              .length, (index) {
                                                        CityModel city =
                                                            controller
                                                                .allCity[index];
                                                        return DropdownMenuItem(
                                                          child: Text(
                                                            '${city.name}',
                                                            style:
                                                                TextStyl.bodySm,
                                                          ),
                                                          value: city.id
                                                              .toString(),
                                                        );
                                                      }),
                                                    ],
                                                    value:
                                                        controller.selectedCity,
                                                    onChanged: (value) =>
                                                        controller.onCitySelect(
                                                            value),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Address',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.multiline(
                                                  controller:
                                                      controller.addressInput,
                                                  placeholder: 'Enter Address',
                                                  action:
                                                      TextInputAction.newline,
                                                  // onlyRead: controller.readOnly,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 23, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pincode',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.number(
                                                  controller:
                                                      controller.pincodeInput,
                                                  placeholder: 'Enter Pincode',
                                                  // onlyRead: controller.readOnly,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Obx(() => controller.menuController.isMemberLoggedIn
                                ? Expanded(
                                    child: Button.block(
                                      key: UniqueKey(),
                                      label: "Go Back",
                                      flat: true,
                                      onTap: (btn) async {
                                        btn.setBusy(true).setDisabled(true);
                                        controller.menuController
                                            .reLoginOldUser(redirect: true);
                                        auth.getUser();
                                        btn.setBusy(false).setDisabled(false);
                                      },
                                    ),
                                  )
                                : SizedBox.shrink()),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Button.block(
                                key: UniqueKey(),
                                label: "Access Dashboard",
                                flat: true,
                                onTap: (btn) async {
                                  btn.setBusy(true).setDisabled(true);
                                  await controller.createPrimaryDoctor();
                                  auth.getUser();
                                  btn.setBusy(false).setDisabled(false);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Button.block(
                                key: UniqueKey(),
                                label: "Skip",
                                flat: true,
                                onTap: (btn) async {
                                  btn.setBusy(true).setDisabled(true);
                                  auth.getUser();
                                  Get.offAllNamed('/dashboard');
                                  btn.setBusy(false).setDisabled(false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
        });
  }
}
