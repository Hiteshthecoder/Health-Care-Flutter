import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/modules/Menu/controllers/MenuController.dart';
import 'package:flutter_mvc/app/modules/Menu/controllers/MenuController.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/LinkDoctorModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/WorldController.dart';
import '../../Auth/controllers/LoginController.dart';
import '../services/ProfileService.dart';

class DoctorProfileController extends AppController {
  static DoctorProfileController get instance => Get.find();

  final LoginController loginController = Get.put(LoginController());
  final MenueController menuController = Get.put(MenueController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final WorldController worldController = Get.put(WorldController());

  final TextEditingController doctorNameInput = TextEditingController();
  final TextEditingController doctorPhoneInput = TextEditingController();
  final TextEditingController addressInput = TextEditingController();
  final TextEditingController pincodeInput = TextEditingController();
  final TextEditingController countryInput = TextEditingController();

  final ProfileService _doctorService = ProfileService.instance;

  /// Getter
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _allState = <StateModel>[].obs;
  var _allCity = <CityModel>[].obs;
  var _verifyDoctor = LinkDoctorModel().obs;
  var _change = false.obs;
  var _changeValue = false.obs;

  var _readOnly = true.obs;
  var _verified = false.obs;
  bool get readOnly => _readOnly.value;
  bool get verified => _verified.value;

  String get selectedState => _selectedState.value;
  String get selectedCity => _selectedCity.value;
  List<StateModel> get allState => _allState;
  List<CityModel> get allCity => _allCity;
  LinkDoctorModel get verifyDoctor => _verifyDoctor.value;
  bool get change => _change.value;
  bool get changeValue => _changeValue.value;

  @override
  void onInit() {
    super.onInit();
    getStates();
  }

  void onStateSelect(String value) {
    _selectedState(value);
    _selectedCity('0');
    getCity(stateId: int.parse(value));
  }

  void onCitySelect(String value) {
    _selectedCity(value);
  }

  void onSelectFalse(bool value) {
    _readOnly(value);
  }

  void setData() async {
    setBusy(true);
    doctorNameInput.text = verifyDoctor.name == null ? "" : verifyDoctor.name!;
    addressInput.text =
        verifyDoctor.address == null ? "" : verifyDoctor.address!;
    pincodeInput.text =
        verifyDoctor.pincode == null ? "" : verifyDoctor.pincode!;
    if (_allState.length > 0)
      _selectedState(
          verifyDoctor.state == null ? "0" : verifyDoctor.state.toString());
    if (_allCity.length > 0)
      _selectedCity(
          verifyDoctor.city == null ? "0" : verifyDoctor.city.toString());
    setBusy(false);
  }

  void clearFields() {
    doctorNameInput.clear();
    doctorPhoneInput.clear();
    addressInput.clear();
    pincodeInput.clear();
    _selectedState("0");
    _selectedCity("0");
    _verified(false);
  }

  Future<void> createPrimaryDoctor() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> body = {
      "doctor_name": doctorNameInput.text.trim().toString(),
      "phone_no": doctorPhoneInput.text.trim().toString(),
      "state": _selectedState.value,
      "city": _selectedCity.value,
      "address": addressInput.text.trim().toString(),
      "pincode": pincodeInput.text.trim().toString(),
    };
    ApiResponse response = await _doctorService.createPrimaryDoctor(
        body: body, userID: auth.user.id.toString());
    log.w(response.message);
    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    if (await storage.read('onboarded') == null) {
      Get.offAllNamed('/dashboard');
      Toastr.show(message: "${response.message}");
    } else {
      Get.offAllNamed('/onboarding');
      Toastr.show(message: "${response.message}");
    }
  }

  Future<void> linkDoctor() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    ApiResponse response = await _doctorService.linkDoctor(
        phone: doctorPhoneInput.text.toString());
    // log.w(response.toJson());

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    _verifyDoctor(LinkDoctorModel.fromJson(response.data));
    _verified(true);
    setData();
    await auth.getUser();
  }

  Future<void> getStates() async {
    ApiResponse response = await _doctorService.getState();
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allState.assignAll(List<StateModel>.from(
          response.data.map((x) => StateModel.fromJson(x))));
    } else {
      _allState.clear();
    }
    setBusy(false);
  }

  Future<void> getCity({required int stateId}) async {
    ApiResponse response = await _doctorService.getCity(stateID: stateId);
    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allCity.clear();
      _allCity.assignAll(List<CityModel>.from(
          response.data.map((x) => CityModel.fromJson(x))));
    } else {
      _allCity.clear();
    }
    setBusy(false);
  }
}
