import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/api_urls.dart';


class LimitUserAccessProvider with ChangeNotifier {

  getUserPlan(context, token, userId) async {
    final url = Uri.parse('${AppUrl.baseUrl}/users/$userId/details');
    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);
    final jsonData = json.decode(response.body);
    print(response.statusCode);
    print("code");

    if (response.statusCode == 200) {
      print(response.body);
      final userData = jsonData['data'];
      if (userData.isNotEmpty) {
        final user = userData[0];

        final planId = user['plan_id'];
        return planId != null ? planId.toString() : '0';
      }
    }

    return null;
  }

  Future<String> getconnectionscount(token, userId) async {
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/allLikedUsers?user_id=$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(response.body.toString());
      final List<dynamic> likedUsersList = parsed['data'];

      // Store the count of total liked users
      final int likedUsersCount = likedUsersList.length;
      final String countString = likedUsersCount.toString();

      print("likedusercount is" + likedUsersCount.toString());
      return countString;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
