// To parse this JSON data, do
//
//     final journeyModel = journeyModelFromJson(jsonString);

import 'dart:convert';

JourneyModel journeyModelFromJson(String str) => JourneyModel.fromJson(json.decode(str));

String journeyModelToJson(JourneyModel data) => json.encode(data.toJson());

class JourneyModel {
  JourneyModel({
    this.id,
    this.userId,
    this.createdBy,
    this.date,
    this.status,
    this.name,
    this.age,
    this.dob,
    this.detail,
    this.chart,
    this.journey,
    this.remark,
    this.type,
    this.isOrganize,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? userId;
  int? createdBy;
  DateTime? date;
  dynamic status;
  dynamic name;
  int? age;
  DateTime? dob;
  String? detail;
  String? chart;
  dynamic journey;
  String? remark;
  int? type;
  dynamic isOrganize;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory JourneyModel.fromJson(Map<String, dynamic> json) => JourneyModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    name: json["name"],
    age: json["age"] == null ? null : json["age"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    detail: json["detail"] == null ? null : json["detail"],
    chart: json["chart"] == null ? null : json["chart"],
    journey: json["journey"],
    type: json["type"] == null ? null : json["type"],
    remark: json["remark"] == null ? null : json["remark"],
    isOrganize: json["is_organize"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "created_by": createdBy == null ? null : createdBy,
    "date": date == null ? null : date?.toIso8601String(),
    "status": status,
    "name": name,
    "age": age == null ? null : age,
    "dob": dob == null ? null : "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "detail": detail == null ? null : detail,
    "chart": chart == null ? null : chart,
    "journey": journey,
    "remark": remark == null ? null : remark,
    "type": type == null ? null : type,
    "is_organize": isOrganize,
    "updated_by": updatedBy,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
