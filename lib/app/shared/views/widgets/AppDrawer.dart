import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kcWhite,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kcdblue,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/services');
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                            color: kcWhite,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Doctor Name ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: kcWhite,
                                  fontSize: 18),
                            ),
                            Text(
                              'Clinic Name',
                              style: TextStyle(color: kcWhite, fontSize: 12),
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

          ListTile(
            leading: Icon(
              Icons.home,size: 20,color: kcdblue,
            ),
            title: const Text('Recent Stories',style: TextStyle(fontSize: 16),),
            onTap: () {
            Get.toNamed('/recentStories');
            },
          ),

          Divider( thickness: 0.5,),

          ListTile(
            leading:  SvgPicture.asset('assets/images/patientNav.svg',color: kcdblue, height: 20,width: 20,
            ),
            title: const Text('Patient',style: TextStyle(fontSize: 16),),
            onTap: () {
          //Navigator.pushNamed(context, '/myorder');
            },
          ),
          Divider( thickness: 0.5,),

          ListTile(
            leading:  SvgPicture.asset('assets/images/referralnav.svg',color: kcdblue, height: 20,width: 20,
            ),
            title: const Text('Referral',style: TextStyle(fontSize: 16),),
            onTap: () {
          Navigator.pushNamed(context, '/announcement');
            },
          ),
          Divider( thickness: 0.5,),

          ListTile(
            leading:   SvgPicture.asset('assets/images/calendar-clock.svg',color: kcdblue, height: 20,width: 20,
            ),
            title: const Text('Follow-Up',style: TextStyle(fontSize: 16),),
            onTap: () {
          Get.toNamed('/ticket_raise');
            },
          ),
          Divider( thickness: 0.5,),
          ListTile(
            leading: Icon(
          Icons.logout,size: 20,color: kcdblue,
            ),
            title: const Text('Logout',style: TextStyle(fontSize: 16),),
            onTap: () {
          Get.toNamed('/login');
            },
          ),
          Divider( thickness: 0.5,),
          // SizedBox(height: 150,),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("@ 2022 Copyrights MediStory ",style: TextStyle(color: kcBlack.withOpacity(0.5),fontSize: 14),),
          // ),

        ],
      ),
    );


  }

}