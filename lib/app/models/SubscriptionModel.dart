
class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.name,
    this.isPublished,
    this.duration,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  String? isPublished;
  String? duration;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    isPublished: json["is_published"] == null ? null : json["is_published"].toString(),
    duration: json["duration"] == null ? null : json["duration"].toString(),
    price: json["price"] == null ? null : json["price"].toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "is_published": isPublished == null ? null : isPublished,
    "duration": duration == null ? null : duration,
    "price": price == null ? null : price,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
