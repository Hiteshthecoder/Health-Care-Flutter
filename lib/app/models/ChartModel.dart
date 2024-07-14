
class ChartModel {
  ChartModel({
    this.id,
    this.userId,
    this.chart,
    this.remark,
    this.updatedAt,

  });

  int? id;
  String? userId;
  String? remark;
  String? updatedAt;
  Map<String, dynamic> ? chart;

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    remark: json["remark"] == null ? null : json["remark"].toString(),
    chart: json["chart"] == null ? null : json["chart"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "remark": remark == null ? null : remark,
    "chart": chart == null ? null : chart,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

