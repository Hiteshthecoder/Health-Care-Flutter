import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'package:http/http.dart' as http;
import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../Auth/controllers/LoginController.dart';
import '../services/ProfileService.dart';

class EditProfileController extends AppController {
  static EditProfileController get instance => Get.find();
  final LoginController loginController = Get.put(LoginController());

  final ProfileService _profileService = ProfileService.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameInput = TextEditingController();
  final TextEditingController lastNameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController addressNameInput = TextEditingController();
  final TextEditingController pincodeInput = TextEditingController();
  final TextEditingController weightInput = TextEditingController();
  final TextEditingController heightInput = TextEditingController();

  var _image = File('').obs;
  var _selectedDob = DateTime.now().obs;
  var _selectedGender = "Male".obs;
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _allState = <StateModel>[].obs;
  var _allCity = <CityModel>[].obs;

  File get image => _image.value;
  DateTime get selectedDob => _selectedDob.value;
  String get selectedGender => _selectedGender.value;
  String get selectedState => _selectedState.value;
  String get selectedCity => _selectedCity.value;
  List<StateModel> get allState => _allState;
  List<CityModel> get allCity => _allCity;

  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      jsonEncode(_image(File(pickedFile.path)));
    } else {
      print('No image selected.');
    }
  }

  void onStateSelect(String value) {
    _selectedCity('0');
    _selectedState(value);
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

  @override
  void onInit() {
    super.onInit();
    getStates();
    setData();
  }

  void setData() async {
    setBusy(true);
    log.i('@@@ DOB: ' + auth.user.dob.toString());
    log.i('@@@ gender: ' + auth.user.gender.toString());
    firstNameInput.text =
        auth.user.firstName == null ? "" : auth.user.firstName!;
    addressNameInput.text = auth.user.address == null ? "" : auth.user.address!;
    pincodeInput.text = auth.user.pincode == null ? "" : auth.user.pincode!;
    lastNameInput.text = auth.user.lastName == null ? "" : auth.user.lastName!;
    weightInput.text = auth.user.weight!;
    heightInput.text = auth.user.height!;
    //if (auth.user.dob != null) _selectedDob(DateTime.parse(auth.user.dob.toString()));
    if (auth.user.dob != null)
      _selectedDob(DateFormat('yyyy-MM-dd').parse(auth.user.dob.toString()));
    if (auth.user.gender != null || auth.user.gender == null)
      _selectedGender(auth.user.gender == null ? "" : auth.user.gender);
    if (_allState.length > 0)
      _selectedState(auth.user.state == null ? "" : auth.user.state!);
    if (_allCity.length > 0)
      _selectedCity(auth.user.city == null ? "" : auth.user.city!);
    setBusy(false);
  }

  Future<void> updateProfile() async {
    MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse(Config.apiBaseUrl + "/patient/update"));
    request.fields['first_name'] = firstNameInput.text.trim().toString();
    request.fields['last_name'] = lastNameInput.text.trim().toString();
    request.fields['dob'] =
        "${_selectedDob.value.year}-${_selectedDob.value.month}-${_selectedDob.value.day}";
    request.fields['gender'] = _selectedGender.value;
    request.fields['height'] = heightInput.text.trim();
    request.fields['weight'] = weightInput.text.trim();
    request.fields['address'] = addressNameInput.text.trim().toString();
    request.fields['pincode'] = pincodeInput.text.trim().toString();
    request.fields['state'] = _selectedState.value;

    request.fields['city'] = _selectedCity.value;
    if (_image.value.path != '')
      request.files
          .add(await http.MultipartFile.fromPath("avatar", _image.value.path));

    /// Files
    Map<String, String> _headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + storage.read('token'),
    };
    request.headers.addAll(_headers);

    StreamedResponse send = await request.send().timeout(60.seconds);

    http.Response res = await http.Response.fromStream(send);
    log.w(res.body.toString());
    ApiResponse response = ApiResponse.fromJson(jsonDecode(res.body));

    if (response.hasValidationErrors()) {
      Toastr.show(message: "${response.validationError}");
      return;
    }

    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      return;
    }
    await auth.getUser();
    Get.offNamed('/menu');
    Toastr.show(message: "${response.message}");
  }

  Future<void> getStates() async {
    ApiResponse response = await _profileService.getState();
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allState.assignAll(List<StateModel>.from(
          response.data.map((x) => StateModel.fromJson(x))));
      if (auth.user.state != null || auth.user.state == null)
        _selectedState(auth.user.state.toString());
    } else {
      _allState.clear();
    }
    getCity(stateId: int.parse(_selectedState.value));
    setBusy(false);
  }

  Future<void> getCity({required int stateId, bool initialCall = false}) async {
    ApiResponse response = await _profileService.getCity(stateID: stateId);

    if (response.hasError()) {
      //Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _allCity.assignAll(List<CityModel>.from(
          response.data.map((x) => CityModel.fromJson(x))));
      if (!initialCall && auth.user.city != null || auth.user.city == null)
        _selectedCity(auth.user.city.toString());
    } else {
      _allCity.clear();
    }
    setBusy(false);
  }
}
