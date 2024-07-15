import 'package:flutter/widgets.dart';
import 'package:flutter_mvc/app/shared/controllers/AppController.dart';

class aabha1Controller extends AppController {
  TextEditingController aadhaarCardController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    aadhaarCardController.dispose();
  }
}