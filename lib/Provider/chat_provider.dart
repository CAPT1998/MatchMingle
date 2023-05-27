import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class ChatProvider with ChangeNotifier {
  String? returnMessage;
  var chatdata = [];
  sentSMS(context, token, userId, reciverId, text) async {
    print('====>$userId====>$reciverId====>$text====>$token');
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/chat/create/text');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
        'other_user_id': reciverId.toString(),
        'text': text.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      print('data====>${data['message']}');
    } catch (e) {
      print("error=====>$e");
      ErrorFlushbar(context, "Block User", e.toString());
    }
  }

  var userData = {};
  Future<void> sentImage(context, token, userId, otherUserId, type) async {
    final picker = ImagePicker();
    var pickedImage;
    if (type == "Camera") {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else if (type == "Gallery") {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedImage = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
    }
    try {
      if (pickedImage != null) {
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                '${AppUrl.baseUrl}/chat/create/${type == "Video" ? "video" : "image"}'));
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
        var imageFile = File(pickedImage.path);
        request.fields['user_id'] = userId.toString();
        request.fields['other_user_id'] = otherUserId.toString();
        if (type == "Video") {
          request.files
              .add(await http.MultipartFile.fromPath('video', imageFile.path));
        } else {
          request.files
              .add(await http.MultipartFile.fromPath('image', imageFile.path));
        }

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print(data.toString());
        // if (response.statusCode == 200) {
        //   profile = data["user_data"]['profile_pic'];
        //   SuccessFlushbar(context, "Profile Update", data["message"]);

        //   notifyListeners();
        // } else {
        //   ErrorFlushbar(context, "Profile Update", data["message"]);
        //   notifyListeners();
        // }
      }
    } catch (e) {
      print(e);
    }
  }

  Future getChatData(
    token,
    userId,
  ) async {
    var url = Uri.parse('${AppUrl.baseUrl}/chat/get');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': userId.toString(),
    });
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print("=====>$parsed");
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> getMessageData(token, userId, theardID) async {
    var url = Uri.parse('${AppUrl.baseUrl}/chat/get/$theardID');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final parsed = jsonDecode(response.body);
    // print("data=====>$parsed");
    if (response.statusCode == 200) {
      // this.chatdata = parsed['data'];
      // notifyListeners();
      // while (true) {
      //   await Future.delayed(Duration(milliseconds: 5000));
      //   getMessageData(token, userId, theardID);
      // }
      return parsed['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
