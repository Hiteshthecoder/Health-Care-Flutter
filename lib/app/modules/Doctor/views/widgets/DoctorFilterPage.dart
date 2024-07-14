import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Doctor/controllers/DoctorController.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import '../../../../helpers/Global.dart';
import '../../../../models/CityModel.dart';
import '../../../../models/StateModel.dart';



class DoctorFilterPage extends StatelessWidget {
  final DoctorController controller;

  const DoctorFilterPage({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screen.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list_sharp,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Filters", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            size: 25,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: spacer1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                             // if (controller.states.length > 0)
                              ...List.generate(
                                controller.states.length,
                                    (index) {
                                  StateModel state = controller.states[index];
                                  return DropdownMenuItem(
                                    child: Text(
                                      '${state.name}',
                                      style: TextStyl.bodySm,
                                    ),
                                    value: '${state.id}',
                                  );
                                },
                              ),
                          ],
                          value: controller.selectedState,
                          onChanged: (value) => controller.onStateSelect(value),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                             // if (controller.cities.length > 0)
                              ...List.generate(
                                controller.cities.length,
                                    (index) {
                                  CityModel city = controller.cities[index];
                                  return DropdownMenuItem(
                                    child: Text(
                                      '${city.name}',
                                      style: TextStyl.bodySm,
                                    ),
                                    value: '${city.id}',
                                  );
                                },
                              ),
                          ],
                          value: controller.selectedCity,
                          onChanged: (value) => controller.onCitySelect(value),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'District',
                        style: TextStyl.bodySm,
                      ),
                      FormInput.text(
                        controller: controller.districtInput,
                        placeholder: 'District',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormLabel(
                        label: 'Pincode',
                      ),
                      SizedBox(height: spacer1),
                      SizedBox(
                        width: screen.width,
                        child: FormInput.number(
                          controller: controller.pincodeInput,
                          placeholder: 'Pincode',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: spacer,
                ),
                Button.block(
                  key: UniqueKey(),
                  label: "Apply",
                  onTap: (btn) async {
                    btn.setBusy(true).setDisabled(true);
                    await controller.applyFilter();
                    Get.back();
                    btn.setBusy(false).setDisabled(false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
