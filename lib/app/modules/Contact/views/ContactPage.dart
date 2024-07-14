import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/shared/views/layouts/MasterLayout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/views/widgets/AppDrawer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      title: "Contact",
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: spacer4,
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    Dialog(
                      child: Container(
                        width: 500,
                        margin: EdgeInsets.only(left: 0.0, right: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    "Title here ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: spacer2,
                                  ),
                                  Text(
                                      "A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients. ")
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0.0,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/contact.svg',
                  color: kcWhite,
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
          SizedBox(
            width: 10,
            height: 10,
          ),
          Center(
            child: Card(
              elevation: 0.75,
              color: Colors.white,
              child: ClipPath(
                child: Container(
                  width: 360,

                  // decoration: BoxDecoration(
                  //     border: Border(left: BorderSide(color: Colors.black, width: 5))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/query.png',
                                height: 250,
                                width: 250,
                                //   fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 10,
                                height: 60,
                              ),
                              Text('If any Query ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kcBlack.withOpacity(0.7))),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Contact our Defenzelite Team ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kcBlack.withOpacity(0.7))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('Contact'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kclightBlue,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              launch('https://www.defenzelite.com/');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
