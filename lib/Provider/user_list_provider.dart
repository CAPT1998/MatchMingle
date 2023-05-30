import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/api_urls.dart';

class UserListProvider with ChangeNotifier {
  Future<List<dynamic>> getNerebyUsersList(token, userId) async {
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/nerebyUsersList?user_id=$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List> getAllUsersList(token) async {
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
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getFilterUsersList(
      token, userId, distance, gender, age) async {
    final response = await http.get(
      Uri.parse(
          '${AppUrl.baseUrl}/users/filterUserList?id=$userId&distance=$distance&gender=$gender&age=$age'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
