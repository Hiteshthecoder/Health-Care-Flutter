import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/ProfileController.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (ProfileController controller) {
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
                                                color: kcPrimary,
                                              ),
                                              child: Text(
                                                '2',
                                                style: TextStyl.bodySm
                                                    ?.copyWith(color: kcWhite),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Text(
                                              "Profile Setup",
                                              style: TextStyl.bodySm
                                                  ?.copyWith(color: kcBlack),
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
                                                color: kcLightGray,
                                              ),
                                              child: Text(
                                                '3',
                                                style: TextStyl.bodySm
                                                    ?.copyWith(color: kcBlack),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Text(
                                              "My Doctor",
                                              style: TextStyl.bodySm?.copyWith(
                                                  color:
                                                      kcBlack.withOpacity(0.5)),
                                            ),
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'First Name',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput(
                                                  controller:
                                                      controller.firstNameInput,
                                                  placeholder: 'First Name',
                                                  validator: (value) =>
                                                      Validator("First Name",
                                                              value!)
                                                          .required()
                                                          .validate(),
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
                                                  'Last Name',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput(
                                                  controller:
                                                      controller.lastNameInput,
                                                  placeholder: 'Last Name',
                                                  validator: (value) =>
                                                      Validator("Last Name",
                                                              value!)
                                                          .required()
                                                          .validate(),
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
                                                  'Phone ',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.number(
                                                  controller: controller
                                                      .loginController
                                                      .phoneNumber,
                                                  placeholder: 'Number',
                                                  onlyRead: true,
                                                  validator: (value) =>
                                                      Validator(
                                                              "Number", value!)
                                                          .specialCharacter()
                                                          .between(10, 10)
                                                          .required()
                                                          .validate(),
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
                                                  'Email',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.email(
                                                  controller:
                                                      controller.emailInput,
                                                  placeholder: 'Email',
                                                  validator: (value) =>
                                                      Validator("Email", value!)
                                                          .email()
                                                          .required()
                                                          .validate(),
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
                                                  'DOB',
                                                  style: TextStyl.bodySm,
                                                ),
                                                Obx(
                                                  () => FormInputDate(
                                                    autoFocus: true,
                                                    value:
                                                        controller.selectedDob,
                                                    onChanged: (date) async {
                                                      controller
                                                          .onDobSelect(date);
                                                    },
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
                                                  'Gender',
                                                  style: TextStyl.bodySm,
                                                ),
                                                Obx(
                                                  () => FormSelect(
                                                    autoFocus: true,
                                                    options: <DropdownMenuItem>[
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          'Male',
                                                          style:
                                                              TextStyl.bodySm,
                                                        ),
                                                        value: 'Male',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          'Female',
                                                          style:
                                                              TextStyl.bodySm,
                                                        ),
                                                        value: 'Female',
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text(
                                                          'Other',
                                                          style:
                                                              TextStyl.bodySm,
                                                        ),
                                                        value: 'Other',
                                                      ),
                                                    ],
                                                    value: controller
                                                        .selectedGender,
                                                    onChanged: (value) =>
                                                        controller
                                                            .onGenderSelect(
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
                                                horizontal: 20, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Weight (in kg)',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.number(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'(^\d*\.?\d{0,2})')),
                                                    LengthLimitingTextInputFormatter(
                                                        6)
                                                  ],
                                                  type: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  controller:
                                                      controller.weightInput,
                                                  placeholder: 'Weight',
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Height (in cm)',
                                                  style: TextStyl.bodySm,
                                                ),
                                                FormInput.number(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'(^\d*\.?\d{0,2})')),
                                                    LengthLimitingTextInputFormatter(
                                                        6)
                                                  ],
                                                  type: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  controller:
                                                      controller.heightInput,
                                                  placeholder: 'Height',
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
                                                  placeholder: 'Address',
                                                  action:
                                                      TextInputAction.newline,
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
                                                  maxLength: 10,
                                                  controller:
                                                      controller.pincodeInput,
                                                  placeholder: 'Pincode',
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
                        Button.block(
                          key: UniqueKey(),
                          label: "Complete Profile",
                          flat: true,
                          onTap: (btn) async {
                            btn.setBusy(true).setDisabled(true);
                            await controller.profileSetup();
                            btn.setBusy(false).setDisabled(false);
                          },
                        ),
                      ],
                    ));
        });
  }
}
