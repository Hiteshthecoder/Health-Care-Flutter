import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomSheet;

  AuthLayout(
      {Key? key, required this.body, this.backgroundColor, this.bottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: body,
    );
  }
}
