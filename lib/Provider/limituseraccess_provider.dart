import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/api_urls.dart';

// ...

class LimitUserAccessProvider with ChangeNotifier {
  // ...

  Future<int> checkUserPackage(context, token, userId) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/getpackage');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
      });
      final jsonResponse = json.decode(response.body);

      // Assuming the JSON response contains a "package" field representing the user's package
      final userPackage = jsonResponse['package'] as int;
      return userPackage;
    } catch (e) {
      // Handle any errors or exceptions
      return 12; // Assuming 0 indicates an error or unavailable package
    }
  }

  int checkFreePackage(context, token, userId) {
    return 0;
    // ...
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
