// To parse this JSON data, do
//
//     final bloodReportModel = bloodReportModelFromJson(jsonString);

import 'dart:convert';

List<BloodReportModel> bloodReportModelFromJson(String str) => List<BloodReportModel>.from(json.decode(str).map((x) => BloodReportModel.fromJson(x)));

String bloodReportModelToJson(List<BloodReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BloodReportModel {
  BloodReportModel({
    this.date,
    this.haemoglobin,
    this.wbc,
    this.platlets,
    this.retic,
    this.hematocrit,
  });

  DateTime? date;
  String? haemoglobin;
  String? wbc;
  String? platlets;
  String? retic;
  String? hematocrit;

  factory BloodReportModel.fromJson(Map<String, dynamic> json) => BloodReportModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    haemoglobin: json["haemoglobin"] == null ? null : json["haemoglobin"],
    wbc: json["wbc"] == null ? null : json["wbc"],
    platlets: json["platlets"] == null ? null : json["platlets"],
    retic: json["retic"] == null ? null : json["retic"],
    hematocrit: json["hematocrit"] == null ? null : json["hematocrit"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
    "haemoglobin": haemoglobin == null ? null : haemoglobin,
    "wbc": wbc == null ? null : wbc,
    "platlets": platlets == null ? null : platlets,
    "retic": retic == null ? null : retic,
    "hematocrit": hematocrit == null ? null : hematocrit,
  };
}
