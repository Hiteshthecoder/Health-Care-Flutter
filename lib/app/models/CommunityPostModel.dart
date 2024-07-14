import 'UserModel.dart';

class CommunityPostModel {
  CommunityPostModel({
    this.id,
    this.userId,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.commentCount,
    this.likeCount,
    this.isLike,
    this.user,
  });

  int? id;
  int? userId;
  int? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentCount;
  int? likeCount;
  bool? isLike;
  UserModel? user;

  CommunityPostModel copyWith({
    int? id,
    int? userId,
    int? status,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? commentCount,
    int? likeCount,
    bool? isLike,
    UserModel? user,
  }) =>
      CommunityPostModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        commentCount: commentCount ?? this.commentCount,
        likeCount: likeCount ?? this.likeCount,
        isLike: isLike ?? this.isLike,
        user: user ?? this.user,
      );

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) => CommunityPostModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        commentCount: json["comment_count"] == null ? null : json["comment_count"],
        likeCount: json["like_count"] == null ? null : json["like_count"],
        isLike: json["is_like"] == null ? null : json["is_like"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "status": status == null ? null : status,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "comment_count": commentCount == null ? null : commentCount,
        "like_count": likeCount == null ? null : likeCount,
        "is_like": isLike == null ? null : isLike,
        "user": user == null ? null : user?.toJson(),
      };
}
