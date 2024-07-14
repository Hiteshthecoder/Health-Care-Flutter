
import 'package:get/get.dart';

import '../../../models/ApiResponse.dart';
import 'AppCommunityPostService.dart';
import 'MockCommunityPostService.dart';

abstract class CommunityPostService {
  /// Configure if Mock is enabled or not
  static const MOCK_ENABLED = false;

  /// Create and get the instance of [ReportService]
  static CommunityPostService get instance {
    if (!Get.isRegistered<CommunityPostService>()) Get.lazyPut<CommunityPostService>(() => MOCK_ENABLED ? MockCommunityPostService() : AppCommunityPostService());

    return Get.find<CommunityPostService>();
  }
  Future<ApiResponse> getPostData({int? page}) ;

  Future<ApiResponse> getPostCommentData( {required int postId}) ;

  Future<ApiResponse> getPostLikeData( {required int postId}) ;

  Future<ApiResponse> createComment({required Map<String, dynamic> body,required int postId}) ;

  Future<ApiResponse> createPost({required Map<String, dynamic> body }) ;

  Future<ApiResponse> createLike({ required int create_like_Id });

  Future<ApiResponse> deletePost({required int id}) ;
  Future<ApiResponse> deleteComment({required int id}) ;
}
