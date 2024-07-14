import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/app/modules/MyFamily/controllers/MyFamilyController.dart';
import 'package:flutter_mvc/app/modules/MyFamily/services/MyFamilyService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ui_x/helpers/Helpers.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../../config/Config.dart';
import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CityModel.dart';
import '../../../models/RelationModel.dart';
import '../../../models/StateModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/controllers/WorldController.dart';
import '../../Auth/controllers/LoginController.dart';
import '../../Menu/controllers/MenuController.dart';

class AddMemberController extends AppController {
  static AddMemberController get instance => AddMemberController();
  final LoginController loginController = Get.put(LoginController());
  final WorldController worldController = Get.put(WorldController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameInput = TextEditingController();
  final TextEditingController lastNameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController addressInput = TextEditingController();
  final TextEditingController relationInput = TextEditingController();
  final TextEditingController pincodeInput = TextEditingController();

  final MyFamilyService _familyService = MyFamilyService.instance;
  final MyFamilyController myFamilyController = Get.put(MyFamilyController());
  final MenueController menuController = Get.put(MenueController());

  var _image = File('').obs;
  var _selectedDob = DateTime.now().obs;
  var _selectedGender = "Male".obs;
  var _selectedState = "0".obs;
  var _selectedCity = "0".obs;
  var _selectedRelation = "0".obs;
  var _allState = <StateModel>[].obs;
  var _allCity = <CityModel>[].obs;
  var _relation = <RelationModel>[].obs;

  File get image => _image.value;
  DateTime get selectedDob => _selectedDob.value;
  String get selectedGender => _selectedGender.value;

  String get selectedState => _selectedState.value;
  String get selectedCity => _selectedCity.value;
  String get selectedRelation => _selectedRelation.value;
  List<StateModel> get allState => _allState;
  List<CityModel> get allCity => _allCity;
  List<RelationModel> get relation => _relation;

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
    _selectedState(value);
    _selectedCity('0');
    getCity(stateId: int.parse(value));
  }

  void onCitySelect(String value) {
    _selectedCity(value);
  }

  void onSelectRelation(String value) {
    _selectedRelation(value);
  }

  //
  @override
  void onInit() {
    super.onInit();
    addMember();
    getStates();
    getRelation();
  }

  Future<void> addMember() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse(Config.apiBaseUrl + "/member/add-member"));
    request.fields['first_name'] = firstNameInput.text.trim().toString();
    request.fields['last_name'] = lastNameInput.text.trim().toString();
    // request.fields['phone'] =  phoneInput.text.trim().toString();
    // request.fields['email'] =  emailInput.text.trim().toString();
    request.fields['dob'] =
        "${_selectedDob.value.year}-${_selectedDob.value.month}-${_selectedDob.value.day}";
    request.fields['gender'] = _selectedGender.value;
    request.fields['address'] = addressInput.text.trim().toString();
    request.fields['relation'] = _selectedRelation.value;
    request.fields['pincode'] = pincodeInput.text.trim().toString();
    request.fields['state'] = _selectedState.value;
    request.fields['city'] = _selectedCity.value;

    // Map<String, dynamic> body = {
    //   "first_name": firstNameInput.text.trim().toString(),
    //   "last_name": lastNameInput.text.trim().toString(),
    //   "phone": phoneInput.text.trim().toString(),
    //   "email": emailInput.text.trim().toString(),
    //   "dob": "${_selectedDob.value.year}-${_selectedDob.value.month}-${_selectedDob.value.day}",
    //  // "date" : _selectedDob.value,
    //   "gender": _selectedGender.value,
    //   "address": addressInput.text.trim().toString(),
    //   "relation": relationInput.text.trim().toString(),
    //   "state": _selectedState.value,
    //   "city": _selectedCity.value,
    //   "pincode": pincodeInput.text.trim().toString(),
    // };
    // ApiResponse response = await _familyService.addMember(body: body);
    // await myFamilyController.getMemberData();
    //

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
    await myFamilyController.getMemberData();
    await menuController.getMemberData();
    Get.offNamed('/myfamily');
  }

  void onGenderSelect(String value) {
    _selectedGender(value);
  }

  void onDobSelect(DateTime? newDate) {
    _selectedDob(newDate);
  }

  Future<void> getStates() async {
    setBusy(true);
    ApiResponse response = await _familyService.getState();
    log.w(response.toJson());
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
    setBusy(true);
    ApiResponse response = await _familyService.getCity(stateID: stateId);
    log.w(response.toJson());
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
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

  Future<void> getRelation() async {
    setBusy(true);
    ApiResponse response = await _familyService.getRelation();
    log.w(response.toJson());
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _relation.assignAll(List<RelationModel>.from(
          response.data.map((x) => RelationModel.fromJson(x))));
    } else {
      _relation.clear();
    }
    setBusy(false);
  }
}
