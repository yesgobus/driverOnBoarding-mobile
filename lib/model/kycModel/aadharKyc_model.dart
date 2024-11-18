// To parse this JSON data, do
//
//     final aadharModelSentOtp = aadharModelSentOtpFromJson(jsonString);

import 'dart:convert';

AadharModelSentOtp aadharModelSentOtpFromJson(String str) => AadharModelSentOtp.fromJson(json.decode(str));

String aadharModelSentOtpToJson(AadharModelSentOtp data) => json.encode(data.toJson());

class AadharModelSentOtp {
    bool? status;
    AadharModelSentOtpData? data;
    String ?message;

    AadharModelSentOtp({
        this.status,
        this.data,
        this.message,
    });

    factory AadharModelSentOtp.fromJson(Map<String, dynamic> json) => AadharModelSentOtp(
        status: json["status"],
        data: AadharModelSentOtpData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
    };
}

class AadharModelSentOtpData {
    String ?txnId;
    int ?timestamp;
    String? status;
    int ?statusCode;
    int ?responseCode;
    String? error;
    String? message;
    AadharOtpData? data;
    int ?okycHealth;

    AadharModelSentOtpData({
        this.txnId,
        this.timestamp,
        this.status,
        this.statusCode,
        this.responseCode,
        this.error,
        this.message,
        this.data,
        this.okycHealth,
    });

    factory AadharModelSentOtpData.fromJson(Map<String, dynamic> json) => AadharModelSentOtpData(
        txnId: json["txn_id"],
        timestamp: json["timestamp"],
        status: json["status"],
        statusCode: json["status_code"],
        responseCode: json["response_code"],
        error: json["error"].toString(),
        message: json["message"],
        data: AadharOtpData.fromJson(json["data"]),
        okycHealth: json["okyc_health"],
    );

    Map<String, dynamic> toJson() => {
        "txn_id": txnId,
        "timestamp": timestamp,
        "status": status,
        "status_code": statusCode,
        "response_code": responseCode,
        "error": error,
        "message": message,
        "data": data!.toJson(),
        "okyc_health": okycHealth,
    };
}

class AadharOtpData {
    String ?clientId;
    bool ?otpSent;
    bool ?ifNumber;
    bool ?validAadhaar;

    AadharOtpData({
        this.clientId,
        this.otpSent,
        this.ifNumber,
        this.validAadhaar,
    });

    factory AadharOtpData.fromJson(Map<String, dynamic> json) => AadharOtpData(
        clientId: json["client_id"],
        otpSent: json["otp_sent"],
        ifNumber: json["if_number"],
        validAadhaar: json["valid_aadhaar"],
    );

    Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "otp_sent": otpSent,
        "if_number": ifNumber,
        "valid_aadhaar": validAadhaar,
    };
}
