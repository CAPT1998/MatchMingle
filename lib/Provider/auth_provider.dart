import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Models/LoginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:teen_jungle/Screens/AuthScreens/PrivacyScreen.dart';
import 'package:teen_jungle/Widgets/api_urls.dart';

import '../Models/GoogleModel.dart';
import '../Screens/AuthScreens/LoginScreen.dart';
import '../Screens/AuthScreens/RegisterGenderScreen.dart';
import '../Screens/AuthScreens/UploadPhotoScreen.dart';
import '../Screens/Location/LocationAccessScreen.dart';
import '../Widgets/FlushbarWidget.dart';

class AuthProvider with ChangeNotifier {
  LoginModel? loginModel;
  String? loginMessage;
  Map<String, dynamic> userData = {};
  mLoginAuth({required String email, required String password}) async {
    LoginModel? loginModel;
    String? loginMessage;
    try {
      final request = http.Request(
          'POST',
          Uri.parse(
              '${AppUrl.baseUrl}/auth/login?email=$email&password=$password'));
      http.StreamedResponse response = await request.send();
      String value = await response.stream.bytesToString();
      print('====>$value');
      print("${response.statusCode} + see");
      if (response.statusCode == 200) {
        loginModel = loginModelFromJson(value);
        loginMessage = "success";

        this.loginMessage = loginMessage;
        this.loginModel = loginModel;
        notifyListeners();
      } else {
        loginMessage = "unsuccess";
        this.loginModel = loginModel;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  String? registerMessage;

  mRegisterAuth({
    required String name,
    required String email,
    required String password,
    required context,
  }) async {
    String? registerMessage;
    LoginModel? loginModel;
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${AppUrl.baseUrl}/auth/register?name=$name&email=$email&password=$password'));
      http.StreamedResponse response = await request.send();
      String value = await response.stream.bytesToString();
      print('====>$value');
      print(response.statusCode);
      if (response.statusCode == 200) {
        loginModel = loginModelFromJson(value);
        registerMessage = "success";
        this.registerMessage = registerMessage;
        this.loginModel = loginModel;
        notifyListeners();
      } else {
        final Map<String, dynamic> data = json.decode(value);
        this.registerMessage = data["message"];
        this.loginModel = loginModel;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  userDetail({
    required String id,
    required String token,
  }) async {
    String? registerMessage;
    LoginModel? loginModel;

    try {
      var request = http.Request(
          'POST', Uri.parse('${AppUrl.baseUrl}/users/detail?id=$id'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String value = await response.stream.bytesToString();
        print('+++$value');
        loginModel = loginModelFromJson(value);
        this.loginModel = loginModel;
        // loginMessage = "success";
        // this.loginMessage = loginMessage;
        this.loginModel = loginModel;
        notifyListeners();
      } else {
        // loginMessage = "unsuccess";
        notifyListeners();
      }
      print("loginModel====>${loginModel}");
    } catch (e) {
      print(e);
    }
  }

  GoogleModel? googleModel;
  googleSignUp(context) async {
    String? loginMessage;
    GoogleModel? googleModel;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      userData = {
        "UID": user!.uid.toString(),
        "username": user.displayName.toString(),
        "email": user.email.toString(),
        // "phoneNumber": user.phoneNumber.toString(),
        //  "picture": user.photoURL.toString()
      };
      googleModel = GoogleModel.fromJson(userData);
      this.googleModel = googleModel;
      notifyListeners();
      var url = Uri.parse('${AppUrl.baseUrl}/auth/social');
      var response = await http.post(url, body: {
        'id': user!.uid.toString(),
        "name": user.displayName.toString(),
        "email": user.email.toString(),
        'type': "google",
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(data);
        SuccessFlushbar(context, "Login", data["message"]);
        if (loginModel!.userData[0].latitude == null &&
            loginModel!.userData[0].longitude == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterGenderScreen()));
        } else {
          print("====>login");
          this.loginMessage = data["message"];
        }

        notifyListeners();
      } else {
        this.loginMessage = data["message"];
        notifyListeners();
      }
    } catch (e) {
      this.loginMessage = e.toString();
      print(e);
    }
  }

  facebookLogin(context) async {
    try {
      final result = await FacebookAuth.i.login(
        permissions: [
          'public_profile',
          'email',
          'user_hometown',
          'user_gender',
          'user_birthday',
          // 'user_location',
          // 'pages_messaging',
          // 'pages_manage_metadata'
        ],
      );
      if (result.status == LoginStatus.success) {
        final _userData = await FacebookAuth.i.getUserData();
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        // final userCredential = await FirebaseAuth.instance
        //     .signInWithCredential(facebookCredential);
        // SuccessFlushbar(context, "Login", "Login Successfull");
        userData = {
          "UID": _userData["id"],
          "username": _userData["name"],
          "email": _userData["email"],
          // check
          "picture": _userData["picture"]["data"]["url"]
        };
        var url = Uri.parse('${AppUrl.baseUrl}/auth/social');
        var response = await http.post(url, body: {
          'id': _userData["id"].toString(),
          "name": _userData["name"].toString(),
          "email": _userData["email"].toString(),
          'type': "Facebook",
        });
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);
        if (response.statusCode == 200) {
          loginModel = LoginModel.fromJson(data);
          SuccessFlushbar(context, "Login", data["message"]);
          this.loginMessage = data["message"];
          notifyListeners();
        } else {
          this.loginMessage = data["message"];
          notifyListeners();
        }
      } else {
        this.loginMessage = "unsuccess";
        notifyListeners();
      }
    } catch (error) {
      SuccessFlushbar(context, "Login", "$error");
    }
  }

  BasicInfoUpdate(
      id, name, gender, dob, location, token, context, locationPage) async {
    LoginModel? loginModel;
    String? loginMessage;
    try {
      var url =
          Uri.parse('https://19jungle.pakwexpo.com/api/auth/updateProfile');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'id': id.toString(),
        'name': name,
        'gender': gender,
        'dob': dob,
        'location': 'null',
        'token': token
      });
      final Map<String, dynamic> data = json.decode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (locationPage) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrivacyScreen()));
        }
        SuccessFlushbar(context, "Profile", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Profile", data["message"]);
        notifyListeners();
      }
      print("======>$data");
    } catch (e) {
      print("======>$e");
      ErrorFlushbar(context, "Profile", e.toString());
      notifyListeners();
    }
  }

  hideAccount(context, token, id, hide) async {
    try {
      var url = Uri.parse('${AppUrl.baseUrl}l/auth/hideProfile');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'id': id.toString(),
        'hide': hide.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Account Delete", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Account Delete", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  deleteAccount(context, email, token) async {
    try {
      var url = Uri.parse(
          'https://marriageapi.pakwexpo.com/public/api/auth/userDelete');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'email': email,
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Account Delete", data["message"]);

        notifyListeners();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        ErrorFlushbar(context, "Account Delete", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  update() {
    this.loginModel = loginModel;
    notifyListeners();
  }
}
