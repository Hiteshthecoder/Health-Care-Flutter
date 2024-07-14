
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/models/CommunityPostModel.dart';
import 'package:flutter_mvc/app/models/RespectModel.dart';
import 'package:flutter_mvc/app/modules/Community/services/CommunityPostService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../helpers/Global.dart';
import '../../../models/ApiResponse.dart';
import '../../../models/CommentsModel.dart';
import '../../../shared/controllers/AppController.dart';
import '../../../shared/views/errors/ServerErrorPage.dart';
class RespectCommunityController extends AppController {
  static RespectCommunityController get to =>Get.find<RespectCommunityController>();


  var _isLike = false.obs;
  var _buttonEnabled = false.obs;

  /// Observables
  var _tasks = RxList<Map<String, dynamic>>([]);

  TextEditingController taskInput = TextEditingController();
  TextEditingController thoughtsInput = TextEditingController();

  var _respectData = <RespectModel>[].obs;

  ///Getter
  List<RespectModel> get respectData => _respectData;

  List<Map<String, dynamic>> get tasks => _tasks;
  bool get isLike => _isLike.value;
  bool get buttonEnabled => _buttonEnabled.value;

  ///Variable
  final CommunityPostService _likeService = CommunityPostService.instance;



  @override
  void onInit() {
    super.onInit();
    getRespectData();

    thoughtsInput.addListener(() {
        if(thoughtsInput.text.length > 0) _buttonEnabled(true);
        else _buttonEnabled(false);
      });
  }

  Future<void> getRespectData() async {
    try {
      setBusy(true);
      ApiResponse response = await _likeService.getPostLikeData(postId: int.parse(Get.parameters["like_Id"].toString()));

      log.w(response.toJson());

      if (response.hasError()) {
       // Toastr.show(message: "${response.message}");
        setBusy(false);
        return;
      }
      _respectData.assignAll(List<RespectModel>.from(response.data.map((x)=> RespectModel.fromJson(x))));
      setBusy(false);
    } on Exception catch (e) {
      Get.to(() => ServerErrorPage(message: "${e.toString()}"));
    }
  }

  void deleteFile(int index) async{
 //   _communities.removeAt(index);
    Get.back();
  }


}

