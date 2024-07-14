// To parse this JSON data, do
//
//     final followupModel = followupModelFromJson(jsonString);

import 'dart:convert';

List<FollowupModel> followupModelFromJson(String str) =>
    List<FollowupModel>.from(
        json.decode(str).map((x) => FollowupModel.fromJson(x)));

String followupModelToJson(List<FollowupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FollowupModel {
  FollowupModel({
    this.id,
    this.doctorId,
    this.userId,
    this.remark,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.doctor,
  });

  int? id;
  String? doctorId;
  String? userId;
  String? remark;
  DateTime? date;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Doctor? doctor;

  factory FollowupModel.fromJson(Map<String, dynamic> json) => FollowupModel(
        id: json["id"] == null ? null : json["id"],
        doctorId:
            json["doctor_id"] == null ? null : json["doctor_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        remark: json["remark"] == null ? null : json["remark"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"] == null
            ? 'Scheduled'
            : json["status"] == 0
                ? 'Scheduled'
                : 'Examined',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "doctor_id": doctorId == null ? null : doctorId,
        "user_id": userId == null ? null : userId,
        "remark": remark == null ? null : remark,
        "date": date == null ? null : date?.toIso8601String(),
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "doctor": doctor == null ? null : doctor?.toJson(),
      };
}

class Doctor {
  Doctor({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.timezone,
    this.phone,
    this.salutation,
    this.bio,
    this.isVerified,
    this.walletBalance,
    this.avatar,
    this.tempOtp,
    this.dob,
    this.gender,
    this.country,
    this.occupation,
    this.state,
    this.city,
    this.pincode,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.language,
    this.priDrNote,
    this.doctorId,
    this.progress,
    this.verifyDocStatus,
    this.relation,
    this.name,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic timezone;
  String? phone;
  String? salutation;
  dynamic bio;
  dynamic isVerified;
  String? walletBalance;
  String? avatar;
  String? tempOtp;
  dynamic dob;
  String? gender;
  String? country;
  dynamic occupation;
  String? state;
  String? city;
  String? pincode;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  dynamic language;
  String? priDrNote;
  dynamic doctorId;
  String? progress;
  String? verifyDocStatus;
  dynamic relation;
  String? name;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        timezone: json["timezone"],
        phone: json["phone"] == null ? null : json["phone"],
        salutation: json["salutation"] == null ? null : json["salutation"],
        bio: json["bio"],
        isVerified: json["is_verified"],
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toString(),
        avatar: json["avatar"] == null ? null : json["avatar"],
        tempOtp: json["temp_otp"] == null ? null : json["temp_otp"],
        dob: json["dob"],
        gender: json["gender"] == null ? null : json["gender"],
        country: json["country"] == null ? null : json["country"].toString(),
        occupation: json["occupation"],
        state: json["state"] == null ? null : json["state"].toString(),
        city: json["city"] == null ? null : json["city"].toString(),
        pincode: json["pincode"] == null ? null : json["pincode"],
        address: json["address"] == null ? null : json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status:
            json["status"] == null ? 'Scheduled' : json["status"].toString(),
        language: json["language"],
        priDrNote: json["pri_dr_note"] == null ? null : json["pri_dr_note"],
        doctorId: json["doctor_id"],
        progress: json["progress"] == null ? null : json["progress"].toString(),
        verifyDocStatus: json["verify_doc_status"] == null
            ? null
            : json["verify_doc_status"],
        relation: json["relation"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "timezone": timezone,
        "phone": phone == null ? null : phone,
        "salutation": salutation == null ? null : salutation,
        "bio": bio,
        "is_verified": isVerified,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "avatar": avatar == null ? null : avatar,
        "temp_otp": tempOtp == null ? null : tempOtp,
        "dob": dob,
        "gender": gender == null ? null : gender,
        "country": country == null ? null : country,
        "occupation": occupation,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "pincode": pincode == null ? null : pincode,
        "address": address == null ? null : address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status": status == null ? null : status,
        "language": language,
        "pri_dr_note": priDrNote == null ? null : priDrNote,
        "doctor_id": doctorId,
        "progress": progress == null ? null : progress,
        "verify_doc_status": verifyDocStatus == null ? null : verifyDocStatus,
        "relation": relation,
        "name": name == null ? null : name,
      };
}
