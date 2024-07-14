import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';

class FormInputDate extends StatelessWidget {
  FormInputDate({Key? key, this.value, this.onChanged, this.firstDate, this.lastDate,  this.autoFocus}) : super(key: key);

  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool? autoFocus;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context, //context of current state
            initialDate: value ?? DateTime.now(),
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ?? DateTime(2101));
        if (pickedDate != null) {
          onChanged!(pickedDate);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: kcWhite,
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 1.0),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Text("${value!.year}-${value!.month < 10 ? "0" + value!.month.toString() : value!.month}-${value!.day}"),
            Spacer(),
            Icon(Icons.calendar_month_outlined,size: 18,color: kcPrimary),
          ],
        ),
      ),
    );
  }
}

