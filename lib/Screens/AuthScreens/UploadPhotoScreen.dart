import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/Register1Screen.dart';
import 'package:teen_jungle/Screens/BottomNavigationBar/PersistanceNavigationBar.dart';
import 'package:teen_jungle/Screens/ComingSoon/ComingSoonScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../Location/LocationAccessScreen.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer2<AuthProvider, ProfileProvider>(
              builder: (context, authProvider, profileProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextWidget(
                      title: "Picture small\nChoose your Photo ",
                      size: 30,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 120,
                  ),
                  Stack(
                    children: [
                      authProvider.loginModel!.userData[0].profilePic !=
                              "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(authProvider
                                  .loginModel!.userData[0].profilePic),
                            )
                          : const CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/img/img1.png"),
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
                  SizedBox(
                    height: height * 0.1,
                  ),
                  RoundedLoadingButton(
                    controller: buttonController,
                    borderRadius: 10,
                    onPressed: () async {
                      if (authProvider.loginModel!.userData[0].profilePic !=
                          "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavigationScreen(),
                          ),
                        );
                      }
                      buttonController.reset();
                    },
                    child: TextWidget(
                      title: "Upload Your Photo",
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}