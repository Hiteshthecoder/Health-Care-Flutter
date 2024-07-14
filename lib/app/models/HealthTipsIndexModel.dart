// To parse this JSON data, do
//
//     final healthTipsIndexModel = healthTipsIndexModelFromJson(jsonString);

import 'dart:convert';

List<HealthTipsIndexModel> healthTipsIndexModelFromJson(String str) => List<HealthTipsIndexModel>.from(json.decode(str).map((x) => HealthTipsIndexModel.fromJson(x)));

String healthTipsIndexModelToJson(List<HealthTipsIndexModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HealthTipsIndexModel {
  HealthTipsIndexModel({
    this.id,
    this.title,
    this.slug,
    this.isPublish,
    this.categoryId,
    this.shortDescription,
    this.descriptionBanner,
    this.userId,
    this.seoTitle,
    this.seoKeywords,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.description,
    this.user,
    this.category,
  });

  int? id;
  String? title;
  String? slug;
  int? isPublish;
  int? categoryId;
  String? shortDescription;
  String? descriptionBanner;
  int? userId;
  String? seoTitle;
  String? seoKeywords;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? description;
  User? user;
  Category? category;

  factory HealthTipsIndexModel.fromJson(Map<String, dynamic> json) => HealthTipsIndexModel(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    isPublish: json["is_publish"] == null ? null : json["is_publish"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    shortDescription: json["short_description"] == null ? null : json["short_description"],
    descriptionBanner: json["description_banner"] == null ? null : json["description_banner"],
    userId: json["user_id"] == null ? null : json["user_id"],
    seoTitle: json["seo_title"] == null ? null : json["seo_title"],
    seoKeywords: json["seo_keywords"] == null ? null : json["seo_keywords"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    description: json["description"] == null ? null : json["description"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "is_publish": isPublish == null ? null : isPublish,
    "category_id": categoryId == null ? null : categoryId,
    "short_description": shortDescription == null ? null : shortDescription,
    "description_banner": descriptionBanner == null ? null : descriptionBanner,
    "user_id": userId == null ? null : userId,
    "seo_title": seoTitle == null ? null : seoTitle,
    "seo_keywords": seoKeywords == null ? null : seoKeywords,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "description": description == null ? null : description,
    "user": user == null ? null : user?.toJson(),
    "category": category == null ? null : category?.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.icon,
  });

  int? id;
  String? name;
  String? icon;


  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "icon": icon == null ? null : icon,
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
  dynamic lastName;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "avatar": avatar == null ? null : avatar,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName,
    "name": name == null ? null : name,
  };
}
