import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/Setting/AccountScreen.dart';
import 'package:teen_jungle/Screens/Setting/BasicInfo.dart';
import 'package:teen_jungle/Screens/Setting/BlockUser.dart';
import 'package:teen_jungle/Screens/Setting/InboxScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

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
            TextWidget(
                title: "Version 1.0",
                size: 20,
                fontWeight: FontWeight.w400,
                color: greyColor),
          ],
        ),
      ),
    );
  }
}
