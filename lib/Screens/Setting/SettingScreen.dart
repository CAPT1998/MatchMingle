import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/Setting/AccountScreen.dart';
import 'package:teen_jungle/Screens/Setting/BasicInfo.dart';
import 'package:teen_jungle/Screens/Setting/BlockUser.dart';
import 'package:teen_jungle/Screens/Setting/InboxScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../AuthScreens/LoginScreen.dart';
import 'AboutScreen.dart';
import 'HelpCenterScreen.dart';
import 'PolicyScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

enum Sexuality { N, B, G, A, S }

class _SettingScreenState extends State<SettingScreen> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  Future<void> clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Sexuality Liveare = Sexuality.N;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(
            title: "Settings",
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
        body: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BasicInfoScreen()));
              },
              title: TextWidget(
                title: "Basic info",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
              title: TextWidget(
                title: "Account",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PolicyScreen()));
              },
              title: TextWidget(
                title: "Privacy  Policy",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpCenterScreen()));
              },
              title: TextWidget(
                title: "Help Center",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
              title: TextWidget(
                title: "About",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BlockUserScreen()));
              },
              title: TextWidget(
                title: "Blocked User",
                size: 20,
                fontWeight: FontWeight.w400,
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
            ),
            ////   Divider(
            //     color: Colors.black,
            //   ),
            ///  ListTile(
            //    onTap: () {
            //      Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => InboxScreen()));
            //   },
            //    title: TextWidget(
            //      title: "Inbox",
            //     size: 20,
            //     fontWeight: FontWeight.w400,
            //     ),
            //  trailing: Icon(
            //       Icons.arrow_forward,
//),
            //   ),
            SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              controller: buttonController,
              borderRadius: 10,
              color: pinkColor,
              onPressed: () async {
                clearSharedPreferences();
                await _googleSignIn.signOut();
                await FacebookAuth.instance.logOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );

                buttonController.reset();
              },
              child: TextWidget(
                title: "Sign Out",
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
                title: "Version 0.2",
                size: 20,
                fontWeight: FontWeight.w400,
                color: greyColor),
          ],
        ),
      ),
    );
  }
}
