import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Doctor/controllers/DoctorController.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import '../../../../helpers/Global.dart';



class BloodPicture extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child:
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: FixedColumnWidth(115.0),
            border: TableBorder.all(color: kcDarkAlt.withOpacity(0.4), style: BorderStyle.solid, width: 1),
            children: [
              TableRow(
                  decoration: BoxDecoration(
                    color: kcPrimary.withOpacity(0.7),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Date',
                            style: TextStyl.body?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'Haemoglobin (Hb)',
                        style: TextStyl.body?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kcWhite,
                        ),
                      ),
                    ),
                    Padding(
                      child: Column(
                        children: [
                          Text(
                            'WBC',
                            style: TextStyl.body?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Padding(
                      child: Column(
                        children: [
                          Text(
                            'Platlets',
                            style: TextStyl.body?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Padding(
                      child: Column(
                        children: [
                          Text(
                            'Retic count',
                            style: TextStyl.body?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Padding(
                      child: Column(
                        children: [
                          Text(
                            'Hematocrit (Hct)',
                            style: TextStyl.body?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kcWhite,
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),

                  ]),
              ...List.generate(8, (index) {
                return TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [
                      Text(
                        '26/09/2022',
                        style: TextStyl.bodySm?.copyWith(fontSize: 13),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [Text('332', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [Text('50', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [Text('50')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [Text('50')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [Text('50')]),
                  ),
                ]);
              }),
            ],
          ),
        ),

    )
    )
    );
  }
}
