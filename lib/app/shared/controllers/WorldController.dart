import 'dart:async';
import 'package:flutter_mvc/app/models/CityModel.dart';

import 'package:flutter_mvc/app/shared/controllers/AppController.dart';
import 'package:flutter_mvc/app/shared/services/world/WorldService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../helpers/Global.dart';
import '../../models/ApiResponse.dart';

import '../../models/StateModel.dart';

class WorldController extends AppController {
  static WorldController get instance {
    if (!Get.isRegistered<WorldController>()) Get.put(WorldController());

    return Get.find<WorldController>();
  }

  /// Observables
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _allState = <StateModel>[].obs;
  var _allCity = <CityModel>[].obs;

  var _selectedPatient = "0".obs;

  /// Getters
  String get selectedState => _selectedState.value;
  String get selectedCity => _selectedCity.value;

  List<StateModel> get allState => _allState;
  List<CityModel> get allCity => _allCity;



  WorldService worldService = WorldService.instance;


  void onStateSelect(String value) {
    _selectedState(value);
    _selectedCity('0');
    getCity(stateId: int.parse(value));
  }
  void onCitySelect(String value) {
    _selectedCity(value);
  }


  @override
  void onInit() {
    super.onInit();
   getStates();

  }

  Future<void> getStates() async {
    setBusy(true);
    ApiResponse response = await worldService.getStates();
   // log.w(response.toJson());
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allState.assignAll(List<StateModel>.from(response.data.map((x) => StateModel.fromJson(x))));
    } else {
      _allState.clear();
    }
    setBusy(false);
  }

  Future<void> getCity({required int stateId}) async {
    setBusy(true);
    ApiResponse response = await worldService.getCity(stateId: stateId );
    log.w(response.toJson());
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allCity.assignAll(List<CityModel>.from(response.data.map((x) => CityModel.fromJson(x))));
    } else {
      _allCity.clear();
    }
    setBusy(false);
  }

}
