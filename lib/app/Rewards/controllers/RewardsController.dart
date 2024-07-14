import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../helpers/Global.dart';
import '../../models/ApiResponse.dart';
import '../../models/RewardsModel.dart';
import '../../shared/controllers/AppController.dart';
import '../services/RewardsService.dart';

class RewardsController extends AppController {
  static RewardsController get to => Get.find();

  /// Observables
  var _rewards = <RewardModel>[].obs;

  /// Getters

  List<RewardModel> get rewards => _rewards;

  /// Variables
  final RewardsService _rewardsService = RewardsService.instance;

  @override
  void onInit() {
    super.onInit();
    getRewardsData();
  }

  Future<void> getRewardsData() async {
    setBusy(true);

    /// Call api to Rewards user
    ApiResponse response = await _rewardsService.getRewardsData();
    log.w(response.toJson());

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }

    _rewards.assignAll(List<RewardModel>.from(response.data.map((x) => RewardModel.fromJson(x))));
    setBusy(false);
  }
}
