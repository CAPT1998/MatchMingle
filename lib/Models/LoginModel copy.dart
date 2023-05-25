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
            json["user_data"].map((x) => UserDatum.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_data": List<dynamic>.from(userData.map((x) => x.toJson())),
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
    required this.social_accounts,
    this.blockedusers,
    required this.userQuestion,
    required this.createdAt,
    required this.updatedAt,
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
  List<socialData> social_accounts;
  dynamic blockedusers;
  List<questionData> userQuestion;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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

        social_accounts: List<socialData>.from(
            json["social_accounts"].map((x) => UserDatum.fromJson(x))),
        blockedusers: json["blockedusers"],
        userQuestion: List<questionData>.from(
            json["userQuestion"].map((x) => UserDatum.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "social_accounts":
            List<dynamic>.from(social_accounts.map((x) => x.toJson())),
        "blockedusers": blockedusers,
        "userQuestion": List<dynamic>.from(userQuestion.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class socialData {
  socialData({
    required this.phone_number,
    required this.google,
    required this.facebook,
  });

  String phone_number;
  String google;
  String facebook;

  factory socialData.fromJson(Map<String, dynamic> json) => socialData(
        phone_number: json["phone_number"],
        google: json["google"],
        facebook: json["facebook"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phone_number,
        "google": google,
        "facebook": facebook,
      };
}

class questionData {
  questionData({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    required this.question7,
  });

  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;

  factory questionData.fromJson(Map<String, dynamic> json) => questionData(
        question1: json["question_1"],
        question2: json["question_2"],
        question3: json["question_3"],
        question4: json["question_4"],
        question5: json["question_5"],
        question6: json["question_6"],
        question7: json["question_7"],
      );

  Map<String, dynamic> toJson() => {
        "question_1": question1,
        "question_2": question2,
        "question_3": question3,
        "question_4": question4,
        "question_5": question5,
        "question_6": question6,
        "question_7": question7,
      };
}






