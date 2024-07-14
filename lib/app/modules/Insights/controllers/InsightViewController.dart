import 'package:flutter_mvc/app/models/UserModel.dart';
import 'package:get/get.dart';
import 'package:ui_x/ui_x.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/InsightModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/InsightService.dart';

class InsightViewController extends AppController {
  static InsightViewController get to => Get.find();

  var _selectedInsight = 'blood'.obs;
  var _selectedInsightTab = 'none'.obs;
  var _insights = <InsightModel>[].obs;
  var _selectedCategory = "0".obs;
  var _tabIndex = RxInt(0);
  var _hasStory = false.obs;
  var _insight = UserModel().obs;

  ///Getter
  List<InsightModel> get insights => _insights;

  String get selectedCategory => _selectedCategory.value;

  int get tabIndex => _tabIndex.value;

  bool get hasStory => _hasStory.value;

  UserModel get insight => _insight.value;

  String get selectedInsight => _selectedInsight.value;

  String get selectedInsightTab => _selectedInsightTab.value;

  ///Variable
  final InsightService _insightService = InsightService.instance;

  @override
  void onInit() {
    super.onInit();
    getInsightData();
    //log.i(auth.user.subscription?.toJson());
  }

  void onSelectCategory(String value) {
    // _selectedReferralStore(referralNameInput.text = value);
  }

  void onTabChanged(int index) {
    _tabIndex(index);
  }

  Future<void> getInsightData() async {
    try {
      setBusy(true);
      ApiResponse response = await _insightService.getInsightData();

      log.w(response.toJson());
      if (response.hasError()) {
        //Get.offNamed('/upload');
        setBusy(false);
        return;
      }

      if (response.hasData()) {
        _insight(UserModel.fromJson(response.data));
        _hasStory(response.data['has_story']);
        if (response.data['chart'] != null) _insights.assignAll(List<InsightModel>.from(response.data['chart'].map((x) => InsightModel.fromJson(x))));
      }

      _selectedInsightTab('haemoglobin');
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  void onTabSelected(String tabName, String insightName) {
    _selectedInsightTab(tabName);
    _selectedInsight(insightName);
  }

  Future<void> getCategory() async {
    try {
      setBusy(true);

      ApiResponse response = await _insightService.getInsightData();

      log.w(response.toJson());

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        // Get.offNamed('/upload');
        return;
      }
      _insights.assignAll(List<InsightModel>.from(response.data.map((x) => InsightModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }
}
