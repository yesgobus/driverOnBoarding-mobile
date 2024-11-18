// To parse this JSON data, do
//
//     final cabDetailModel = cabDetailModelFromJson(jsonString);

import 'dart:convert';

TripDetailModel cabDetailModelFromJson(String str) =>
    TripDetailModel.fromJson(json.decode(str));

String cabDetailModelToJson(TripDetailModel data) => json.encode(data.toJson());

class TripDetailModel {
  String? status;
  String? rideID;

  String? receiverName;
  String? receiverNumber;
  String? transportType;
  bool? isTransportRide;
  List<String>? goodsType;

  String? currentTime;
  String? userName;
  String? userPhone;
  String? tripDistance;
  String? tripDuration;
  String? tripAmount;
  String? pickupAddress;
  String? pickupLat;
  String? pickupLng;
  String? dropAddress;
  String? dropLat;
  String? dropLng;
  String? pickupDistance;
  String? pickupDuration;

  TripDetailModel({
    this.status,
    this.rideID,
    this.currentTime,
    this.userName,
    this.receiverName,
    this.receiverNumber,
    this.transportType,
    this.isTransportRide,
    this.goodsType,
    this.userPhone,
    this.tripDistance,
    this.tripDuration,
    this.tripAmount,
    this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    this.dropAddress,
    this.dropLat,
    this.dropLng,
    this.pickupDistance,
    this.pickupDuration,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      TripDetailModel(
        status: json["status"],
        rideID: json["ride_id"],
        receiverNumber: json["reciever_number"] ?? "",
        receiverName: json["reciever_name"] ?? "",
        transportType: json["transport_type"] ?? "",
        isTransportRide: json["is_transport_ride"],
        goodsType: List<String>.from(json["goods_type"].map((x) => x)),
        currentTime: json["current_time"],
        userName: json["user_name"],
        userPhone: json["user_phone"],
        tripDistance: json["trip_distance"],
        tripDuration: json["trip_duration"],
        tripAmount: json["trip_amount"],
        pickupAddress: json["pickup_address"],
        pickupLat: json["pickup_lat"],
        pickupLng: json["pickup_lng"],
        dropAddress: json["drop_address"],
        dropLat: json["drop_lat"],
        dropLng: json["drop_lng"],
        pickupDistance: json["pickup_distance"],
        pickupDuration: json["pickup_duration"],
      );

  Map<String, dynamic> toJson() => {
        "current_time": currentTime,
        "user_name": userName,
        "trip_distance": tripDistance,
        "trip_duration": tripDuration,
        "trip_amount": tripAmount,
        "pickup_address": pickupAddress,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "drop_address": dropAddress,
        "drop_lat": dropLat,
        "drop_lng": dropLng,
        "pickup_distance": pickupDistance,
        "pickup_duration": pickupDuration,
      };
}
