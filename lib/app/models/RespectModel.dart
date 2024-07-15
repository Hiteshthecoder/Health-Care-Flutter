// To parse this JSON data, do
//
//     final respectModel = respectModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_mvc/app/models/UserModel.dart';

List<RespectModel> respectModelFromJson(String str) =>
    List<RespectModel>.from(json.decode(str).map((x) => RespectModel.fromJson(x)));

String respectModelToJson(List<RespectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RespectModel {
  RespectModel({
    this.id,
    this.userId,
    this.postId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? userId;
  String? postId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;

  factory RespectModel.fromJson(Map<String, dynamic> json) => RespectModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        postId: json["post_id"] == null ? null : json["post_id"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserModel?.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "user": user == null ? null : user?.toJson(),
      };
}
