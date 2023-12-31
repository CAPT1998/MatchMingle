import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Screens/BottomNavigationBar/PersistanceNavigationBar.dart';
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class QuestionProvider with ChangeNotifier {
  Map questionData = {
    "question_1": 'No answer',
    "question_2": 'No answer',
    "question_3": 'No answer',
    "question_4": 'No answer',
    "question_5": 'No answer',
    "question_6": 'No answer',
    "question_7": 'No answer',
  };
  var message = "";

 


  Future<void> fetchUserQuestions(String userId, String token) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/auth/userQuestions?id=$userId');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);



         questionData = Map<String, String>.from(data['data'][0]['userQuestion']);
        notifyListeners();
      } else {
        // Handle the error case
      }
    } catch (e) {
      // Handle the exception
    }
  }

  addQuestion(context, token, userId) async {
    try {
      questionData.addAll({
        'user_id': userId.toString(),
      });
      print(questionData);
      var url = Uri.parse('${AppUrl.baseUrl}/auth/userQuestions');
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: questionData);
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        SuccessFlushbar(context, "Questions", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Questions", data["message"]);
        notifyListeners();
      }
      print("=====>$data");
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Questions", e.toString());
    }
  }
}
