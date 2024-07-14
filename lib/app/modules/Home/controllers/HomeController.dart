import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import '../../../models/SliderModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
import '../services/HomeService.dart';

class HomeController extends AppController {
  static HomeController get to => Get.find();

  /// Observables

  var _sliderOne = <SliderModel>[].obs;
  var _sliderTwo = <SliderModel>[].obs;

  /// Getters

  List<SliderModel> get sliderOne => _sliderOne;

  List<SliderModel> get sliderTwo => _sliderTwo;

  /// Variables

  final HomeService _homeService = HomeService.instance;

  @override
  void onInit() {
    super.onInit();
    getHomeSlider();
  }

  Future<void> getHomeSlider() async {
    try {
      setBusy(true);
      ApiResponse response = await _homeService.getHomeSlider();

      if (response.hasError()) {
        setBusy(false);
        return;
      }
      _sliderOne.assignAll(List<SliderModel>.from(response.data['sliders']['first_slider'].map((x) => SliderModel.fromJson(x))));
      _sliderTwo.assignAll(List<SliderModel>.from(response.data['sliders']['second_slider'].map((x) => SliderModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }
}
