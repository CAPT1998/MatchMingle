import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/Register1Screen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextWidget(
                      title: "This is how you'll appear on \n19 Teen Jungle",
                      size: 20,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 100,
                  ),
                  textfieldProduct(
                    context: context,
                    controller: name,
                    name: "Jackson Manson",
                    labelText:
                        name.text.isEmpty ? "Jackson Manson" : "Your Name",
                  ),
                  SizedBox(
                    height: height * 0.3,
                  ),
                  RoundedLoadingButton(
                    controller: buttonController,
                    borderRadius: 10,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register1Screen(
                                      name: name.text,
                                    )));
                        buttonController.reset();
                      } else {
                        buttonController.error();
                        Timer(Duration(seconds: 1), () {
                          buttonController.reset();
                        });
                      }
                    },
                    child: TextWidget(
                      title: "Continue",
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
    );
  }
}
