// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.userData,
    required this.token,
  });

  bool status;
  String message;
  List<UserDatum> userData;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        userData: List<UserDatum>.from(
            json["data"].map((x) => UserDatum.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(userData.map((x) => x.toJson())),
        "token": token,
      };
}

class UserDatum {
  UserDatum({
    required this.id,
    required this.name,
    required this.email,
    // this.emailVerifiedAt,
    // this.emailVerificationCode,
    this.gender,
    this.dob,
    this.location,
    this.profilePic,
    this.latitude,
    this.longitude,
    // this.google_id,
    // this.facebook_id,
    this.hide,
    this.social_accounts,
    this.blockedusers,
    this.userQuestion,
    // required this.createdAt,
    // required this.updatedAt,
  });

  dynamic id;
  String name;
  String email;
  // dynamic emailVerifiedAt;
  // dynamic emailVerificationCode;
  dynamic gender;
  dynamic dob;
  dynamic location;
  dynamic profilePic;
  dynamic latitude;
  dynamic longitude;
  // dynamic google_id;
  // dynamic facebook_id;
  dynamic hide;
  dynamic social_accounts;
  dynamic blockedusers;
  dynamic userQuestion;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory UserDatum.fromJson(Map<dynamic, dynamic> json) => UserDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // emailVerificationCode: json["email_verification_code"],
        gender: json["gender"],
        dob: json["dob"],
        location: json["location"],
        profilePic: json["profile_pic"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        // google_id: json["google_id"],
        // facebook_id: json["facebook_id"],
        hide: json["hide"],
        social_accounts: json["social_accounts"],
        blockedusers: json["blockedusers"],
        userQuestion: json["userQuestion"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        // "email_verified_at": emailVerifiedAt,
        // "email_verification_code": emailVerificationCode,
        "gender": gender,
        "dob": dob,
        "location": location,
        "profile_pic": profilePic,
        "latitude": latitude,
        "longitude": longitude,
        // "google_id": google_id,
        // "facebook_id": facebook_id,
        "hide": hide,
        "social_accounts": social_accounts,
        "blockedusers": blockedusers,
        "userQuestion": userQuestion,

        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
      };
}
