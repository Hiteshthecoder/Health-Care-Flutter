import 'package:flutter_mvc/app/modules/Doctor/services/DoctorService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/DoctorModel.dart';
import '../../../shared/controllers/AppController.dart';

class ProfileDetailsController extends AppController {
  static ProfileDetailsController get instance => Get.find();

  ///Observables
  var _showDetails = DoctorModel().obs;
  var _experienceDetails = <Experience>[].obs;
  var _qualificationDetails = <Qualification>[].obs;
  var _tapIndex = 0.obs;
  var _hideSchedule = "".obs;
  var _hide = false.obs;
  var _day = "".obs;

  ///Getter

  DoctorModel get showDetails => _showDetails.value;

  List<Experience> get experienceDetails => _experienceDetails;

  List<Qualification> get qualificationDetails => _qualificationDetails;

  int get tapIndex => _tapIndex.value;

  String get hideSchedule => _hideSchedule.value;

  bool get hide => _hide.value;

  String get day => _day.value;

  ///Variable
  final DoctorService _doctorService = DoctorService.instance;

  @override
  void onInit() {
    super.onInit();
    _day(DateTime.now().formatted("EEE"));
    onTapShow(_day.value, true);
    getDoctorShowDetails();
  }

  void onTapChange(int value) {
    _tapIndex(value);
  }

  ///First Time
  void onTapShow(String value, bool hide) {
    _hide(!_hide.value);
    if (_hide.value == true) {
      _day.value == "Mon"
          ? _hideSchedule("Monday")
          : _day.value == "Tue"
              ? _hideSchedule("Tuesday")
              : _day.value == "Wed"
                  ? _hideSchedule("Wednesday")
                  : _day.value == "Thu"
                      ? _hideSchedule("Thursday")
                      : _day.value == "Fri"
                          ? _hideSchedule("Friday")
                          : _day.value == "Sat"
                              ? _hideSchedule("Saturday")
                              : _day.value == "Sun"
                                  ? _hideSchedule("Sunday")
                                  : _hideSchedule("");
    } else {
      _hideSchedule("");
    }
  }

  void onTapHide(String value) {
    _hide(!_hide.value);
    if (_hide.value == true) {
      _hideSchedule(value);
    } else {
      _hideSchedule("");
    }
  }

  Future<void> getDoctorShowDetails() async {
    setBusy(true);
    ApiResponse response = await _doctorService.getDoctorShowDetails(id: int.parse(Get.parameters["id"].toString()));
    log.w(response.data);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    // _showDetails.assignAll(List<DoctorModel>.from(response.data.map((x) => DoctorModel.fromJson(x))));
    _showDetails(DoctorModel.fromJson(response.data));
    _experienceDetails.assignAll(List<Experience>.from(response.data['experience'].map((x) => Experience.fromJson(x))));
    _qualificationDetails.assignAll(List<Qualification>.from(response.data['qualification'].map((x) => Qualification.fromJson(x))));
    setBusy(false);
  }
}
