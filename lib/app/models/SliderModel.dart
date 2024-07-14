class SliderModel {
  SliderModel({
    this.id,
    this.title,
    this.image,
    this.status,
    this.description,
  });

  int? id;
  String? title;
  String? image;
  int? status;
  String? description;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "status": status == null ? null : status,
    "description": description == null ? null : description,
  };
}
