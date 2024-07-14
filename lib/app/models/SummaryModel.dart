import 'UserModel.dart';

class SummaryModel {
  SummaryModel(
      {this.id,
      this.userId,
      this.date,
      this.name,
      this.age,
      this.dob,
      this.isOrganize,
      this.createdAt,
      this.updatedAt,
      this.remark,
      this.user,
      this.summaryDetail});

  int? id;
  int? userId;
  DateTime? date;
  dynamic name;
  String? age;
  DateTime? dob;
  dynamic isOrganize;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;
  String? remark;
  SummaryDetail? summaryDetail;

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        summaryDetail: json['detail'] != null
            ? SummaryDetail.fromJson(json['detail'])
            : null,
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        name: json["name"],
        age: json["age"] == null ? null : json["age"].toString(),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        isOrganize: json["is_organize"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        remark: json["remark"] == null ? null : json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "date": date == null ? null : date?.toIso8601String(),
        "name": name,
        "age": age == null ? null : age,
        "dob": dob == null
            ? null
            : "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
        "is_organize": isOrganize,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "user": user == null ? null : user?.toJson(),
        "remark": remark == null ? null : remark,
      };
}

class SummaryDetail {
  List<String> known_cases = [];
  List<String> family_history = [];
  List<String> habit_history = [];
  List<String> operative_history = [];
  List<String> any_allergy = [];
  List<String> current_medication = [];
  List<String> vaccination_history = [];
  List<String> opd_visit = [];
  List<String> last_admitted = [];
  List<String> bloodGroup = [];
  SummaryDetail.fromJson(Map<String, dynamic> map) {
    if (map.containsKey('known_cases')) {
      for (var element in map['known_cases']) {
        known_cases.add(element['known_text'] ?? "");
      }
    }
    if (map.containsKey('habit_history')) {
      for (var element in map['habit_history']) {
        habit_history.add(element['habit_text'] ?? "");
      }
    }
    if (map.containsKey('family_history')) {
      for (var element in map['family_history']) {
        family_history.add(element['family_text'] ?? "");
      }
    }
    if (map.containsKey('operative_history')) {
      for (var element in map['operative_history']) {
        operative_history.add(element['operative_text'] ?? "");
      }
    }
    if (map.containsKey('any_allergy')) {
      for (var element in map['any_allergy']) {
        any_allergy.add(element['allergy_text'] ?? "");
      }
    }
    if (map.containsKey('current_medication')) {
      for (var element in map['current_medication']) {
        current_medication.add(element['current_text'] ?? "");
      }
    }
    if (map.containsKey('vaccination_history')) {
      for (var element in map['vaccination_history']) {
        vaccination_history.add(element['vaccination_history'] ?? "");
      }
    }
    if (map.containsKey('opd_visit')) {
      for (var element in map['opd_visit']) {
        opd_visit.add(element['opd_text'] ?? "");
      }
    }
    if (map.containsKey('last_admitted')) {
      for (var element in map['last_admitted']) {
        last_admitted.add(element['last_text'] ?? "");
      }
    }
    if (map.containsKey('bloodGroup')) {
      for (var element in map['bloodGroup']) {
        bloodGroup.add(element['bloodGroup_text'] ?? "");
      }
    }
  }
}
