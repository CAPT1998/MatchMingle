import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/LoginScreen.dart';

import '../../Provider/auth_provider.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // authProvider.
    super.initState();
    mupdate(authProvider);
  }

  mupdate(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // email = prefs.getString("email") ?? '';
    // password = prefs.getString("password") ?? '';
    await value.mLoginAuth(
        email: email.toString(), password: password.toString());

    // ignore: unnecessary_null_comparison
    if (email != null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        );
      }),
    );
  }
}
