import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/Helpers.dart';

class AbhaProvidersScreen extends StatefulWidget {
  const AbhaProvidersScreen({super.key});

  @override
  State<AbhaProvidersScreen> createState() => _AbhaProvidersScreenState();
}

class _AbhaProvidersScreenState extends State<AbhaProvidersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tab = new TabController(length: 3, vsync: this);
    return GetBuilder(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: TabBarView(
                controller: tab,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: kcGray,
                      ),
                      hintText: "Search your Hospital, clinic or Lab name",
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 12,
                        color: kcDark,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: kcDark.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spacer2,
                  ),
                  Text(
                    "Government Programs",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      color: kcDark,
                    ),
                  ),
                  SizedBox(
                    height: spacer2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
