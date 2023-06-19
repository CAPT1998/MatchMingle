import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/AuthScreens/LoginScreen.dart';
import '../Widgets/api_urls.dart';

Future<void> clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class UserListProvider with ChangeNotifier {
  Future<List<dynamic>> getNerebyUsersList(context, token, userId) async {
    dynamic response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/nerebyUsersList?user_id=$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {


       final contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains('text/html')) {
       clearSharedPreferences();
        _googleSignIn.disconnect();
         PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const LoginScreen(),
          withNavBar: false,
        );
    }
    
      
      final parsed = jsonDecode(response.body);

      return parsed['data'];
    } else {
      // Check if the response is HTML

      return [];
    }
  }

  Future<List<dynamic>> getAllUsersList(token) async {
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/all'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getLikedUsersList(token, userId) async {
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/allLikedUsers?user_id=$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(response.body.toString());
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getFilterUsersList(
      token, userId, distance, gender, age) async {
    print({userId});

    final response = await http.post(
      Uri.parse(
          '${AppUrl.baseUrl}/users/filterUserList?id=$userId&distance=$distance&gender=$gender'),
      //&age=$age'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
