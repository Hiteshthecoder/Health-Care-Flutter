import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/Aabha/views/abha_provider_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Sizes.dart';

class AbhaCardScreen extends StatefulWidget {
  const AbhaCardScreen({super.key});

  @override
  State<AbhaCardScreen> createState() => _AbhaCardScreenState();
}

class _AbhaCardScreenState extends State<AbhaCardScreen>
    with TickerProviderStateMixin {
  List<Widget> abhaCardTabs = [
    Tab(
      child: Text(
        "ABHA",
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Consents",
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Providers",
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: kcDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            // padding: EdgeInsets.symmetric(horizontal: spacer1),
            margin: EdgeInsets.symmetric(horizontal: spacer2),
            height: Get.size.height * 0.03,
            child: TabBar(
              // indicatorPadding: EdgeInsets.all(12),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kcWhite),
                color: kcWhite,
              ),
              tabs: abhaCardTabs,
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            // Container(
            //   height: Get.size.height * 0.12,
            //   padding: EdgeInsets.symmetric(
            //     horizontal: spacer3,
            //   ),
            //   child:
            // ),
            Text("1"),
            Text("2"),
            AbhaProvidersScreen(),
          ],
        ),
      ),
    );
  }
}
