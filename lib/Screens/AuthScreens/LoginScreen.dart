// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/RegisterScreen.dart';
import 'package:teen_jungle/Screens/ComingSoon/ComingSoonScreen.dart';
import 'package:teen_jungle/Widgets/FlushbarWidget.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // var _email = "";
  // var _password = "";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  getauth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final String? newemail = prefs.getString('email');
      final String? newpassword = prefs.getString('password');
      email.text = newemail ?? "";
      password.text = newpassword ?? "";
    });
  }

  @override
  void initState() {
    getauth();
    // TODO: implement initState
    super.initState();
  }

  bool visiblePassword = true;
  bool rememberMe = false;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Consumer<AuthProvider>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset("assets/img/whitelogo.png"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      title: "WELCOME!",
                      size: 24,
                      color: appColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      title: "Login",
                      size: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(title: "User Name", size: 14)),
                    textfieldProduct(
                      context: context,
                      controller: email,
                      name: "noreply@dirverapp.com",
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(title: "Password", size: 14)),
                    textfieldProduct(
                      context: context,
                      controller: password,
                      name: "******************",
                      obscureText: visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        },
                        icon: Icon(
                          visiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: rememberMe,
                            onChanged: (valueCheck) {
                              setState(() {
                                rememberMe = valueCheck!;
                              });
                            }),
                        TextWidget(
                          title: "Remember Me",
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedLoadingButton(
                      color: appColor,
                      controller: buttonController,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await value.mLoginAuth(
                              email: email.text, password: password.text);
                          if (value.loginMessage == "success") {
                            buttonController.success();
                            if (rememberMe == true) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('email', email.text);
                              await prefs.setString('password', password.text);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const BottomNavigationScreen()));
                            SuccessFlushbar(
                                context, "Login", "Login Successfull");
                            Timer(const Duration(seconds: 1), () {
                              buttonController.reset();
                            });
                          } else {
                            buttonController.error();
                            ErrorFlushbar(context, "Login",
                                "Please check your credential and try again....");
                            Timer(Duration(seconds: 1), () {
                              buttonController.reset();
                            });
                          }
                        } else {
                          buttonController.error();
                          Timer(Duration(seconds: 1), () {
                            buttonController.reset();
                          });
                        }
                      },
                      child: TextWidget(
                        title: "Login",
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: appColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appColor,
                          ),
                          child: TextWidget(
                            title: "OR",
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            await value.facebookLogin(context);
                            if (value.loginMessage == "success") {
                              buttonController.success();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigationScreen()));
                              SuccessFlushbar(context, "Login",
                                  "Login with facebook Successfull");
                              Timer(Duration(seconds: 1), () {
                                buttonController.reset();
                              });
                            } else {
                              buttonController.error();
                              // SuccessFlushbar(context, "Login",
                              //     "Please check your credential and try again....");
                              Timer(Duration(seconds: 1), () {
                                buttonController.reset();
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: blueColor,
                            child: Icon(
                              Icons.facebook_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await value.googleSignUp(context);
                            if (value.loginMessage ==
                                "User Login Successfully") {
                              buttonController.success();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationScreen()));
                              SuccessFlushbar(context, "Login",
                                  value.loginMessage.toString());
                              Timer(Duration(seconds: 1), () {
                                buttonController.reset();
                              });
                            } else {
                              buttonController.error();
                              SuccessFlushbar(context, "Login",
                                  value.loginMessage.toString());
                              Timer(Duration(seconds: 1), () {
                                buttonController.reset();
                              });
                            }
                          },
                          child: const CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.g_mobiledata_sharp,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: appColor,
                          child: const Icon(
                            Icons.install_desktop_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: TextWidget(
                        title: "Don't have an account? Sign Up",
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
