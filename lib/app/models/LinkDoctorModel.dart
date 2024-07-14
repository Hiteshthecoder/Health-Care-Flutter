class LinkDoctorModel {
  LinkDoctorModel({
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
    this.district,
    this.pincode,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.language,
    this.priDrNote,
    this.doctorId,
    this.invitedBy,
    this.progress,
    this.verifyDocStatus,
    this.relation,
    this.fcmToken,
    this.linkmemberOtp,
    this.isMember,
    this.name,
  });

  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic timezone;
  String? phone;
  dynamic salutation;
  dynamic bio;
  int? isVerified;
  String? walletBalance;
  String? avatar;
  String? tempOtp;
  dynamic dob;
  dynamic gender;
  dynamic country;
  dynamic occupation;
  dynamic state;
  dynamic city;
  dynamic district;
  dynamic pincode;
  dynamic address;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? language;
  dynamic priDrNote;
  dynamic doctorId;
  dynamic invitedBy;
  int? progress;
  String? verifyDocStatus;
  dynamic relation;
  String? fcmToken;
  dynamic linkmemberOtp;
  int? isMember;
  String? name;

  factory LinkDoctorModel.fromJson(Map<String, dynamic> json) =>
      LinkDoctorModel(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        timezone: json["timezone"],
        phone: json["phone"] == null ? null : json["phone"],
        salutation: json["salutation"],
        bio: json["bio"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        walletBalance: json["wallet_balance"] == null
            ? null
            : json["wallet_balance"].toString(),
        avatar: json["avatar"] == null ? null : json["avatar"],
        tempOtp: json["temp_otp"] == null ? null : json["temp_otp"],
        dob: json["dob"],
        gender: json["gender"],
        country: json["country"],
        occupation: json["occupation"],
        state: json["state"],
        city: json["city"],
        district: json["district"],
        pincode: json["pincode"],
        address: json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"] == null ? null : json["status"],
        language: json["language"] == null ? null : json["language"],
        priDrNote: json["pri_dr_note"],
        doctorId: json["doctor_id"],
        invitedBy: json["invited_by"],
        progress: json["progress"] == null ? null : json["progress"],
        verifyDocStatus: json["verify_doc_status"] == null
            ? null
            : json["verify_doc_status"],
        relation: json["relation"],
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        linkmemberOtp: json["linkmember_otp"],
        isMember: json["is_member"] == null ? null : json["is_member"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
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
        "gender": gender,
        "country": country,
        "occupation": occupation,
        "state": state,
        "city": city,
        "district": district,
        "pincode": pincode,
        "address": address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status": status == null ? null : status,
        "language": language == null ? null : language,
        "pri_dr_note": priDrNote,
        "doctor_id": doctorId,
        "invited_by": invitedBy,
        "progress": progress == null ? null : progress,
        "verify_doc_status": verifyDocStatus == null ? null : verifyDocStatus,
        "relation": relation,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "linkmember_otp": linkmemberOtp,
        "is_member": isMember == null ? null : isMember,
        "name": name == null ? null : name,
      };
}
