import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/LoginModel.dart';
import '../Screens/HomeScreens/ProfileDialog.dart';
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class ProfileProvider with ChangeNotifier {
  var profile;
  LoginModel? loginModel;
  var userData = {};
  Future<void> profileUpdate(context, token, userId) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedImage != null) {
        var request = http.MultipartRequest(
            'POST', Uri.parse('${AppUrl.baseUrl}/auth/updateProfileImage'));
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

        var imageFile = File(pickedImage.path);
        request.fields['id'] = userId.toString();

        request.files.add(
            await http.MultipartFile.fromPath('profile_pic', imageFile.path));

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print(data.toString());
        if (response.statusCode == 200) {
          profile = data["user_data"]['profile_pic'];
          SuccessFlushbar(context, "Profile Update", data["message"]);

          notifyListeners();
        } else {
          ErrorFlushbar(context, "Profile Update", data["message"]);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  userDetail(
      {required String id,
      required String token,
      required distance,
      required context}) async {
    String? registerMessage;
    LoginModel? loginModel;

    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/detail?id=$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> data = await json.decode(response.body);
      userData = data;
      if (response.statusCode == 200) {
        profileDialog(context, userData["data"][0],
            double.parse(distance).round().toString());
        notifyListeners();
      } else {
        // ErrorFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("===>$e");
    }
  }
}
