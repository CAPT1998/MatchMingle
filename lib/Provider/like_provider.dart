import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class LikeProvider with ChangeNotifier {
  LikeUser(context, token, userId, profile_id) async {
    try {
      var url = Uri.parse(
          '$baseUrl/users/profileLikeAndDislike');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
        'profile_id': profile_id.toString(),
        'action': "${1}",
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Like User", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Like User", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Like User", e.toString());
    }
  }

  disLikeUser(context, token, userId, profile_id) async {
    try {
      var url = Uri.parse(
          '$baseUrl/users/profileLikeAndDislike');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
        'profile_id': profile_id.toString(),
        'action': "${0}",
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Like User", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Like User", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Like User", e.toString());
    }
  }
}