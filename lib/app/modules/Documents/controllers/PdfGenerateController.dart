import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ui_x/ui_x.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/UploadCategoryModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/ReportService.dart';

class PdfGenerateController extends AppController {
  static PdfGenerateController get to => Get.find<PdfGenerateController>();

  /// Observables
  var _selectedCategory = "0".obs;
  var _selectedImages = <File>[].obs;
  var report = "0".obs;
  var _tabIndex = RxInt(4);
  var _uploadData = <UploadCategoryModel>[].obs;

  /// Getters
  int get tabIndex => _tabIndex.value;

  String get selectedCategory => _selectedCategory.value;

  List<File> get selectedImages => _selectedImages;

  List<UploadCategoryModel> get uploadData => _uploadData;

  /// Variables
  TextEditingController taskInput = TextEditingController();
  final ReportService _reportService = ReportService.instance;
  var pdf;

  void onCategorySelect(String value) {
    _selectedCategory(value);
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    pdf = pw.Document();
    // camera = CameraController(_cameras[0], ResolutionPreset.max);
    // camera.initialize().then((_) {
    //   if (camera != null) {
    //     return;
    //   }
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         print('User denied camera access.');
    //         break;
    //       default:
    //         print('Handle other errors.');
    //         break;
    //     }
    //   }
    // });
  }

  // @override
  // void dispose() {
  //   camera.dispose();
  //   super.dispose();
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
      _uploadData.assignAll(List<UploadCategoryModel>.from(
          response.data.map((x) => UploadCategoryModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> documentUpload() async {
    MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse(Config.apiBaseUrl + "/patient/upload-document"));

    request.fields['category_id'] = _selectedCategory.value;

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
    Get.back();
    Toastr.show(message: "${response.message}");
  }

  void getImage() async {
    Get.back();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'webp'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
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
    _tabIndex(index);
    _selectedCategory(_uploadData.elementAt(index).id.toString());
    log.i(_uploadData.elementAt(index).name);
    log.w(_selectedCategory.value);
  }

  Future<void> createPDF() async {
    for (var img in _selectedImages) {
      final image = pw.MemoryImage(img.readAsBytesSync());
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(image));
          },
        ),
      );
    }
  }

  void savePDF() async {
    final status = await Permission.storage.status;
    // try {
    //   final dir = await getExternalStorageDirectory();
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
    }
    var dir = await DownloadsPathProvider.downloadsDirectory;
    log.i("${dir!.path}");
    await createPDF();
    final file = File(
        '${dir.path}/HealthDetailsReport_${DateTime.now().microsecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());
    Get.back();
    // Toastr.show(message: "PDF is saved to download folder");

    // } catch (e) {
    //   Toastr.show(message: "The document has already been saved");
    //   log.w(e.toString());
    // }
  }
}
