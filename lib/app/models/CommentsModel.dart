// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'UserModel.dart';

class CommentsModel {
  CommentsModel({
    this.id,
    this.postId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? postId;
  String? userId;
  String? comment;
  DateTime? createdAt;
  dynamic updatedAt;
  UserModel? user;

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    id: json["id"] == null ? null : json["id"],
    postId: json["post_id"] == null ? null : json["post_id"].toString(),
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    comment: json["comment"] == null ? null : json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "post_id": postId == null ? null : postId,
    "user_id": userId == null ? null : userId,
    "comment": comment == null ? null : comment,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "user": user == null ? null : user?.toJson(),
  };
}
