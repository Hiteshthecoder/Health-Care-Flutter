import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../shared/controllers/AppController.dart';

class ShareController extends AppController {
  static ShareController get to => Get.find();
  ScreenshotController screenshotController = ScreenshotController();
  late Uint8List imageFile;

  var _qrcode = ''.obs;

  /// Getter
  String get qrcode => _qrcode.value;

  @override
  onInit() {
    super.onInit();
    _qrcode.value = '${auth.user.id}';
  }

  void shareQRProgress() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path],
            text:
                'I use DQ Care to organize the medical history of my family and myself. By downloading the DQ Care for Doctors App, you will be able to access them. Link: https://www.dqcare.in');
      }
    });
  }
}
