import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import 'RegisterDatePickerScreen.dart';

class RegisterGenderScreen extends StatefulWidget {
  const RegisterGenderScreen({super.key});

  @override
  State<RegisterGenderScreen> createState() => _RegisterGenderScreenState();
}

class _RegisterGenderScreenState extends State<RegisterGenderScreen> {
  bool visiblePassword = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, child) {
        return Scaffold(
          body: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Image.asset("assets/img/fulllogo.png"),
                ),
                TextWidget(
                  title: "Hey! You're...",
                  size: 30,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      minWidth: 120,
                      color: appColor,
                      onPressed: () {
                        authProvider.loginModel!.userData[0].gender = '1';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterDatePickerScreen()));
                      },
                      child: TextWidget(
                        title: "Male",
                        size: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      minWidth: 120,
                      color: appColor,
                      onPressed: () {
                        authProvider.loginModel!.userData[0].gender = '2';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterDatePickerScreen()));
                      },
                      child: TextWidget(
                        title: "Female",
                        size: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Spacer(),
                TextWidget(
                  title: "Powered By\nagenziasingleprettywoman.it",
                  size: 20,
                  maxline: 2,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
