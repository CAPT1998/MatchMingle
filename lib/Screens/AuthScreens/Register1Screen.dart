// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/RegisterGenderScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';
import 'UploadPhotoScreen.dart';

class Register1Screen extends StatefulWidget {
  Register1Screen({super.key, required this.name});
  String name;
  @override
  State<Register1Screen> createState() => _Register1ScreenState();
}

class _Register1ScreenState extends State<Register1Screen> {
  bool visiblePassword = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                      height: 50,
                    ),
                    TextWidget(
                      title: "What’s your email?",
                      size: 24,
                    ),
                    TextWidget(
                        title: "\n\nSign up with email instead",
                        size: 20,
                        maxline: 5,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 100,
                    ),
                    textfieldProduct(
                      context: context,
                      controller: email,
                      name: " jacksomason@hotmail.com",
                      labelText: "Email",
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textfieldProduct(
                      context: context,
                      name: "******",
                      controller: password,
                      labelText: "Password",
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
                      height: height * 0.3,
                    ),
                    RoundedLoadingButton(
                      controller: buttonController,
                      borderRadius: 10,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await value.mRegisterAuth(
                            name: widget.name,
                            email: email.text,
                            password: password.text,
                            context: context,
                          );
                          if (value.registerMessage == "success") {
                            buttonController.success();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterGenderScreen()));
                            SuccessFlushbar(
                                context, "Sign Up", "Sign Up Successfull");
                            Timer(const Duration(seconds: 1), () {
                              buttonController.reset();
                            });
                          } else {
                            buttonController.error();
                            ErrorFlushbar(context, "Sign Up",
                                value.registerMessage.toString());
                            Timer(const Duration(seconds: 1), () {
                              buttonController.reset();
                            });
                          }
                        } else {
                          buttonController.error();
                          Timer(Duration(seconds: 1), () {
                            buttonController.reset();
                          });
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RegisterGenderScreen()));
                        // buttonController.reset();
                      },
                      child: TextWidget(
                        title: "Contiuneu",
                        size: 14,
                        color: Colors.white,
                      ),
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
