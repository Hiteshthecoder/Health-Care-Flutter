// // To parse this JSON data, do
// //
// //     final insightModel = insightModelFromJson(jsonString);
//
// import 'dart:convert';
//
// InsightModel insightModelFromJson(String str) => InsightModel.fromJson(json.decode(str));
//
// String insightModelToJson(InsightModel data) => json.encode(data.toJson());
//
// class InsightModel {
//   InsightModel({
//     this.liver,
//     this.kidney,
//     this.lipid,
//     this.diabetes,
//     this.thyroid,
//     this.urineTest,
//     this.other,
//     this.blood,
//   });
//
//   Map<String, int>? liver;
//   Map<String, int>? kidney;
//   Map<String, int>? lipid;
//   Map<String, int>? diabetes;
//   Map<String, int>? thyroid;
//   Map<String, int>? urineTest;
//   Map<String, int>? other;
//   Map<String, int>? blood;
//
//   factory InsightModel.fromJson(Map<String, dynamic> json) => InsightModel(
//     liver: json["liver"] == null ? null : Map.from(json["liver"]).map((k, v) => MapEntry<String, int>(k, v)),
//     kidney: json["kidney"] == null ? null : Map.from(json["kidney"]).map((k, v) => MapEntry<String, int>(k, v)),
//     lipid: json["lipid"] == null ? null : Map.from(json["lipid"]).map((k, v) => MapEntry<String, int>(k, v)),
//     diabetes: json["diabetes"] == null ? null : Map.from(json["diabetes"]).map((k, v) => MapEntry<String, int>(k, v)),
//     thyroid: json["thyroid"] == null ? null : Map.from(json["thyroid"]).map((k, v) => MapEntry<String, int>(k, v)),
//     urineTest: json["urineTest"] == null ? null : Map.from(json["urineTest"]).map((k, v) => MapEntry<String, int>(k, v)),
//     other: json["other"] == null ? null : Map.from(json["other"]).map((k, v) => MapEntry<String, int>(k, v)),
//     blood: json["blood"] == null ? null : Map.from(json["blood"]).map((k, v) => MapEntry<String, int>(k, v)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "liver": liver == null ? null : Map.from(liver!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "kidney": kidney == null ? null : Map.from(kidney!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "lipid": lipid == null ? null : Map.from(lipid!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "diabetes": diabetes == null ? null : Map.from(diabetes!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "thyroid": thyroid == null ? null : Map.from(thyroid!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "urineTest": urineTest == null ? null : Map.from(urineTest!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "other": other == null ? null : Map.from(other!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "blood": blood == null ? null : Map.from(blood!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//   };
// }

class InsightModel {
  InsightModel({
    this.name,
    this.items,

  });

  String? name;
  Map<String, dynamic>? items;

  factory InsightModel.fromJson(Map<String, dynamic> json) => InsightModel(
    name: json["name"] == null ? null : json["name"],
    items: json["items"] == null ? null : json["items"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "items": items == null ? null : items,
  };
}