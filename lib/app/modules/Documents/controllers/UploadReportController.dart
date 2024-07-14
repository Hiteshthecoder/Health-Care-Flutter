import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/UploadCategoryModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/ReportService.dart';

class UploadReportController extends AppController {
  static UploadReportController get to => Get.find<UploadReportController>();

  /// Observables
  var _selectedCategory = "0".obs;
  var _selectedImages = <File>[].obs;
  var report = "0".obs;
  var _tabIndex = RxInt(7);
  var _uploadData = <UploadCategoryModel>[].obs;
  var _hide = false.obs;
  var _allow = false.obs;


  /// Getters
  int get tabIndex => _tabIndex.value;

  String get selectedCategory => _selectedCategory.value;
  bool get allow => _allow.value;


  List<File> get selectedImages => _selectedImages;

  List<UploadCategoryModel> get uploadData => _uploadData;

  bool get hide => _hide.value;

  /// Variables
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  TextEditingController taskInput = TextEditingController();
  final ReportService _reportService = ReportService.instance;

  void onCategorySelect(String value) {
    _selectedCategory(value);
  }

  void onSelect(bool value) {
    _hide(value);
  }

  void onShowCategory(bool value) {
    _hide(value);
  }


  void tapSelect(int index) {
    onTabChanged(index);
  }

  @override
  void onInit() async {
    super.onInit();
    getCategories();

  }


    void allowAccess(String value) async {
      var arr = ['png', 'jpg', 'jpeg', 'webp',];
      print(arr.contains(value));
     //arr.contains(value);
      if(arr.contains(value)){
        print('open');
      }else{
        print('close');

      }
  }
   // void onAllow(String value) async {
   //   allowAccess(value);
   // }

  void captureImage() async {
    Get.back();
    var image = await Get.toNamed('/pdf-camera');
    if (image != null) {
      image = File(image);
      _selectedImages.add(image);
    } else {
      return;
    }
  }

  Future<void> getCategories() async {
    try {
      setBusy(true);
      ApiResponse response = await _reportService.getCategories();
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }
      _uploadData.assignAll(List<UploadCategoryModel>.from(response.data.map((x) => UploadCategoryModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> documentUpload() async {
    MultipartRequest request = http.MultipartRequest("POST", Uri.parse(Config.apiBaseUrl + "/patient/upload-document"));
    log.w(_selectedImages);

    request.fields['category_id'] = _selectedCategory.value;
    log.w(_selectedCategory.value);

    /// Files
    for (File image in _selectedImages) {
      request.files.add(await http.MultipartFile.fromPath(
        "file[]",
        image.path.toString(),
      ));
    }

    /// Set Headers
    Map<String, String> _headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + storage.read('token'),
    };
    request.headers.addAll(_headers);
    StreamedResponse send = await request.send().timeout(60.seconds);

    http.Response res = await http.Response.fromStream(send);
    log.w(res.body.toString());
    ApiResponse response = ApiResponse.fromJson(jsonDecode(res.body));
    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    Get.offAllNamed("\dashboard");
    Toastr.show(message: "${response.message}");
  }

  // void getImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     _selectedImages.clear();
  //     List<File> files = result.paths.map((path) => File(path!)).toList();
  //     _selectedImages.assignAll(files);
  //   } else {
  //     Get.snackbar(
  //       'Error',
  //       ' No Image Selected',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: kcPrimary,
  //       colorText: kcWhite,
  //     );
  //}
  // }

  void getImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowCompression: true,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'webp','pdf'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      log.w(files);
      _selectedImages.addAll(files);
    } else {
      // Get.snackbar(
      //   'Error',
      //   ' No Image Selected',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: kcPrimary,
      //   colorText: kcWhite,
      // );
    }
  }

  void deleteFile(int index) async {
    _selectedImages.removeAt(index);
  }

  void clearImages() async {
    showBusy();
    _selectedImages.clear();
    Future.delayed(1.seconds, () => hideBusy());
  }

  void onTabChanged(int index) {
     onSelect(true);
    _tabIndex(index);
    _selectedCategory(_uploadData.elementAt(index).id.toString());
    log.i(_uploadData.elementAt(index).name);
    log.w(_selectedCategory.value);
  }
  Future<void> launchUrlStart({required String url}) async {
    if (await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }




}
