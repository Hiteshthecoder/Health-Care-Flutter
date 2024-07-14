import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Doctor/controllers/DoctorController.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../../helpers/Global.dart';



class DeleteWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    DoctorController doctorController = Get.put(DoctorController());
    return Scaffold(body:
    SingleChildScrollView(
      child: Container(
        width: screen.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

               GestureDetector(
                   // onTap: () => controller.deletePost(id: community.id!),

                    child: Container(
                      decoration: BoxDecoration(
                        color: kcWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Text(
                        'Delete',
                        style: TextStyl.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),




            ],
          ),
        ),
      ),
    ));
  }
}
