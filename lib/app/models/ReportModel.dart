

class ReportModel {
  ReportModel({
    this.id,
    this.name,
    this.level,
    this.categoryTypeId,
    this.parentId,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.patientFiles,

  });

  int? id;
  String? name;
  String? level;
  String? categoryTypeId;
  dynamic parentId;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<PatientFile>? patientFiles;
 // Map<String, dynamic> ? patientFiles;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    level: json["level"] == null ? null : json["level"].toString(),
    categoryTypeId: json["category_type_id"] == null ? null : json["category_type_id"].toString(),
    parentId: json["parent_id"],
    icon: json["icon"] == null ? null : json["icon"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  //  patientFiles: json["patientFiles"] == null ? null : json["patientFiles"],
    patientFiles: json["patient_files"] == null ? null : List<PatientFile>.from(json["patient_files"].map((x) => PatientFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "level": level == null ? null : level,
    "category_type_id": categoryTypeId == null ? null : categoryTypeId,
    "parent_id": parentId,
    "icon": icon == null ? null : icon,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    //"patient_files": patientFiles == null ? null : patientFiles,
    "patient_files": patientFiles == null ? null : List<dynamic>.from(patientFiles!.map((x) => x.toJson())),
  };
}

class PatientFile {
  PatientFile({
    this.id,
    this.userId,
    this.date,
    this.comment,
    this.categoryId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
  });

  int? id;
  String? userId;
  DateTime? date;
  dynamic comment;
  String? categoryId;
  String? file;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory PatientFile.fromJson(Map<String, dynamic> json) => PatientFile(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    comment: json["comment"],
    categoryId: json["category_id"] == null ? null : json["category_id"].toString(),
    file: json["file"] == null ? null : json["file"],
    title: json["title"] == null ? null : json["title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );
  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "date": date == null ? null : date?.toIso8601String(),
    "comment": comment,
    "category_id": categoryId == null ? null : categoryId,
    "file": file == null ? null : file,
    "title": title == null ? null : title,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
