import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/WorldController.dart';
import '../../Auth/controllers/LoginController.dart';
import '../services/ProfileService.dart';

class ProfileController extends AppController {
  static ProfileController get instance => Get.find();
  final LoginController loginController = Get.put(LoginController());
  final WorldController worldController = Get.put(WorldController());

  final ProfileService _profileService = ProfileService.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameInput = TextEditingController();
  final TextEditingController lastNameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController addressInput = TextEditingController();
  final TextEditingController pincodeInput = TextEditingController();
  final TextEditingController countryInput = TextEditingController();
  final TextEditingController weightInput = TextEditingController();
  final TextEditingController heightInput = TextEditingController();

  var _selectedDob = DateTime.now().obs;
  var _selectedGender = "Male".obs;
  var _currentStep = 1.obs;
  var _phoneInput = ''.obs;
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _allState = <StateModel>[].obs;
  var _allCity = <CityModel>[].obs;

  DateTime get selectedDob => _selectedDob.value;

  int get currentStep => _currentStep.value;

  String get selectedGender => _selectedGender.value;

  String get phoneInput => _phoneInput.value;

  String get selectedState => _selectedState.value;

  String get selectedCity => _selectedCity.value;

  List<StateModel> get allState => _allState;

  List<CityModel> get allCity => _allCity;

  void onStateSelect(String value) {
    _selectedState(value);
    _selectedCity('0');
    getCity(stateId: int.parse(value), initialCall: true);
  }

  void onCitySelect(String value) {
    _selectedCity(value);
  }

  void onGenderSelect(String value) {
    _selectedGender(value);
  }

  void onDobSelect(DateTime? newDate) {
    _selectedDob(newDate);
  }

  //
  @override
  void onInit() async {
    super.onInit();
    getStates();
    _phoneInput(loginController.phoneNumber.text);
    setData();
    profileSetup();
  }

  void setData() async {
    setBusy(true);
    firstNameInput.text =
        auth.user.firstName == null ? "" : auth.user.firstName!;
    addressInput.text = auth.user.address == null ? "" : auth.user.address!;
    pincodeInput.text = auth.user.pincode == null ? "" : auth.user.pincode!;
    lastNameInput.text = auth.user.lastName == null ? "" : auth.user.lastName!;
    //emailInput.text = auth.user.email == null ? "" : auth.user.email!;
    if (auth.user.gender != null)
      _selectedGender.value = auth.user.gender == null ? "" : auth.user.gender!;
    setBusy(false);
  }

  Future<void> profileSetup() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (pincodeInput.text.trim().isNotEmpty) {
      if (pincodeInput.text.length < 5 || pincodeInput.text.length > 10) {
        Toastr.show(message: 'Pincode must be 6 digits long');
        return;
      }
    }

    Map<String, dynamic> body = {
      "first_name": firstNameInput.text.trim().toString(),
      "last_name": lastNameInput.text.trim().toString(),
      "email": emailInput.text.trim().toString(),
      "gender": _selectedGender.value,
      "dob":
          "${_selectedDob.value.year}-${_selectedDob.value.month}-${_selectedDob.value.day}",
      if (heightInput.text.trim().isNotEmpty) "height": heightInput.text.trim(),
      if (weightInput.text.trim().isNotEmpty) "weight": weightInput.text.trim(),
      "address": addressInput.text.trim().toString(),
      "pincode": pincodeInput.text.trim().toString(),
      "state": _selectedState.value,
      "city": _selectedCity.value
    };
    ApiResponse response =
        await _profileService.profileSetup(body: body, userID: auth.user.id!);

    //log.w(response.toJson());
    Toastr.show(message: response.message ?? "");

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    log.w(response.message);
    if (int.parse(auth.user.progress!) == 1) {
      Get.offAllNamed('/doctorProfile');
      Toastr.show(message: "${response.message}");
    } else if (int.parse(auth.user.progress!) == 2) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> getStates() async {
    ApiResponse response = await _profileService.getState();
    //log.w(response.toJson());
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
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

  Future<void> getCity({required int stateId, bool initialCall = false}) async {
    ApiResponse response = await _profileService.getCity(stateID: stateId);
    // log.w(response.toJson());
    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      return;
    }
    if (response.hasData()) {
      _allCity.assignAll(List<CityModel>.from(
          response.data.map((x) => CityModel.fromJson(x))));
    } else {
      _allCity.clear();
    }
    setBusy(false);
  }
}
