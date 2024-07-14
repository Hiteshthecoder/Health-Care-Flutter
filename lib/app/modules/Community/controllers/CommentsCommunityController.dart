import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/app/helpers/Global.dart';
import 'package:flutter_mvc/app/modules/Community/services/CommunityPostService.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/Toastr.dart';

import '../../../models/ApiResponse.dart';
import '../../../models/CommentsModel.dart';
import '../../../shared/controllers/AppController.dart';
import 'CommunityController.dart';

class CommentsCommunityController extends AppController {
  static CommentsCommunityController get to => Get.find<CommentsCommunityController>();

  final CommunityController communityController = CommunityController.to;

  /// Observables
  var _postId = "0".obs;
  var _buttonEnabled = false.obs;
  var _commentData = <CommentsModel>[].obs;

  ///Getter
  List<CommentsModel> get commentData => _commentData;

  String get postId => _postId.value;

  bool get buttonEnabled => _buttonEnabled.value;

  ///Variable
  TextEditingController taskInput = TextEditingController();
  TextEditingController thoughtsInput = TextEditingController();
  final CommunityPostService _commentService = CommunityPostService.instance;

  @override
  void onInit() {
    super.onInit();
    _postId(Get.parameters['post_id']);

    getPostCommentData();

    thoughtsInput.addListener(() {
      if (thoughtsInput.text.length > 0)
        _buttonEnabled(true);
      else
        _buttonEnabled(false);
    });
  }

  Future<void> getPostCommentData() async {
    setBusy(true);

    ApiResponse response = await _commentService.getPostCommentData(postId: int.parse(_postId.value));

    if (response.hasError()) {
      setBusy(false);
      return;
    }
    if (response.hasData()) {
      _commentData.assignAll(List<CommentsModel>.from(response.data.map((x) => CommentsModel.fromJson(x))));
    } else {
      _commentData.clear();
    }
    setBusy(false);
  }

  Future<void> createComment() async {
    Map<String, dynamic> body = {
      "comment": thoughtsInput.text.trim().toString(),
    };

    // CommentsModel lastComment = _commentData.last;

    CommentsModel newComment = CommentsModel(
      //id: (lastComment.id! + 1),
      comment: thoughtsInput.text.trim().toString(),
      postId: _postId.value,
      user: auth.user,
      userId: auth.user.id.toString(),
    );
    _commentData.add(newComment);
    thoughtsInput.clear();

    await _commentService.createComment(body: body, postId: int.parse(_postId.value.toString()));
    await communityController.getPostData();
  }

  Future<void> deleteComment({required int id}) async {
    setBusy(true);
    ApiResponse response = await _commentService.deleteComment(id: id);
    Get.back();
    if (response.hasError()) {
      Toastr.show(message: "${response.message}");
      setBusy(false);
      return;
    }
    await getPostCommentData();
    Toastr.show(message: "${response.message}");
  }
}
