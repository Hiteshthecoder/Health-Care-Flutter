class HealthTipsModel {
  HealthTipsModel({
    this.icon,
    this.name,
    this.date,
    this.image,
    this.title,
    this.subtitle,



  });

  String? icon;
  String? name;
  String? date;
  String? image;
  String? title;
  String? subtitle;


  factory HealthTipsModel.fromJson(Map<String, dynamic> json) => HealthTipsModel(
    icon: json["icon"] == null ? null : json["icon"],
    name: json["name"] == null ? null : json["name"],
    date: json["date"] == null ? null : json["date"],
    image: json["image"] == null ? null : json["image"],
    title: json["title"] == null ? null : json["title"],
    subtitle: json["subtitle"] == null ? null : json["subtitle"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon == null ? null : icon,
    "path": name == null ? null : name,
    "date": date == null ? null : date,
    "image": image == null ? null : image,
    "title": title == null ? null : title,
    "subtitle": subtitle == null ? null : subtitle,
  };
}