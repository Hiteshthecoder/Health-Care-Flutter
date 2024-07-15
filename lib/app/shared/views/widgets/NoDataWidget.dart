import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({Key? key, required this.message, this.icon, this.retry = false, this.action}) : super(key: key);
  final String message;
  final Widget? icon;
  final bool retry;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    return GestureDetector(
      onTap: () {
        // if (retry) action!();
      },
      child: Container(
        height: screen.width * 1.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon == null)
              SvgPicture.asset(
                "assets/icons/no_data.svg",
                width: screen.width * 0.75,
              ),
            if (icon != null) icon!,
            SizedBox(height: spacer),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacer),
            // if (retry)
            //   Button(
            //     label: "Retry",
            //     onTap: (_) => action!(), key: UniqueKey(),
            //   ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
