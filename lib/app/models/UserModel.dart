import 'package:flutter_mvc/config/Config.dart';

class UserModel {
  UserModel(
      {this.id,
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
      this.subscription,
      this.name,
      this.primaryDoctorId,
      this.followup,
      this.isMember,
      this.height,
      this.weight,
      this.age});

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic timezone;
  String? phone;
  String? salutation;
  dynamic bio;
  String? isVerified;
  String? walletBalance;
  String? avatar;
  String? tempOtp;
  dynamic dob;
  String? gender;
  dynamic country;
  dynamic occupation;
  String? state;
  String? city;
  String? pincode;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  String? language;
  PriDrNote? priDrNote;
  dynamic doctorId;
  String? progress;
  dynamic verifyDocStatus;
  dynamic relation;
  Subscription? subscription;
  String? name;
  String? primaryDoctorId;
  int? followup;
  bool? isMember;
  String? weight;
  String? height;
  int? age;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        height: json['height'],
        weight: json['weight'],
        age: json['age'],
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        timezone: json["timezone"],
        phone: json["phone"] == null ? null : json["phone"],
        salutation: json["salutation"] == null ? null : json["salutation"],
        bio: json["bio"],
        isVerified:
            json["is_verified"] == null ? '0' : json["is_verified"].toString(),
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toString(),
        avatar: json["avatar"] == null ? null : json["avatar"],
        tempOtp: json["temp_otp"] == null ? null : json["temp_otp"],
        dob: json["dob"],
        gender: json["gender"] == null ? null : json["gender"],
        country: json["country"],
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
        status: json["status"] == null ? null : json["status"].toString(),
        language: json["language"] == null ? null : json["language"],
        priDrNote: json["pri_dr_note"] == null
            ? null
            : PriDrNote.fromJson(json["pri_dr_note"]),
        doctorId: json["doctor_id"],
        progress: json["progress"] == null ? null : json["progress"].toString(),
        verifyDocStatus: json["verify_doc_status"] == null
            ? null
            : json["verify_doc_status"],
        relation: json["relation"],
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        name: json["name"] == null ? null : json["name"],
        followup: json["followup"] == null ? null : json["followup"],
        isMember: json["is_member"] == null
            ? false
            : json["is_member"].toString() == "1",
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "timezone": timezone,
        "phone": phone == null ? null : phone,
        "salutation": salutation,
        "bio": bio,
        "is_verified": isVerified == null ? null : isVerified,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "avatar": avatar == null ? null : avatar,
        "temp_otp": tempOtp == null ? null : tempOtp,
        "dob": dob,
        "gender": gender == null ? null : gender,
        "country": country,
        "occupation": occupation,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "pincode": pincode == null ? null : pincode,
        "address": address == null ? null : address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status": status == null ? null : status,
        "language": language == null ? null : language,
        "pri_dr_note": priDrNote == null ? null : priDrNote?.toJson(),
        "doctor_id": doctorId,
        "progress": progress == null ? null : progress,
        "verify_doc_status": verifyDocStatus == null ? null : verifyDocStatus,
        "relation": relation,
        "subscription": subscription == null ? null : subscription?.toJson(),
        "name": name == null ? null : name,
        "followup": followup == null ? null : followup,
        "is_member": isMember == null ? false : isMember,
        'height': height,
        'weight': weight,
        'age': age
      };
}

class PriDrNote {
  PriDrNote({
    this.doctorName,
    this.phoneNo,
    this.state,
    this.city,
    this.state_name,
    this.city_name,
    this.address,
    this.pincode,
  });

  String? doctorName;
  String? phoneNo;
  String? state;
  String? city;
  // List<City>? state;
  // List<City>? city;
  String? state_name;
  String? city_name;
  String? address;
  String? pincode;

  factory PriDrNote.fromJson(Map<String, dynamic> json) => PriDrNote(
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        phoneNo: json["phone_no"] == null ? null : json["phone_no"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        // state: json["state"] == null ? null : List<City>.from(json["state"].map((x) => City.fromJson(x))),
        // city: json["city"] == null ? null : List<City>.from(json["city"].map((x) => City.fromJson(x))),
        state_name: json["state_name"] == null ? null : json["state_name"],
        city_name: json["city_name"] == null ? null : json["city_name"],
        address: json["address"] == null ? null : json["address"],
        pincode: json["pincode"] == null ? null : json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName == null ? null : doctorName,
        "phone_no": phoneNo == null ? null : phoneNo,

        "state": state == null ? null : state,
        "city": city == null ? null : city,
        // "state": state == null ? null : List<dynamic>.from(state!.map((x) => x.toJson())),
        // "city": city == null ? null : List<dynamic>.from(city!.map((x) => x.toJson())),
        "state_name": state_name == null ? null : state_name,
        "city_name": city_name == null ? null : city_name,
        "address": address == null ? null : address,
        "pincode": pincode == null ? null : pincode,
      };
}

class Subscription {
  Subscription({
    this.id,
    this.userId,
    this.subscriptionId,
    this.fromDate,
    this.toDate,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? userId;
  int? subscriptionId;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        subscriptionId:
            json["subscription_id"] == null ? null : json["subscription_id"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "subscription_id": subscriptionId == null ? null : subscriptionId,
        "from_date": fromDate == null
            ? null
            : "${fromDate?.year.toString().padLeft(4, '0')}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}",
        "to_date": toDate == null
            ? null
            : "${toDate?.year.toString().padLeft(4, '0')}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}",
        "parent_id": parentId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };

  bool isTrial() => this.subscriptionId == Config.trialPackageId;
  bool isExpired() => this.toDate!.isBefore(DateTime.now());

  /// Checks if the subscription is
  /// in trial or expired
  ///
  bool isActive() => !this.isTrial() && this.toDate!.isAfter(DateTime.now());
}
