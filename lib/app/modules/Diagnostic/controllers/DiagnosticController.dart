import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/models/StateModel.dart';
import 'package:flutter_mvc/app/modules/Diagnostic/services/DiagnosticService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/DiagnosticModel.dart';
import '../../../shared/controllers/AppController.dart';

class DiagnosticController extends AppController {
  static DiagnosticController get instance => Get.find();

  /// Variables
  var _diagnosticData = <DiagnosticModel>[].obs;
  var _loadingMore = false.obs;
  var _dataEnded = false.obs;
  var _page = 1.obs;
  var _filterApplied = false.obs;
  var _states = <StateModel>[].obs;
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _cities = <CityModel>[].obs;
  var _selectedDistrict = '0'.obs;

  ///Getter
  List<DiagnosticModel> get diagnosticData => _diagnosticData;

  ///Variable
  final DiagnosticService _diagnosticService = DiagnosticService.instance;





  String get selectedState => _selectedState.value;

  String get selectedCity => _selectedCity.value;

  String get selectedDistrict => _selectedDistrict.value;

  List<StateModel> get states => _states;

  List<CityModel> get cities => _cities;

  bool get loadingMore => _loadingMore.value;

  bool get filterApplied => _filterApplied.value;

  final TextEditingController districtInput = TextEditingController();
  final TextEditingController pincodeInput = TextEditingController();

  void onStateSelect(String value) {
    _selectedCity('0');
    _selectedState(value);
    getCity(stateId: int.parse(value), initialCall: true);
  }

  void onCitySelect(String value) {
    _selectedCity(value);
  }

  @override
  void onInit() {
    super.onInit();
    if (_filterApplied.value == false) {
      applyFilter();
    } else {
      getDiagnosticData();
    }
    getStates();
    scrollController.addListener(() {
      if (double.parse((scrollController.positions.last.maxScrollExtent - 10).toString()) <= scrollController.positions.last.pixels) {
        if (!_dataEnded.value) getDiagnosticData(next: true);
      }
    });
  }

  Future<void> applyFilter() async {
    _filterApplied(true);
    await getDiagnosticData();
  }

  Future<void> getDiagnosticData({bool immediate = false, bool next = false}) async {
    // try {
    if (!immediate && !next) setBusy(true);
    ApiResponse response;

    if (next) setBusy(false);
    if (next) _loadingMore(true);
    if (next) _page(_page.value + 1);

    /// Call api to login user
    if (_filterApplied.value) {
      response = await _diagnosticService.getDiagnosticData(
          state: _selectedState.value, city: _selectedCity.value, district: districtInput.text, pincode: pincodeInput.text,page: _page.value);
    } else {
      response = await _diagnosticService.getDiagnosticData(
          state: _selectedState.value, city: _selectedCity.value, district: districtInput.text, pincode: pincodeInput.text, page: _page.value);
    }
    // ApiResponse response = await _diagnosticService.getDiagnosticData(
    //     state: _selectedState.value, city: _selectedCity.value, district: districtInput.text, pincode: pincodeInput.text, page: _page.value);

    log.w(response.toJson());

    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      // setBusy(false);
      return;
    }
    if (response.hasData()) {
      if (next) {
        _diagnosticData.addAll(List<DiagnosticModel>.from(response.data.map((x) => DiagnosticModel.fromJson(x))));
      } else {
        _diagnosticData.assignAll(List<DiagnosticModel>.from(response.data.map((x) => DiagnosticModel.fromJson(x))));
      }
    } else {
      if (!next) {
        _diagnosticData.clear();
      }
      _dataEnded(true);
    }
    _loadingMore(false);
    setBusy(false);

    // } on Exception catch (e) {
    //   Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    // }
  }


  Future<void> getStates() async {
    setBusy(true);
    ApiResponse response = await _diagnosticService.getState();
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _states.assignAll(List<StateModel>.from(response.data.map((x) => StateModel.fromJson(x))));
    } else {
      _states.clear();
    }
    getCity(stateId: int.parse(_selectedState.value));
    setBusy(false);
  }

  Future<void> getCity({required int stateId, bool initialCall = false}) async {
    ApiResponse response = await _diagnosticService.getCity(stateID: stateId);

    if (response.hasError()) {
     // Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _cities.assignAll(List<CityModel>.from(response.data.map((x) => CityModel.fromJson(x))));
    } else {
      _cities.clear();
    }
    // setData();
  }
}
