import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';

class TrackingWidget extends StatelessWidget {
  const TrackingWidget({Key? key, this.sideBarColor, required this.title, required this.subTitle, required this.date, this.image}) : super(key: key);

  final Color? sideBarColor;
  final String title;
  final String subTitle;
  final String date;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: kcDarkAlt.withOpacity(0.15),
            blurRadius: 10,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(color: sideBarColor ?? Colors.green, borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 20,
              ),
              Text("$title", style: TextStyl.bodySm?.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: SizedBox(
                  width: 2,
                  height: 60,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: LinearProgressIndicator(
                      value: 0.0,
                      backgroundColor: sideBarColor ?? Colors.grey[300],
                      color: sideBarColor ?? Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("$image", width: 15,color: kcDarkAlt,),
                    SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "$subTitle",
                          style: TextStyl.bodySm?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kcBlack,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "$date",
                          style: TextStyl.bodySm?.copyWith(fontSize: 14, color: kcDarkAlt),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
