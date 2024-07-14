import 'dart:io';

import 'package:flutter_mvc/app/models/EprescriptionModel.dart';
import 'package:flutter_mvc/app/models/SummaryModel.dart';
import 'package:flutter_mvc/app/modules/Summary/services/SummaryService.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/EPrescriptionService.dart';
import 'package:http/http.dart' as http;

class EPrescriptionController extends AppController {
  static EPrescriptionController get to => Get.find();
  final SummaryService _summaryService = SummaryService.instance;
  SummaryModel? summaryData;
  String? url;

  /// Observables

  /// Getters

  var _downloadLoading = false.obs;

  var _percentageCount = 0.obs;

  /// Getters

  bool get downloadLoading => _downloadLoading.value;

  int get percentageCount => _percentageCount.value;

  /// Variables

  final EPrescriptionService _ePrescriptionService =
      EPrescriptionService.instance;

  List<EPrescriptionModel> allPrescriptions = [];
  EPrescriptionModel? prescriptionDetails;

  @override
  void onInit() async {
    super.onInit();
    getSummaryData();
  }

  void onDownloadLoading() {
    _downloadLoading(true);
    Future.delayed(Duration(seconds: 2), () {
      _downloadLoading(false);
    });
  }

  Future<void> getSummaryData() async {
    print("--------------------api call-------------------------");
    try {
      setBusy(true);

      ApiResponse response = await _summaryService.getSummaryData();
      if (response.hasError()) {
        // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      if (response.hasData()) {
        print("----------------------data-----------------------");
        summaryData = SummaryModel.fromJson(response.data);
        getPrescriptionList();
      } else {
        getPrescriptionList();
      }
    } on Exception catch (e) {
      print(e.toString());
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> getPrescriptionList() async {
    print("--------------------api call-------------------------");
    try {
      setBusy(true);

      ApiResponse response = await _ePrescriptionService
          .getPatientPrescriptionList(patientId: auth.user.id!);
      if (response.hasError()) {
        // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      if (response.hasData()) {
        allPrescriptions = [];
        for (var element in response.data) {
          print(element['symptomData']);
          print(element['medications']);
          print('----------------element--------------------');
          allPrescriptions.add(EPrescriptionModel.fromJson(element));
        }
        setBusy(false);
      }
      setBusy(false);
    } on Exception catch (e) {
      setBusy(false);
      print(e.toString());
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> getePrescriptionPdfAPI(int id) async {
    try {
      _downloadLoading(true);
      ApiResponse response = await _ePrescriptionService.getPrescriptionPdfAPI(
          prescriptionId: id.toString());

      log.w(response.toJson());

      if (response.hasError()) {
        _downloadLoading(false);
        // Toastr.show(message: "${response.message}");
        return;
      }
      if (response.isOk()) {
        url = response.data;

        downloadFile(url!, id);
      }
    } on Exception catch (e) {
      _downloadLoading(false);
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future downloadFile(String url, int prescriptionId) async {
    String? fullPath;
    try {
      String dir = await createFolder("HealthDetails");
      fullPath = dir + "/prescription$prescriptionId.pdf";
      File file = File(fullPath!);
      final fileResponse = await http.get(Uri.parse(url));
      if (fileResponse.statusCode == 200) {
        final bytes = fileResponse.bodyBytes;
        file.writeAsBytesSync(bytes, flush: true);
        OpenFile.open(fullPath);
        _downloadLoading(false);
      }
    } catch (e) {
      _downloadLoading(false);
      print("error");
      print(e);
    } finally {
      _downloadLoading(false);
    }
  }

  Future<String> createFolder(String cow) async {
    final dir =
        Directory((await getApplicationSupportDirectory()).path + '/$cow');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }
}
