import 'package:flutter/material.dart';

class BlockModel {
  String? userName;
  String? id;
  String? picture;
  BlockModel({
    this.picture,
    this.id,
    this.userName,
  });
  factory BlockModel.fromJson(Map<String, dynamic> parsedJson) {
    return BlockModel(
      picture: parsedJson['profile_pic'] ?? null,
      id: parsedJson['id'] ?? null,
      userName: parsedJson['name'] ?? null,
    );
  }
}
