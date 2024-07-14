// To parse this JSON data, do
//
//     final postIndexModel = postIndexModelFromJson(jsonString);

import 'dart:convert';

List<PostIndexModel> postIndexModelFromJson(String str) => List<PostIndexModel>.from(json.decode(str).map((x) => PostIndexModel.fromJson(x)));

String postIndexModelToJson(List<PostIndexModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostIndexModel {
  PostIndexModel({
    this.id,
    this.userId,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? userId;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory PostIndexModel.fromJson(Map<String, dynamic> json) => PostIndexModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    status: json["status"] == null ? null : json["status"],
    description: json["description"] == null ? null : json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "status": status == null ? null : status,
    "description": description == null ? null : description,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "user": user == null ? null : user?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.avatar,
    this.firstName,
    this.lastName,
    this.name,
  });

  int? id;
  String? avatar;
  String? firstName;
  String? lastName;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "avatar": avatar == null ? null : avatar,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "name": name == null ? null : name,
  };
}
