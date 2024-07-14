import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../helpers/Global.dart';
import '../../../models/CityModel.dart';
import '../../../models/RelationModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../controllers/AddMemberController.dart';

class AddMemberPage extends StatelessWidget {
  final AddMemberController controller = Get.put(AddMemberController());

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
        titleSpacing: 0,
        title: 'Add Member Profile',
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  width: spacer4,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/linkmember'),
                  child: SvgPicture.asset(
                    'assets/icons/link.svg',
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
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: kcPrimary,
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            Center(
                              // child: Stack(
                              //   alignment: Alignment.bottomRight,
                              //   children: [
                              //     Container(
                              //       margin: EdgeInsets.all(8),
                              //       width: 100,
                              //       height: 100,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              //         image: DecorationImage(image: AssetImage('assets/images/avatar.png',), fit: BoxFit.cover ),
                              //         color: kcWhite
                              //       ),
                              //     ),
                              //     Container(
                              //         padding: const EdgeInsets.all(7.0),
                              //        height: 28,
                              //        width: 28,
                              //        decoration: BoxDecoration(
                              //          borderRadius: BorderRadius.circular(15),
                              //          color: kcLightGreen,
                              //        ),
                              //         child: SvgPicture.asset(
                              //       'assets/icons/camera.svg',
                              //       color: kcBlack,
                              //     )),
                              //   ],
                              // ),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Obx(
                                    () => Container(
                                      margin: EdgeInsets.all(8),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: kcWhite,
                                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                          image: DecorationImage(
                                            image: controller.image.path == ''
                                                ? AssetImage(
                                                    'assets/images/avatar.png',
                                                  ) as ImageProvider
                                                : FileImage(controller.image),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.getImage();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: kcLightGreen,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        color: kcBlack,
                                      ),
                                    ),
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
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: TextStyl.bodySm,
                            ),
                            FormInput(
                              controller: controller.firstNameInput,
                              placeholder: 'First Name',
                              validator: (value) => Validator("First Name", value!).required().validate(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: TextStyl.bodySm,
                            ),
                            FormInput(
                              controller: controller.lastNameInput,
                              placeholder: 'Last Name',
                              validator: (value) => Validator("Last Name", value!).required().validate(),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Phone ',
                      //         style: TextStyl.bodySm,
                      //       ),
                      //       FormInput.number(
                      //         controller: controller.phoneInput,
                      //         placeholder: 'Number',
                      //        validator: (value) => Validator("Number", value!).specialCharacter().between(10, 12).required().validate(),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Email',
                      //         style: TextStyl.bodySm,
                      //       ),
                      //       FormInput.email(
                      //         controller: controller.emailInput,
                      //         placeholder: 'Email',
                      //
                      //
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DOB',
                              style: TextStyl.bodySm,
                            ),
                            Obx(
                              () => FormInputDate(
                                autoFocus: true,
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
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                onChanged: (value) => controller.onGenderSelect(value),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Address',
                      //         style: TextStyl.bodySm,
                      //       ),
                      //       FormInput(
                      //         controller: controller.addressInput,
                      //         placeholder: 'Address',
                      //         validator: (value) => Validator("Address", value!).required().validate(),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Relation',
                              style: TextStyl.bodySm,
                            ),
                            Obx(
                              () => FormSelect(
                                autoFocus: true,
                                options: <DropdownMenuItem>[
                                  DropdownMenuItem(
                                    child: Text(
                                      'Select Relation',
                                      style: TextStyl.bodySm,
                                    ),
                                    value: '0',
                                  ),
                                  ...List.generate(controller.relation.length, (index) {
                                    RelationModel memberRelation = controller.relation[index];
                                    return DropdownMenuItem(
                                      child: Text(
                                        '${memberRelation.name}',
                                        style: TextStyl.bodySm,
                                      ),
                                      value: memberRelation.id.toString(),
                                    );
                                  }),
                                ],
                                value: controller.selectedRelation,
                                onChanged: (value) => controller.onSelectRelation(value),
                              ),
                            ),
                            // FormInput(
                            //   controller: controller.relationInput,
                            //   placeholder: 'Relation',
                            //   validator: (value) => Validator("Relation", value!).required().validate(),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: TextStyl.bodySm,
                                    ),
                                    value: '0',
                                  ),
                                  ...List.generate(controller.allState.length, (index) {
                                    StateModel state = controller.allState[index];
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
                                onChanged: (value) => controller.onStateSelect(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: TextStyl.bodySm,
                                    ),
                                    value: '0',
                                  ),
                                  ...List.generate(controller.allCity.length, (index) {
                                    CityModel city = controller.allCity[index];
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
                                onChanged: (value) => controller.onCitySelect(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyl.bodySm,
                            ),
                            FormInput.multiline(
                              controller: controller.addressInput,
                              placeholder: 'Address',
                              action: TextInputAction.newline,
                              validator: (value) => Validator("Address", value!).required().validate(),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pincode',
                              style: TextStyl.bodySm,
                            ),
                            FormInput.number(
                              controller: controller.pincodeInput,
                              placeholder: 'Pincode',
                              validator: (value) => Validator("Pincode", value!).specialCharacter().between(6, 10).required().validate(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //       width: screen.width,
            //       height: screen.height * 0.07,
            //   child: Button.block(
            //     key: UniqueKey(),
            //     label: "Save",
            //     onTap: (btn) async {
            //       btn.setBusy(true).setDisabled(true);
            //       await controller.addMember();
            //       Get.back();
            //       btn.setBusy(false).setDisabled(false);
            //     },
            //
            //   ),
            // ),
            Button.block(
              key: UniqueKey(),
              label: "Save",
              flat: true,
              onTap: (btn) async {
                btn.setBusy(true).setDisabled(true);
                await controller.addMember();
                btn.setBusy(false).setDisabled(false);
              },
            ),
            // GestureDetector(
            //   onTap: (){
            //     controller.addMember();
            //   },
            //
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //     width: screen.width,
            //     height: screen.height * 0.07,
            //     decoration: BoxDecoration(
            //       color: kcPrimary,
            //     ),
            //     child: Text(
            //       "Save",
            //       style: TextStyl.bodySm?.copyWith(fontSize: 15, color: kcWhite),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
