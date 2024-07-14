import '../../../models/ApiResponse.dart';
import 'CommunityPostService.dart';

class MockCommunityPostService implements CommunityPostService {
  @override
  Future<ApiResponse> getPostData({int? page}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getPostCommentData( {required int postId}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
  @override
  Future<ApiResponse> getPostLikeData( {required int postId}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> createComment({required Map<String, dynamic> body,required int postId}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  Future<ApiResponse> createPost({required Map<String, dynamic> body })  {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> createLike({ required int create_like_Id }){
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> deletePost({required int id}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
  Future<ApiResponse> deleteComment({required int id}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
}