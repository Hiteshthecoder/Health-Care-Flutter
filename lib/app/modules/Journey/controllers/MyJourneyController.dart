import 'package:flutter_mvc/app/models/JourneyModel.dart';
import 'package:flutter_mvc/app/modules/Journey/services/JourneyService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';


class MyJourneyController extends AppController {
  static MyJourneyController get to => Get.find();



  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  var _tabIndex = RxInt(0);

  /// Getters
  List<Map<String, dynamic>> get tasks => _tasks;

  int get tabIndex => _tabIndex.value;


  ///Observables
  var _journeyData = JourneyModel().obs;

  ///Getter
  JourneyModel get journeyData => _journeyData.value;

  ///Variable
  final JourneyService _journeyService = JourneyService.instance;


  @override
  void onInit() async {
    super.onInit();
    getJourneyData();
    await auth.getUser();
  }

  Future<void> getJourneyData() async {
    try {
      setBusy(true);

      ApiResponse response = await _journeyService.getJourneyData();

       log.w(response.toJson());
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }

      if(response.hasData()) _journeyData(JourneyModel.fromJson(response.data));
      setBusy(false);

    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

    void onTabChanged(int index) {
      _tabIndex(index);
    }
  }


