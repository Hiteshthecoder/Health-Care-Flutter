import 'package:flutter_mvc/app/models/DoctorModel.dart';
import 'package:flutter_mvc/app/models/SymptomModel.dart';

class EPrescriptionModel {
  int? id;
  int? doctorId;
  int? patientId;
  String? medicationId;
  List<SymptomModel>? symptoms;
  List<String>? testsToTake;
  List<String>? diagnosis;
  String? advice;
  List<Medication>? medications;
  String? updatedAt;
  DoctorModel? doctor;
  EPrescriptionModel.fromJson(Map<String, dynamic> map) {
    doctor = DoctorModel.fromJson(map['doctor']);
    id = map['id'];
    doctorId = map['doctor_id'];
    patientId = map['patient_id'];
    medicationId = map['medication_id'];
    symptoms = [];
    for (var element in map['symptomData']) {
      symptoms!.add(SymptomModel.fromJson(element));
    }
    String? localTest = map['tests_to_take'];
    if (localTest != null && localTest.contains(',')) {
      testsToTake = localTest.split(',');
    } else if (localTest != null) {
      testsToTake = [localTest];
    } else {
      testsToTake = [];
    }
    String? diag = map['diagnosis'];
    if (diag != null && diag.contains(',')) {
      diagnosis = diag.split(',');
    } else if (diag != null) {
      diagnosis = [diag];
    } else {
      diagnosis = [];
    }
    advice = map['advice'];
    medications = [];
    for (var element in map['medications'] ?? []) {
      medications!.add(Medication.fromJson(element));
    }
    updatedAt = map['updated_at'];
  }

  toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'medication_id': medicationId,
      'symptoms': symptoms,
      'tests_to_take': testsToTake,
      'advice': advice,
      'diagnosis': diagnosis,
      'medications': medications!.map((e) => e.toJson()).toList()
    };
  }
}

class Medication {
  Medication(
      {this.name,
      this.duration,
      this.beforeMealMorning,
      this.beforeMealEvening,
      this.beforeMealLunch,
      this.beforeMealNight,
      this.afterMealLunch,
      this.afterMealMorning,
      this.afterMealEvening,
      this.afterMealNight});
  int? id;

  String? name;
  int? duration;
  String? durationType;
  String? remarks;
  bool? beforeMealMorning;
  bool? beforeMealLunch;
  bool? beforeMealEvening;
  bool? beforeMealNight;
  bool? afterMealMorning;
  bool? afterMealLunch;
  bool? afterMealEvening;
  bool? afterMealNight;

  Medication.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['drug_name'];
    remarks = map['remarks'] != null ? map['remarks'].toString() : "";
    durationType = map['duration_type'];
    duration = int.parse(map['duration']);
    beforeMealMorning = map['before_meal_morning'] == 1;
    beforeMealLunch = map['before_meal_lunch'] == 1;
    beforeMealEvening = map['before_meal_evening'] == 1;
    beforeMealNight = map['before_meal_night'] == 1;
    afterMealMorning = map['after_meal_morning'] == 1;
    afterMealLunch = map['after_meal_lunch'] == 1;
    afterMealEvening = map['after_meal_evening'] == 1;
    afterMealNight = map['after_meal_night'] == 1;
  }
  Medication.fromJsonEdit(Map<String, dynamic> map) {
    id = map['id'];
    name = map['drug_name'];
    duration = map['duration'];
    beforeMealMorning = map['before_meal_morning'];
    beforeMealLunch = map['before_meal_lunch'];
    beforeMealEvening = map['before_meal_evening'];
    beforeMealNight = map['before_meal_night'];
    afterMealMorning = map['after_meal_morning'];
    afterMealLunch = map['after_meal_lunch'];
    afterMealEvening = map['after_meal_evening'];
    afterMealNight = map['after_meal_night'];
    remarks = map['remarks'];
    durationType = map['duration_type'];
  }
  toJson() {
    return {
      'id': id,
      'drug_name': name,
      'duration': duration,
      'remarks': remarks,
      'duration_type': durationType,
      'after_meal_morning': afterMealMorning,
      'after_meal_lunch': afterMealLunch,
      'after_meal_evening': afterMealEvening,
      'after_meal_night': afterMealNight,
      'before_meal_morning': beforeMealMorning,
      'before_meal_lunch': beforeMealLunch,
      'before_meal_evening': beforeMealEvening,
      'before_meal_night': beforeMealNight,
    };
  }
}
