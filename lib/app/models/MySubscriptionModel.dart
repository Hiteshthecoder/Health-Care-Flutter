

class MySubscriptionModel {
  MySubscriptionModel({
    this.id,
    this.userId,
    this.subscriptionId,
    this.fromDate,
    this.toDate,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.subscriptionStatus,
  });

  int? id;
  int? userId;
  int? subscriptionId;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? subscriptionStatus;

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) => MySubscriptionModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    subscriptionId: json["subscription_id"] == null ? null : json["subscription_id"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    parentId: json["parent_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    subscriptionStatus: json["subscription_status"] == null ? null : json["subscription_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "subscription_id": subscriptionId == null ? null : subscriptionId,
    "from_date": fromDate == null ? null : "${fromDate?.year.toString().padLeft(4, '0')}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}",
    "to_date": toDate == null ? null : "${toDate?.year.toString().padLeft(4, '0')}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}",
    "parent_id": parentId,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "subscription_status": subscriptionStatus == null ? null : subscriptionStatus,
  };

  bool isTrial() => subscriptionStatus == "Trial";
  bool isPaid() => subscriptionStatus == "Paid";
  bool isExpired() => subscriptionStatus == "Expired";

}
