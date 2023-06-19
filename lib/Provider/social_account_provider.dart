import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Screens/BottomNavigationBar/PersistanceNavigationBar.dart';
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class SocialAccountProvider with ChangeNotifier {
  var message = "";
  addSocialAccount(context, token, socialAccountData) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/add-social-accounts');
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: socialAccountData);
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        //  Navigator.pop(context);
        print("======>${data["message"]}");
        SuccessFlushbar(context, "Social Account", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Social Account", data["message"]);
        notifyListeners();
      }
      print("=====>$data");
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Social Account", e.toString());
    }
  }
}
