import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Provider/auth_provider.dart';
import '../../Widgets/TextWidget.dart';
import 'addSocialAccount.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: TextWidget(
          title: "Profile",
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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.check,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        var userData = authProvider.loginModel!.userData[0];
        var questionData = userData.userQuestion;
        var social_accounts = userData.social_accounts;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: userData.profilePic ==
                          "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder/"
                      ? Image.asset(
                          "assets/img/img8.png",
                          height: height * 0.2,
                          // width: width * 0.4,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          userData.profilePic,
                          height: height * 0.2,
                          // width: width * 0.4,
                          fit: BoxFit.fill,
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: TextWidget(
                    title: "Basic info",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title:
                          "${userData.name}\n${DateTime.now().difference(DateTime.parse(userData.dob)).inDays ~/ 365} Year",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                const Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: TextWidget(
                    title: "About you",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  subtitle: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_1"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                const Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: TextWidget(
                    title: "Living",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_3"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.child_care_sharp),
                  title: TextWidget(
                    title: "Children",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_4"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.smoking_rooms),
                  title: TextWidget(
                    title: "Smoking",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_5"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: TextWidget(
                    title: "Relationship",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_6"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(Icons.child_care_sharp),
                  title: TextWidget(
                    title: "Sexuality ",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: TextWidget(
                      title: questionData.length != 0
                          ? "${questionData[0]["question_7"]}"
                          : "",
                      size: 16,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextWidget(
                      title: "Social Accounts ",
                      size: 18,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addSocialAccount()));
                        },
                        child: Text("Add Account"))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 23,
                    backgroundColor: appColor,
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  title: TextWidget(
                    title: "Phone number",
                    size: 16,
                  ),
                  subtitle: TextWidget(
                    title: social_accounts.length != 0
                        ? "${social_accounts[0]["phone_number"]}"
                        : "",
                    size: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 23,
                    backgroundColor: blueColor,
                    child: Icon(
                      Icons.facebook_sharp,
                      color: Colors.white,
                    ),
                  ),
                  title: TextWidget(
                    title: "Facebook",
                    size: 16,
                  ),
                  subtitle: TextWidget(
                    title: social_accounts.length != 0
                        ? "${social_accounts[0]["facebook"]}"
                        : "",
                    size: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.g_mobiledata_sharp,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  title: TextWidget(
                    title: "Google",
                    size: 16,
                  ),
                  subtitle: TextWidget(
                    title: social_accounts.length != 0
                        ? "${social_accounts[0]["google"]}"
                        : "",
                    size: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
