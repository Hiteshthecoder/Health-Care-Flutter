

class RewardModel {
  RewardModel({
    this.month,
    this.monthName,
    this.year,
    this.points,
  });

  String? month;
  String? monthName;
  String? year;
  int? points;

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
    month: json["month"] == null ? null : json["month"],
    monthName: json["month_name"] == null ? null : json["month_name"],
    year: json["year"] == null ? null : json["year"],
    points: json["points"] == null ? null : json["points"],
  );

  Map<String, dynamic> toJson() => {
    "month": month == null ? null : month,
    "month_name": monthName == null ? null : monthName,
    "year": year == null ? null : year,
    "points": points == null ? null : points,
  };
}
