import 'package:flutter_mvc/app/modules/Summary/services/SummaryService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/SummaryModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';

class SummaryController extends AppController {
  static SummaryController get to => Get.find();

  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  var _tabIndex = RxInt(0);

  /// Getters
  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;

  ///Observables
  var _summaryData = SummaryModel().obs;

  ///Getter
  SummaryModel get summaryData => _summaryData.value;

  ///Variable
  final SummaryService _summaryService = SummaryService.instance;

  @override
  void onInit() {
    super.onInit();
    getSummaryData();
  }

  Future<void> getSummaryData() async {
    try {
      setBusy(true);

      ApiResponse response = await _summaryService.getSummaryData();
      log.w(response.data);
      if (response.hasError()) {
       // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      if(response.hasData())
        if(response.data != null)_summaryData(SummaryModel.fromJson(response.data));
    // _summaryData(SummaryModel.fromJson(response.data));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  void onTabChanged(int index) {
    _tabIndex(index);
  }
}
