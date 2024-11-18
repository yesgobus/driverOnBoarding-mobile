// To parse this JSON data, do
//
//     final completeTripModel = completeTripModelFromJson(jsonString);

import 'dart:convert';

CompleteTripModel completeTripModelFromJson(String str) =>
    CompleteTripModel.fromJson(json.decode(str));

String completeTripModelToJson(CompleteTripModel data) =>
    json.encode(data.toJson());

class CompleteTripModel {
  bool? status;
  String? message;
  TripComplete? data;

  CompleteTripModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompleteTripModel.fromJson(Map<String, dynamic> json) =>
      CompleteTripModel(
        status: json["status"],
        message: json["message"],
        data: TripComplete.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class TripComplete {
  String? customerImage;
  String? customerName;
  String? pickupAddress;
  String? dropAddress;
  String? tripId;
  String? vehicleNumber;
  String? dateTimeRide;
  String? tripTime;
  String? distanceTravel;
  String? distanceFare;
  String? extraKmCharge;
  String? totalAmount;

  TripComplete({
    this.customerImage,
    this.customerName,
    this.pickupAddress,
    this.dropAddress,
    this.tripId,
    this.vehicleNumber,
    this.dateTimeRide,
    this.tripTime,
    this.distanceTravel,
    this.distanceFare,
    this.extraKmCharge,
    this.totalAmount,
  });

  factory TripComplete.fromJson(Map<String, dynamic> json) => TripComplete(
        customerImage: json["customer_image"],
        customerName: json["customer_name"],
        pickupAddress: json["pickup_address"],
        dropAddress: json["drop_address"],
        tripId: json["trip_id"],
        vehicleNumber: json["vehicle_number"],
        dateTimeRide: json["date_time_ride"],
        tripTime: json["trip_time"],
        distanceTravel: json["distance_travel"],
        distanceFare: json["distance_fare"],
        extraKmCharge: json["extra_km_charge"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "driver_image": customerImage,
        "driver_name": customerName,
        "pickup_address": pickupAddress,
        "drop_address": dropAddress,
        "trip_id": tripId,
        "vehicle_number": vehicleNumber,
        "date_time_ride": dateTimeRide,
        "trip_time": tripTime,
        "extra_km_charge": extraKmCharge,
        "total_amount": totalAmount,
      };
}
