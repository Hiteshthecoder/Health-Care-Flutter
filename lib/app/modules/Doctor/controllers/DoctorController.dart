import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/models/UserModel.dart';
import 'package:flutter_mvc/app/modules/Doctor/services/DoctorService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/AppController.dart';

class DoctorController extends AppController {
  static DoctorController get instance => Get.find();

  ///Observables
  var _doctorData = <UserModel>[].obs;
  var _showDetails = UserModel().obs;
  var _primaryDoctor = UserModel().obs;
  var _loadingMore = false.obs;
  var _page = 1.obs;
  var _filterApplied = false.obs;
  var _dataEnded = false.obs;

  ///Getter
  List<UserModel> get doctorData => _doctorData;

  UserModel get showDetails => _showDetails.value;

  UserModel get primaryDoctor => _primaryDoctor.value;

  bool get loadingMore => _loadingMore.value;

  bool get filterApplied => _filterApplied.value;

  ///Variable
  final DoctorService _doctorService = DoctorService.instance;

  var _states = <StateModel>[].obs;
  var _selectedState = "0".obs;

  var _selectedCity = "0".obs;
  var _cities = <CityModel>[].obs;

  var _selectedDistrict = '0'.obs;

  /// Variables
  String get selectedState => _selectedState.value;

  String get selectedCity => _selectedCity.value;

  String get selectedDistrict => _selectedDistrict.value;

  List<StateModel> get states => _states;

  List<CityModel> get cities => _cities;

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
      getDoctorData();
    }
    getState();
    scrollController.addListener(() {
      if (double.parse((scrollController.positions.last.maxScrollExtent - 10).toString()) <= scrollController.positions.last.pixels) {
        if (!_dataEnded.value) getDoctorData(next: true);
      }
    });
  }

  Future<void> applyFilter() async {
    _filterApplied(true);
    await getDoctorData();
  }

  Future<void> getDoctorData({bool immediate = false, bool next = false}) async {
    // try {
    if (!immediate && !next) setBusy(true);
    ApiResponse response;

    if (next) setBusy(false);
    if (next) _loadingMore(true);
    if (next) _page(_page.value + 1);

    if (_filterApplied.value) {
      response = await _doctorService.getDoctorData(
        state: _selectedState.value,
        city: _selectedCity.value,
        district: districtInput.text,
        pincode: pincodeInput.text,
        page: _page.value,
      );
    } else {
      response = await _doctorService.getDoctorData(
        // state: _selectedState.value,
        // city: _selectedCity.value,
        // district: districtInput.text,
        // pincode: pincodeInput.text,
        page: _page.value,
      );
    }

    /// Call api to login user
    // ApiResponse response = await _doctorService.getDoctorData(
    //     state: _selectedState.value, city: _selectedCity.value, district: districtInput.text, pincode: pincodeInput.text);

    // log.w(response.data);
    if (response.hasError()) {
      // Toastr.show(message: "${response.message}");
      return;
    }
    if (response.hasData()) {
      if (next) {
        _doctorData.addAll(List<UserModel>.from(response.data['doctors'].map((x) => UserModel.fromJson(x))));
      } else {
        _doctorData.assignAll(List<UserModel>.from(response.data['doctors'].map((x) => UserModel.fromJson(x))));
      }
    } else {
      if (!next) {
        _doctorData.clear();
      }
      _dataEnded(true);
    }
    _loadingMore(false);
    setBusy(false);
  }

  Future<void> getDoctorShowDetails() async {
    ApiResponse response = await _doctorService.getDoctorShowDetails(id: int.parse(Get.parameters["id"].toString()));
    log.w(response.data);
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    _showDetails(UserModel.fromJson(response.data));
    setBusy(false);
  }

  Future<void> getState() async {
    ApiResponse response = await _doctorService.getState();
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
    ApiResponse response = await _doctorService.getCity(stateID: int.parse(stateId.toString()));

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
  }
}
