import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class BlockUser with ChangeNotifier {
  String? returnMessage;
  blockUser(context, token, userId, blockId) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/block/add');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
        'block_id': blockId.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Block User", e.toString());
    }
  }

  Future<List<dynamic>> getBlockData(token, userId) async {
    final response = await http.get(
      Uri.parse('${AppUrl.baseUrl}/users/block/get?id=$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  unblockUser(context, token, userId, blockId) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/block/remove');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        'user_id': userId.toString(),
        'block_id': blockId.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      }
      print(data);
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Block User", e.toString());
    }
  }
}
