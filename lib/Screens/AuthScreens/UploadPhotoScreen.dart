import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Constant.dart';

import 'package:teen_jungle/Screens/BottomNavigationBar/PersistanceNavigationBar.dart';

import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Widgets/FlushbarWidget.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
        bool fetching = false;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: fetching
          ? SpinKitWave(
              color: Color.fromARGB(255, 88, 54, 236),
              size: 50.0,
            )
          :SingleChildScrollView(
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
                      //    authProvider.loginModel!.userData[0].profilePic !=
                      // "https://19jungle.pakwexpo.com/api/auth/showProfileImage"
                      //        "https://19jungle.pakwexpo.com/images/updateProfile"
                      // ? Container(
                      //     padding: EdgeInsets.all(30),
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         image: DecorationImage(
                      //           image: NetworkImage(authProvider
                      //               .loginModel!.userData[0].profilePic
                      //               .toString()),
                      //         )),
                      //   )
                      // : Container(
                      //     padding: EdgeInsets.all(60),
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         image: DecorationImage(
                      //           image: AssetImage("assets/img/img1.png"),
                      //         )),
                      //   ),

                      //  ? CircleAvatar(
                      //       radius: 80,
                      //       backgroundImage: NetworkImage(authProvider
                      //            .loginModel!.userData[0].profilePic
                      //            .toString()),
                      //      )
                      //    :
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("assets/img/img1.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                              setState(() {
    fetching = true; 
  });
                            await profileProvider.profileUpdate(
                                context,
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id);
                            authProvider.loginModel!.userData[0].profilePic =
                                profileProvider.profile;
                                setState(() {
                                  fetching =false;
                                });
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
                      if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        await authProvider.mLoginAuth(context,
                            email: email.text, password: password.text);
                        print("not called");
                          final SharedPreferences logininprefs =
                          await SharedPreferences.getInstance();
                         logininprefs.setString("islogedin", "true");
                         
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavigationScreen(),
                        ),
                      );
                      SuccessFlushbar(context, "Login", "Login Successfull");
                    
                      buttonController.reset();
                      } else {
                         final SharedPreferences logininprefs =
                          await SharedPreferences.getInstance();
                                                 logininprefs.setString("isgooglelogin", "true");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavigationScreen(),
                        ),
                      );
                      SuccessFlushbar(context, "Login", "Login Successfull");
                      //final SharedPreferences logininprefs =
                      //    await SharedPreferences.getInstance();
                      buttonController.reset();
                      }
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
