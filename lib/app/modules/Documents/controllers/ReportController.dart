import 'package:flutter_mvc/app/models/ReportModel.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/ReportService.dart';

class ReportController extends AppController {
  static ReportController get to => Get.find<ReportController>();

  ///Observables
  var _reportData = <ReportModel>[].obs;
  var _report = ReportModel().obs;
  var _reportCategory = <ReportModel>[].obs;
  var _isChecked = false.obs;
  var _buttonEnabled = false.obs;

  ///Getter
  List<ReportModel> get reportData => _reportData;
  ReportModel get report => _report.value;
  List<ReportModel> get reportCategory => _reportCategory;
  bool get isChecked => _isChecked.value;
  bool get buttonEnabled => _buttonEnabled.value;

  ///Variable
  final ReportService _reportService = ReportService.instance;

  @override
  void onInit() {
    super.onInit();
    getReportData();
    if (_isChecked.value = false)
      _buttonEnabled(true);
    else
      _buttonEnabled(false);
  }

  set isCheck(bool value) {
    _isChecked(!_isChecked.value);
  }

  void tapChecked() {
    _isChecked(!_isChecked.value);
  }

  Future<void> getReportData() async {
    try {
      setBusy(true);

      /// Call api to login user
      ApiResponse response = await _reportService.getReportData();

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      // if(response.data =="Chart data is not found!"){
      //   return Get.offNamed('/upload');
      // }else{
      //   _reportData.assignAll(List<ReportModel>.from(response.data.map((x)=> ReportModel.fromJson(x))));
      // }
      _report(ReportModel.fromJson(response.data));
      _reportData.assignAll(List<ReportModel>.from(response.data['report'].map((x) => ReportModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> organiseReport({required int authId}) async {
    // try {
    setBusy(true);
    Map<String, dynamic> body = {
      "user_id": auth.user.id,
    };
    ApiResponse response = await _reportService.organiseReport(body: body, authId: authId);

    log.w(response.toJson());

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    setBusy(false);
    Get.back();
    Toastr.show(message: "${response.message}");
    // } on Exception catch (e) {
    //   Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    // }
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
