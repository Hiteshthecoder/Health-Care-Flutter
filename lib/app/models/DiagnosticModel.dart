

class DiagnosticModel {
  DiagnosticModel({
    this.id,
    this.name,
    this.countryId,
    this.stateId,
    this.cityId,
    this.pincode,
    this.addressline1,
    this.addressline2,
    this.district,
    this.mobileNo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.country,
    this.state,
    this.city,
  });

  int? id;
  String? name;
  int? countryId;
  int? stateId;
  int? cityId;
  String? pincode;
  String? addressline1;
  dynamic addressline2;
  String? district;
  String? mobileNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  City? country;
  City? state;
  City? city;

  factory DiagnosticModel.fromJson(Map<String, dynamic> json) => DiagnosticModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    stateId: json["state_id"] == null ? null : json["state_id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    pincode: json["pincode"] == null ? null : json["pincode"],
    addressline1: json["addressline_1"] == null ? null : json["addressline_1"],
    addressline2: json["addressline_2"],
    district: json["district"] == null ? null : json["district"],
    mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    country: json["country"] == null ? null : City.fromJson(json["country"]),
    state: json["state"] == null ? null : City.fromJson(json["state"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "country_id": countryId == null ? null : countryId,
    "state_id": stateId == null ? null : stateId,
    "city_id": cityId == null ? null : cityId,
    "pincode": pincode == null ? null : pincode,
    "addressline_1": addressline1 == null ? null : addressline1,
    "addressline_2": addressline2,
    "district": district == null ? null : district,
    "mobile_no": mobileNo == null ? null : mobileNo,
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "country": country == null ? null : country?.toJson(),
    "state": state == null ? null : state?.toJson(),
    "city": city == null ? null : city?.toJson(),
  };
}

class City {
  City({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
