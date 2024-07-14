import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:ui_x/ui_x.dart';

class PrecptionTabPillWidget extends StatelessWidget {
   PrecptionTabPillWidget({Key? key, this.text ,this.image, required this.label, required this.onTap, this.active = false, this.activeColor = kcPrimary}) : super(key: key);
  final Widget? image;
  final Widget? text;
  final String label;
  final VoidCallback onTap;
  final bool active;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap:  onTap,
        child: Container(
          width: screen.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: active ? kcPrimary : kcWhite,width: 2)
            ),
          ),
          margin: const EdgeInsets.only(right: spacer1),
          padding: const EdgeInsets.symmetric(vertical: spacer2, horizontal: spacer3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(text != null)text!,
              if(text != null)SizedBox(width: 8,),
              if(image != null)image!,
              if(image != null)SizedBox(width: 8,),
              Text(
                "$label",
                style: TextStyl.bodySm?.copyWith(color: active ? kcDark : kcDark),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
