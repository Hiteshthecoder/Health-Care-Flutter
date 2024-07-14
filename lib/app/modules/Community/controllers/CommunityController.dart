import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/models/CommunityPostModel.dart';
import 'package:flutter_mvc/app/modules/Community/services/CommunityPostService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';

class CommunityController extends AppController {
  static CommunityController get to => Get.find<CommunityController>();

  /// Observables
  var _selectedCategory = "0".obs;
  var _isLike = false.obs;
  var _isSave = false.obs;
  var _buttonEnabled = false.obs;
  var _respects = '0'.obs;
  var _postData = <CommunityPostModel>[].obs;
  int tabIndex = 0;
  var _loadingMore = false.obs;
  var _dataEnded = false.obs;
  var _page = 1.obs;

  //var _communities = <CommunityModel>[].obs;

  /// Getters
  String get selectedCategory => _selectedCategory.value;

  String get respects => _respects.value;

  bool get isLike => _isLike.value;
  bool get loadingMore => _loadingMore.value;

  bool get isSave => _isSave.value;

  bool get buttonEnabled => _buttonEnabled.value;

  List<CommunityPostModel> get postData => _postData;

  //List<CommunityModel> get communities => _communities;
  /// Variables
  TextEditingController taskInput = TextEditingController();
  TextEditingController thoughtsInput = TextEditingController();

  final CommunityPostService _postService = CommunityPostService.instance;

  @override
  void onInit() {
    super.onInit();
    thoughtsInput.addListener(() {
      if (thoughtsInput.text.length > 0)
        _buttonEnabled(true);
      else
        _buttonEnabled(false);
    });
    getPostData();
    scrollController.addListener(() {
      if (double.parse((scrollController.positions.last.maxScrollExtent - 10).toString()) <= scrollController.positions.last.pixels) {
        if (!_dataEnded.value) getPostData(next: true);
      }
    });
  }

  Future<void> getPostData({bool immediate = false, bool next = false}) async {
    if (!immediate && !next) setBusy(true);

    ApiResponse response;

    if (next) setBusy(false);
    if (next) _loadingMore(true);
    if (next) _page(_page.value + 1);

    response = await _postService.getPostData(page: _page.value);

      //log.w(response.toJson());

      if (response.hasError()) {
       // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
    if (response.hasData()) {
      if (next) {
        _postData.addAll(List<CommunityPostModel>.from(response.data.map((x) => CommunityPostModel.fromJson(x))));
      } else {
        _postData.assignAll(List<CommunityPostModel>.from(response.data.map((x) => CommunityPostModel.fromJson(x))));
      }
    } else {
      if (!next) {
        _postData.clear();
      }
      _dataEnded(true);
    }
    _loadingMore(false);
    setBusy(false);

  }

  Future<void> createRespect({required int id, required int index}) async {
    try {
      CommunityPostModel selectedItem = _postData.firstWhere((element) => element.id == id);
      if (!selectedItem.isLike!) {
        selectedItem = selectedItem.copyWith(isLike: true, likeCount: ((selectedItem.likeCount!) + 1));
        _postData.removeAt(index);
        _postData.insert(index, selectedItem);
        _postData.refresh();
      } else {
        selectedItem = selectedItem.copyWith(isLike: false, likeCount: ((selectedItem.likeCount!) - 1));
        _postData.removeAt(index);
        _postData.insert(index, selectedItem);
        _postData.refresh();
      }

      ApiResponse response = await _postService.createLike(create_like_Id: id);

      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        return;
      }
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  Future<void> deletePost({required int id}) async {
      setBusy(true);
      ApiResponse response = await _postService.deletePost(id: id);
      Get.back();
      if (response.hasError()) {
        Toastr.show(message: "${response.message}");
        // setBusy(false);
        return;
      } else {
        await getPostData();
        Toastr.show(message: "${response.message}");
      }
  }

  void onCategorySelect(String value) {
    _selectedCategory(value);
  }

  void toggleSave() {
    _isSave(!_isSave.value);
  }
}
