import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/Register1Screen.dart';
import 'package:teen_jungle/Screens/BottomNavigationBar/PersistanceNavigationBar.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../AuthScreens/LoginScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(
            title: "Account",
            size: 24,
            fontWeight: FontWeight.w400,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Consumer2<AuthProvider, ProfileProvider>(
                builder: (context, authProvider, profileProvider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "${authProvider.loginModel!.userData[0].profilePic}"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            await profileProvider.profileUpdate(
                                context,
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id);
                            authProvider.loginModel!.userData[0].profilePic =
                                profileProvider.profile;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey[50]),
                            child: Icon(
                              Icons.add_circle,
                              color: appColor,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                      title: authProvider.loginModel!.userData[0].name,
                      size: 30,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    title: TextWidget(
                        title: "Hide account",
                        size: 24,
                        maxline: 2,
                        fontWeight: FontWeight.w400),
                    subtitle: TextWidget(
                      title: "Like you deleted it, but can back\nwhen you live",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
                    trailing: Checkbox(
                        value: authProvider.loginModel!.userData[0].hide == 0
                            ? false
                            : true,
                        onChanged: (value) {
                          authProvider.loginModel!.userData[0].hide =
                              value == false ? 0 : 1;
                          authProvider.hideAccount(
                              context,
                              authProvider.loginModel!.token,
                              authProvider.loginModel!.userData[0].id,
                              authProvider.loginModel!.userData[0].hide);
                          setState(() {});
                        }),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  RoundedLoadingButton(
                    controller: buttonController,
                    borderRadius: 10,
                    color: pinkColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                      buttonController.reset();
                    },
                    child: TextWidget(
                      title: "Sign Out",
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
