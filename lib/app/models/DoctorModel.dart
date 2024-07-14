// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

// String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
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
    this.speciality,
    this.verifyDocStatus,
    this.relation,
    this.experience,
    this.qualification,
    this.name,
    this.countryData,
    this.stateData,
    this.cityData,
    this.workingAvailability,
    this.workingUpdate,
    this.appointmentPeriod,
    this.waitingPeriod,
    this.schedules,
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
  String? isVerified;
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
  String? language;
  PriDrNote? priDrNote;
  String? doctorId;
  String? progress;
  Data? speciality;
  String? verifyDocStatus;
  dynamic relation;
  List<Experience>? experience;
  List<Qualification>? qualification;
  String? name;
  Data? countryData;
  Data? stateData;
  Data? cityData;
  int? workingAvailability;
  String? workingUpdate;
  int? appointmentPeriod;
  int? waitingPeriod;
  List<DoctorModelSchedule>? schedules;

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['speciality']);
    return DoctorModel(
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
          json["is_verified"] == null ? null : json["is_verified"].toString(),
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
      status: json["status"] == null ? null : json["status"].toString(),
      language: json["language"] == null ? null : json["language"],
      priDrNote: json["pri_dr_note"] == null
          ? null
          : PriDrNote.fromJson(json["pri_dr_note"]),
      doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
      progress: json["progress"] == null ? null : json["progress"].toString(),
      speciality:
          json["speciality"] == null ? null : Data.fromJson(json["speciality"]),
      verifyDocStatus:
          json["verify_doc_status"] == null ? null : json["verify_doc_status"],
      relation: json["relation"],
      experience: json["Experience"] == null
          ? null
          : List<Experience>.from(
              json["Experience"].map((x) => Experience.fromJson(x))),
      qualification: json["Qualification"] == null
          ? null
          : List<Qualification>.from(
              json["Qualification"].map((x) => Qualification.fromJson(x))),
      name: json["name"] == null ? null : json["name"],
      countryData: json["country_data"] == null
          ? null
          : Data.fromJson(json["country_data"]),
      stateData:
          json["state_data"] == null ? null : Data.fromJson(json["state_data"]),
      cityData:
          json["city_data"] == null ? null : Data.fromJson(json["city_data"]),
      workingAvailability: json["working_availability"],
      workingUpdate: json["working_update"],
      appointmentPeriod: json["appointment_period"],
      waitingPeriod: json["waiting_period"],
      schedules: json["schedules"] == null
          ? []
          : List<DoctorModelSchedule>.from(
              json["schedules"]!.map((x) => DoctorModelSchedule.fromJson(x))),
    );
  }
}
//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "first_name": firstName == null ? null : firstName,
//         "last_name": lastName == null ? null : lastName,
//         "email": email == null ? null : email,
//         "email_verified_at": emailVerifiedAt,
//         "timezone": timezone,
//         "phone": phone == null ? null : phone,
//         "salutation": salutation == null ? null : salutation,
//         "bio": bio,
//         "is_verified": isVerified == null ? null : isVerified,
//         "wallet_balance": walletBalance == null ? null : walletBalance,
//         "avatar": avatar == null ? null : avatar,
//         "temp_otp": tempOtp == null ? null : tempOtp,
//         "dob": dob,
//         "gender": gender == null ? null : gender,
//         "country": country == null ? null : country,
//         "occupation": occupation,
//         "state": state == null ? null : state,
//         "city": city == null ? null : city,
//         "pincode": pincode == null ? null : pincode,
//         "address": address == null ? null : address,
//         "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
//         "status": status == null ? null : status,
//         "language": language == null ? null : language,
//         "pri_dr_note": priDrNote == null ? null : priDrNote?.toJson(),
//         "doctor_id": doctorId == null ? null : doctorId,
//         "progress": progress == null ? null : progress,
//         "speciality": speciality == null ? null : speciality,
//         "verify_doc_status": verifyDocStatus == null ? null : verifyDocStatus,
//         "relation": relation,
//         "Experience": experience == null
//             ? null
//             : List<dynamic>.from(experience!.map((x) => x.toJson())),
//         "Qualification": qualification == null
//             ? null
//             : List<dynamic>.from(qualification!.map((x) => x.toJson())),
//         "name": name == null ? null : name,
//         "country_data": countryData == null ? null : countryData?.toJson(),
//         "state_data": stateData == null ? null : stateData?.toJson(),
//         "city_data": cityData == null ? null : cityData?.toJson(),
//         "working_availability": workingAvailability,
//         "working_update": workingUpdate,
//         "appointment_period": appointmentPeriod,
//         "waiting_period": waitingPeriod,
//         "schedules": schedules == null
//             ? []
//             : List<dynamic>.from(schedules!.map((x) => x.toJson())),
//       };
// }

class Data {
  Data({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Experience {
  Experience({
    this.id,
    this.title,
    this.clinicName,
    this.startDate,
    this.endDate,
    this.location,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? title;
  String? clinicName;
  DateTime? startDate;
  DateTime? endDate;
  String? location;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        location: json["location"] == null ? null : json["location"],
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
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
        "title": title == null ? null : title,
        "clinic_name": clinicName == null ? null : clinicName,
        "start_date": startDate == null
            ? null
            : "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "location": location == null ? null : location,
        "user_id": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class PriDrNote {
  PriDrNote({
    this.nameOfClinic,
    this.clinicContactNo,
    this.state,
    this.city,
    this.address,
    this.phoneNo,
  });

  String? nameOfClinic;
  String? clinicContactNo;
  String? state;
  String? city;
  String? address;
  String? phoneNo;

  factory PriDrNote.fromJson(Map<String, dynamic> json) => PriDrNote(
        nameOfClinic:
            json["name_of_clinic"] == null ? null : json["name_of_clinic"],
        clinicContactNo: json["clinic_contact_no"] == null
            ? null
            : json["clinic_contact_no"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        phoneNo: json["phone_no"] == null ? null : json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "name_of_clinic": nameOfClinic == null ? null : nameOfClinic,
        "clinic_contact_no": clinicContactNo == null ? null : clinicContactNo,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "phone_no": phoneNo == null ? null : phoneNo,
      };
}

class Qualification {
  Qualification({
    this.id,
    this.degree,
    this.collegeName,
    this.fieldStudy,
    this.startDate,
    this.endDate,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? degree;
  String? collegeName;
  String? fieldStudy;
  DateTime? startDate;
  DateTime? endDate;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        id: json["id"] == null ? null : json["id"],
        degree: json["degree"] == null ? null : json["degree"],
        collegeName: json["college_name"] == null ? null : json["college_name"],
        fieldStudy: json["field_study"] == null ? null : json["field_study"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
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
        "degree": degree == null ? null : degree,
        "college_name": collegeName == null ? null : collegeName,
        "field_study": fieldStudy == null ? null : fieldStudy,
        "start_date": startDate == null
            ? null
            : "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "user_id": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class DoctorModelSchedule {
  DoctorModelSchedule({
    this.id,
    this.userId,
    this.day,
    this.schedules,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? userId;
  String? day;
  List<ScheduleSchedule>? schedules;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  DoctorModelSchedule copyWith({
    int? id,
    int? userId,
    String? day,
    List<ScheduleSchedule>? schedules,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      DoctorModelSchedule(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        day: day ?? this.day,
        schedules: schedules ?? this.schedules,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory DoctorModelSchedule.fromJson(Map<String, dynamic> json) =>
      DoctorModelSchedule(
        id: json["id"],
        userId: json["user_id"],
        day: json["day"],
        schedules: json["schedules"] == null
            ? []
            : List<ScheduleSchedule>.from(
                json["schedules"]!.map((x) => ScheduleSchedule.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "day": day,
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class ScheduleSchedule {
  ScheduleSchedule({
    this.from,
    this.to,
  });

  String? from;
  String? to;

  ScheduleSchedule copyWith({
    String? from,
    String? to,
  }) =>
      ScheduleSchedule(
        from: from ?? this.from,
        to: to ?? this.to,
      );

  factory ScheduleSchedule.fromJson(Map<String, dynamic> json) =>
      ScheduleSchedule(
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}
