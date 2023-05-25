import 'package:flutter/material.dart';

class GoogleModel {
  String? email;
  String? phoneNumber;
  String? userName;
  String? uid;
  String? picture;
  GoogleModel({
    this.email,
    this.phoneNumber,
    this.picture,
    this.uid,
    this.userName,
  });
  factory GoogleModel.fromJson(Map<String, dynamic> parsedJson) {
    return GoogleModel(
      email: parsedJson['email'] ?? null,
      phoneNumber: parsedJson['phoneNumber'] ?? null,
      picture: parsedJson['picture'] ?? null,
      uid: parsedJson['uid'] ?? null,
      userName: parsedJson['userName'] ?? null,
    );
  }
}
