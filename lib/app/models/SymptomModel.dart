class SymptomModel {
  String? duration;
  String? name;
  String? durationType;
  SymptomModel.fromJson(Map<String, dynamic> map) {
    duration = map['duration'];
    name = map['name'];

    durationType = map['duration_type'];
  }
}
