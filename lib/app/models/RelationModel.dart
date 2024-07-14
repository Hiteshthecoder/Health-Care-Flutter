// To parse this JSON data, do
//
//     final relationModel = relationModelFromJson(jsonString);

import 'dart:convert';

List<RelationModel> relationModelFromJson(String str) => List<RelationModel>.from(json.decode(str).map((x) => RelationModel.fromJson(x)));

String relationModelToJson(List<RelationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelationModel {
  RelationModel({
    this.id,
    this.name,
    this.level,
    this.categoryTypeId,
    this.parentId,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  int? level;
  int? categoryTypeId;
  dynamic parentId;
  dynamic icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory RelationModel.fromJson(Map<String, dynamic> json) => RelationModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    level: json["level"] == null ? null : json["level"],
    categoryTypeId: json["category_type_id"] == null ? null : json["category_type_id"],
    parentId: json["parent_id"],
    icon: json["icon"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "level": level == null ? null : level,
    "category_type_id": categoryTypeId == null ? null : categoryTypeId,
    "parent_id": parentId,
    "icon": icon,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
