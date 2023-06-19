import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/LoginScreen.dart';

import '../../Provider/auth_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String email = "";
  var password = "";
  late String islogedin;
  late String isgooglelogin;

  @override
  void initState() {
    // TODO: implement initState
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // authProvider.
    super.initState();
    //  checkLoginStatus();

    mupdate(authProvider);
  }

  mupdate(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email") ?? '';
      password = prefs.getString("password") ?? '';
      islogedin = prefs.getString('islogedin') ?? "";
      isgooglelogin = prefs.getString('isgooglelogin') ?? "";
    });

    // ignore: unnecessary_null_comparison
    if (islogedin == "true") {
      await value.mLoginAuth(context,
          email: email.toString(), password: password.toString());
      print("isloged in is " + islogedin);
   
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const BottomNavigationScreen()));

    } else if (isgooglelogin == 'true') {
      await value.googleSignUp(context);
      if (value.loginMessage == "User Login Successfully") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationScreen()));
        SuccessFlushbar(context, "Login", value.loginMessage.toString());
      }
    } else {
    
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
     
    }
  }

  checkLoginStatus() async {
    final SharedPreferences loginPrefs = await SharedPreferences.getInstance();
    var isLoggedIn = loginPrefs.getString("isloggedin");
    if (isLoggedIn == "true") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const BottomNavigationScreen()));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Opacity(opacity: 0, child: Text("data")),
                  Image.asset("assets/img/fulllogo.png"),
                  // TextWidget(
                  //   title: "Powered By\nagenziasingleprettywoman.it",
                  //   size: 20,
                  //   maxline: 2,
                  //   textAlign: TextAlign.center,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
