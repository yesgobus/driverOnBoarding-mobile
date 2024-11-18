// To parse this JSON data, do
//
//     final completeTripModel = completeTripModelFromJson(jsonString);

import 'dart:convert';

ConfigrationModel configrationModelFromJson(String str) =>
    ConfigrationModel.fromJson(json.decode(str));

String configrationModelToJson(ConfigrationModel data) =>
    json.encode(data.toJson());

class ConfigrationModel {
  bool? status;
  String? message;
  ConfigData? data;

  ConfigrationModel({
    this.status,
    this.message,
    this.data,
  });

  factory ConfigrationModel.fromJson(Map<String, dynamic> json) =>
      ConfigrationModel(
        status: json["status"],
        message: json["message"],
        data: ConfigData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class ConfigData {
  bool? isOnDuty;
  bool? onboardingCompleted;
  String? profileImg;
  String? name;

  ConfigData({
    this.isOnDuty,
    this.onboardingCompleted,
    this.profileImg,
    this.name,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
        isOnDuty: json["is_on_duty"],
        onboardingCompleted: json["onboarding_complete"],
        profileImg: json["profile_img"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {};
}
