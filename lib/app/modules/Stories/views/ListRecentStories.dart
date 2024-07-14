import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/views/errors/NotConnectedErrorPage.dart';
import '../../../shared/views/layouts/MasterLayout.dart';
import '../../../shared/views/widgets/TabPillWidget.dart';
import '../controllers/ListRecentStoriesController.dart';

class ListRecentStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ListRecentStoriesController(),
      builder: (ListRecentStoriesController controller) {
        return !controller.isConnected
            ? NotConnectedErrorPage()
            : MasterLayout(
                title: 'View HSD001 Story',

          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [

                  SizedBox(width: spacer4,),
                  GestureDetector(
                    onTap: (){
                      Get.dialog(
                        Dialog(
                          child:  Container(
                            width: 500,
                            margin: EdgeInsets.only(left: 0.0,right: 0.0),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text("Title here ", style: TextStyle(fontWeight: FontWeight.w600),),
                                      SizedBox(height: spacer2,),
                                      Text("A few of the main duties of a doctor are performing diagnostic tests, recommending specialists for patients, document patient's medical history, and educating patients. ")

                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 14.0,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.close, color: Colors.red,size: 20,),
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
                      height: 20,
                      width: 20,

                    ),

                  ),
                  SizedBox(width: spacer1,),
                ],
              ),


            ),
          ],
                titleSpacing: 0,
                body: RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: spacer, vertical: spacer3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Demography',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Divider(),
                          Text(
                            'Mayank Sarathe',style: TextStyl.body?.copyWith(fontSize: 16,color: kcPrimary.withOpacity(0.6),fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '23 year / Male', style: TextStyl.bodySm?.copyWith(fontSize: 13),),
                          Text(
                            '25 Nov, 2000', style: TextStyl.bodySm?.copyWith(fontSize: 13),),
                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            'Known case of',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10,),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                    'Case',
                                                    style: TextStyl.body?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: kcWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
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
                                              padding: const EdgeInsets.all(8.0),
                                            ),
                                          ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                              crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                            Text(
                                              '1. Hypertension',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            )
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [
                                            Text(
                                              '2. Diabetes mellitus- type 2',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            )
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [
                                            Text(
                                              '3. Right side upper and lower limb weakness',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            )
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [
                                            Text(
                                              '4. Ischemic heart disease',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            )
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [Text('Since 05/2020 (2 years)')]),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                              crossAxisAlignment : CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                              '5. Cortical blindness',
                                              style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                            )
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(children: [Text('Since 04?2022 (1 month)')]),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )),
                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            'Family History',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Case',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Mother and father had Type 2 DM',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Father died due to MI',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            ' Operative History',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Operatives',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),

                          Text(
                            'Habit History',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Habits',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),

                          Text(
                            'Any Allergy',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Allergy',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not Known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            'Current Medication',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Medicines',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '1. TabTelma 40',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                Text(
                                                  '2. Tab Metformin 500',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                Text(
                                                  '3. Tab Clopitab gold',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('Since 08/2010 (12 years)')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                Text(
                                                  '4. Tab ivabrad',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('Since 05/2020 (2 years)')]),
                                            ),
                                          ]),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),

                          Text(
                            'Vaccination History',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Vaccination',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),

                          Text(
                            'Last OPD Visit',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'OPD',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),

                          Text(
                            'Last Admitted',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Admitted',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Not known',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),


                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            'Immunization history',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth: FixedColumnWidth(172.0),
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
                                                        'Immunization',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
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
                                                  padding: const EdgeInsets.all(8.0),
                                                ),
                                              ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Covid vaccine-',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('05/2020')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '1 st dose',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('07/2021')]),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Booster dose',
                                                      style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                    )
                                                  ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('')]),
                                            ),
                                          ]),



                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          SizedBox(
                            height: spacer,
                          ),
                          Text(
                            'Other',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Center(
                              child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    child: SingleChildScrollView(
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
                                                        'Doctor',
                                                        style: TextStyl.body?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: kcWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Case',
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
                                                        'Date',
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
                                           TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Column(children: [
                                                  Text(
                                                    'Last admission',
                                                    style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                  )
                                                ]),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Column(children: [Text('For high blood sugar', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Column(children: [Text('04/2022', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                                              ),

                                            ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [
                                                Text(
                                                  'Last OPD visit',
                                                  style: TextStyl.bodySm?.copyWith(fontSize: 13),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('For regular check up', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(children: [Text('04/2022', style: TextStyl.bodySm?.copyWith(fontSize: 13))]),
                                            ),

                                          ]),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),

                          Text(
                            'Summary',
                            style: TextStyl.title?.copyWith(fontSize: 15),
                          ),
                          Text(
                              'A 52-year-old male patient. He suffered from paralysis 12 years before. No previous medical condition. Diagnosed with HTN and DM at that time only. On regular treatment from that event. Before 2 years he suffered from MI – got PTCA done. Last year suffered from covid. Got recovered. Now in recent admission had blurring of vision and headache. CT scan and MRI done. Also some blood investigations done.'),
                          Container(
                            color: kcWhite,
                            width: screen.width,
                            height: 65,
                            padding: const EdgeInsets.symmetric(horizontal: spacer, vertical: spacer3),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TabPillWidget(
                                      label: "Liver",
                                      onTap: () => controller.onTabChanged(0),
                                      active: controller.tabIndex == 0,
                                    ),
                                    TabPillWidget(
                                      label: "Blood Group",
                                      onTap: () => controller.onTabChanged(1),
                                      active: controller.tabIndex == 1,
                                    ),
                                    TabPillWidget(
                                      label: "Heart",
                                      onTap: () => controller.onTabChanged(2),
                                      active: controller.tabIndex == 2,
                                    ),
                                    TabPillWidget(
                                      label: "Blood Pressure",
                                      onTap: () => controller.onTabChanged(3),
                                      active: controller.tabIndex == 3,
                                    ),
                                    TabPillWidget(
                                      label: "Hb",
                                      onTap: () => controller.onTabChanged(4),
                                      active: controller.tabIndex == 4,
                                    ),
                                    TabPillWidget(
                                      label: "ECG",
                                      onTap: () => controller.onTabChanged(5),
                                      active: controller.tabIndex == 5,
                                    ),
                                    TabPillWidget(
                                      label: "CBC",
                                      onTap: () => controller.onTabChanged(6),
                                      active: controller.tabIndex == 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                              child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                child: SingleChildScrollView(
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
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Hemo',
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
                                                    '%',
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
                                                    '%',
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
                                                    '%',
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
                                        ]);
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
