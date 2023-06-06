import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Models/LoginModel.dart';
import '../Screens/HomeScreens/HomeScreen.dart';
import '../Screens/HomeScreens/ProfileDialog.dart';
import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class ProfileProvider with ChangeNotifier {
  String? profile;
  LoginModel? loginModel;
  String? registerMessage;

  var userData = {};
  Future<void> profileUpdate(context, token, userId) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    try {
      if (pickedImage != null) {
        final request = http.MultipartRequest(
            'POST', Uri.parse('${AppUrl.baseUrl}/auth/updateProfileImage'));
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

        // var pickedImaage = File(pickedImage.path);
        request.fields['id'] = userId.toString();

        request.files.add(
            await http.MultipartFile.fromPath('profile_pic', pickedImage.path));

        var response = await request.send();
        notifyListeners();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print("Data $data");
        print("Profile : ${response.statusCode}");
        if (response.statusCode == 200) {
          loginModel = loginModelFromJson(responseBody);
          registerMessage = "success";
          this.registerMessage = registerMessage;
          this.loginModel = loginModel;
          print("Profile $profile");
          profile = data["data"]['profile_pic'];
          SuccessFlushbar(context, "Profile Update", data["message"]);

          notifyListeners();
        } else {
          // ErrorFlushbar(context, "Profile Update", data["message"]);
          notifyListeners();
        }
      } else {
        // Send an image from the asset folder instead
        final request = http.MultipartRequest(
            'POST', Uri.parse('${AppUrl.baseUrl}/auth/updateProfileImage'));
        request.headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

        request.fields['id'] = userId.toString();

        // Assuming you have an image named 'default_profile_pic.png' in the assets folder
        ByteData imageData = await rootBundle.load('assets/img/ifnoimage.png');
        List<int> bytes = imageData.buffer.asUint8List();
        var multipartFile = http.MultipartFile.fromBytes('profile_pic', bytes,
            filename: 'ifnoimage.png');

        request.files.add(multipartFile);

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print("Data $data");
        print("Profile : ${response.statusCode}");
        if (response.statusCode == 200) {
          loginModel = loginModelFromJson(responseBody);
          registerMessage = "success";
          this.registerMessage = registerMessage;
          this.loginModel = loginModel;
          print("Profile $profile");
          profile = data["data"]['profile_pic'];
          SuccessFlushbar(context, "Profile Update", data["message"]);

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
      String? location,
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
      location = userData["data"][0]["location"];
      print(response.statusCode);

      if (response.statusCode == 200) {
        profileDialog(context, userData["data"][0],
            double.parse(distance).round().toString());
        this.loginModel = loginModel;
        notifyListeners();
      } else {
        // ErrorFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("===>$e");
    }
    return location;
  }

  Future<AsyncSnapshot<List<dynamic>>> userDetail2(
      {required String id,
      required String token,
      required distance,
      String? location,
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
      final List<dynamic> userList = data["data"];
      final AsyncSnapshot<List<dynamic>> userSnapshot =
          AsyncSnapshot.withData(ConnectionState.done, userList);

      print(response.statusCode);

      if (response.statusCode == 200) {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: HomeCard(snapshot: userSnapshot),
          withNavBar: true,
        );
        this.loginModel = loginModel;
        notifyListeners();
      } else {
        // ErrorFlushbar(context, "Block User", data["message"]);
        notifyListeners();
      }
      return userSnapshot;
    } catch (e) {
      print("===>$e");
      throw e;
    }
  }
}
