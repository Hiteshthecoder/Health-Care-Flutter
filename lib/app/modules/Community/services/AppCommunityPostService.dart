
import '../../../helpers/Request.dart';
import '../../../models/ApiResponse.dart';
import 'CommunityPostService.dart';


class AppCommunityPostService implements CommunityPostService{


  Future<ApiResponse> getPostData({int? page}) async {
    String _page = page != null ? 'page=$page&limit=15' : '';
    return await Request.get('/patient/posts/index?$_page',authenticate: true);
  }

  Future<ApiResponse> getPostCommentData( {required int postId}) async {

    return await Request.get('/patient/post/$postId/comments',authenticate: true);
  }
  Future<ApiResponse> getPostLikeData( {required int postId}) async {

    return await Request.get('/patient/post/$postId/likes',authenticate: true); 
  }


  Future<ApiResponse> createComment({required Map<String, dynamic> body , required int postId}) async {

    return await Request.post('/patient/create/post-comment?post_id=$postId',body: body, authenticate: true);
  }

  Future<ApiResponse> createPost({required Map<String, dynamic> body }) async {

    return await Request.post('/patient/create/post',body: body, authenticate: true);
  }
  Future<ApiResponse> createLike({ required int create_like_Id }) async {

    return await Request.get('/patient/create/post-like?post_id=$create_like_Id' ,authenticate: true);
  }

  Future<ApiResponse> deletePost({required int id}) async {
    return await Request.get('/patient/delete/post/$id', authenticate: true);
  }
  Future<ApiResponse> deleteComment({required int id}) async {
    return await Request.get('/patient/delete/post-comment/$id', authenticate: true);
  }

}