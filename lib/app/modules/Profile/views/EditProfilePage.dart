import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/LoadingWidget.dart';
import '../controllers/EditProfileController.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: EditProfileController(),
        builder: (EditProfileController controller) {
          return !controller.isConnected
              ? NotConnectedErrorPage()
              : controller.isBusy
                  ? LoadingWidget(message: "Please wait...")
                  : MasterLayout(
                      title: 'Profile',
                      titleSpacing: 0,
                      actions: [],
                      body: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: kcPrimary,
                                    height: screen.height * 0.17,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Obx(() => Container(
                                                    margin: EdgeInsets.all(8),
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        color: kcWhite,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0)),
                                                        image: DecorationImage(
                                                          image: controller
                                                                      .image
                                                                      .path ==
                                                                  ''
                                                              ? NetworkImage(
                                                                      '${auth.user.avatar}')
                                                                  as ImageProvider
                                                              : FileImage(
                                                                  controller
                                                                      .image),
                                                          fit: BoxFit.cover,
                                                        )),
                                                  )),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.getImage();
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    height: 28,
                                                    width: 28,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: kcLightGreen,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/camera.svg',
                                                      color: kcBlack,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                          controller: controller.firstNameInput,
                                          placeholder: 'First Name',
                                          validator: (value) =>
                                              Validator("First Name", value!)
                                                  .required()
                                                  .validate(),
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
                                          'Last Name',
                                          style: TextStyl.bodySm,
                                        ),
                                        FormInput(
                                          controller: controller.lastNameInput,
                                          placeholder: 'Last Name',
                                          validator: (value) =>
                                              Validator("Last Name", value!)
                                                  .required()
                                                  .validate(),
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
                                          'DOB',
                                          style: TextStyl.bodySm,
                                        ),
                                        Obx(
                                          () => FormInputDate(
                                            value: controller.selectedDob,
                                            onChanged: (date) async {
                                              log.w(date.toString());
                                              controller.onDobSelect(date);
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
                                                  style: TextStyl.bodySm,
                                                ),
                                                value: 'Male',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  'Female',
                                                  style: TextStyl.bodySm,
                                                ),
                                                value: 'Female',
                                              ),
                                              DropdownMenuItem(
                                                child: Text(
                                                  'Other',
                                                  style: TextStyl.bodySm,
                                                ),
                                                value: 'Other',
                                              ),
                                            ],
                                            value: controller.selectedGender,
                                            onChanged: (value) => controller
                                                .onGenderSelect(value),
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
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'(^\d*\.?\d{0,2})')),
                                            LengthLimitingTextInputFormatter(6)
                                          ],
                                          type: TextInputType.numberWithOptions(
                                              decimal: true),
                                          controller: controller.weightInput,
                                          placeholder: 'Weight',
                                          validator: (value) =>
                                              Validator("Weight", value!)
                                                  .required()
                                                  .validate(),
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
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'(^\d*\.?\d{0,2})')),
                                            LengthLimitingTextInputFormatter(6)
                                          ],
                                          type: TextInputType.numberWithOptions(
                                              decimal: true),
                                          controller: controller.heightInput,
                                          placeholder: 'Height',
                                          validator: (value) =>
                                              Validator("Height", value!)
                                                  .required()
                                                  .validate(),
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
                                            options: <DropdownMenuItem>[
                                              DropdownMenuItem(
                                                child: Text(
                                                  'Select State',
                                                  style: TextStyl.bodySm,
                                                ),
                                                value: '0',
                                              ),
                                              ...List.generate(
                                                  controller.allState.length,
                                                  (index) {
                                                StateModel state =
                                                    controller.allState[index];
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    '${state.name}',
                                                    style: TextStyl.bodySm,
                                                  ),
                                                  value: state.id.toString(),
                                                );
                                              }),
                                            ],
                                            value: controller.selectedState,
                                            onChanged: (value) =>
                                                controller.onStateSelect(value),
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
                                            options: <DropdownMenuItem>[
                                              DropdownMenuItem(
                                                child: Text(
                                                  'Select City',
                                                  style: TextStyl.bodySm,
                                                ),
                                                value: '0',
                                              ),
                                              ...List.generate(
                                                  controller.allCity.length,
                                                  (index) {
                                                CityModel city =
                                                    controller.allCity[index];
                                                return DropdownMenuItem(
                                                  child: Text(
                                                    '${city.name}',
                                                    style: TextStyl.bodySm,
                                                  ),
                                                  value: city.id.toString(),
                                                );
                                              }),
                                            ],
                                            value: controller.selectedCity,
                                            onChanged: (value) =>
                                                controller.onCitySelect(value),
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
                                              controller.addressNameInput,
                                          placeholder: 'Address',
                                          action: TextInputAction.newline,
                                          rows: 2,
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
                                          controller: controller.pincodeInput,
                                          placeholder: 'Pincode',
                                          validator: (value) =>
                                              Validator("Pincode", value!)
                                                  .required()
                                                  .validate(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Button.block(
                            key: UniqueKey(),
                            label: "Update Profile",
                            flat: true,
                            onTap: (btn) async {
                              btn.setBusy(true).setDisabled(true);
                              await controller.updateProfile();
                              btn.setBusy(false).setDisabled(false);
                            },
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     await controller.updateProfile();
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(vertical: 18),
                          //     width: screen.width,
                          //     height: screen.height * 0.07,
                          //     color: kcPrimary,
                          //     child: Text(
                          //       "Update Profile",
                          //       style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ));
        });
  }
}
