
class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
