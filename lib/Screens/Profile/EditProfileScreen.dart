import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Provider/auth_provider.dart';
import '../../Widgets/TextWidget.dart';
import '../Setting/BasicInfo.dart';
import 'addSocialAccount.dart';
import 'editquizscreens/aboutyou.dart';
import 'editquizscreens/childs.dart';
import 'editquizscreens/drinking.dart';
import 'editquizscreens/living.dart';
import 'editquizscreens/relationship.dart';
import 'editquizscreens/sexuality.dart';
import 'editquizscreens/smoking.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

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
              ),
            ),
          ),
          body: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              var userData = authProvider.loginModel!.userData[0];
              var questionData = userData.userQuestion;
              var socialAccounts = userData.social_accounts;

              return Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: ListView(
                  children: [
                    SizedBox(height: height * 0.02),
                    Center(
                      child: userData.profilePic ==
                              "https://19jungle.pakwexpo.com/api/auth/showProfileImage/"
                          ? Image.asset(
                              "assets/img/img8.png",
                              height: height * 0.2,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              userData.profilePic,
                              height: height * 0.2,
                              fit: BoxFit.fill,
                            ),
                    ),
                    SizedBox(height: height * 0.02),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasicInfoScreen()));
                      },
                      title: TextWidget(
                        title: "Basic info",
                        size: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      trailing: TextWidget(
                        title: userData.dob != null
                            ? "${userData.name}\n${DateTime.now().difference(DateTime.parse(userData.dob)).inDays ~/ 365} Year"
                            : "${userData.name}\nAge unknown",
                        size: 16,
                        maxline: 2,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                    const Divider(color: Colors.black),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Aboutyou()));
                      },
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
                        color: greyColor,
                      ),
                    ),
                    const Divider(color: Colors.black),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Relationship()));
                      },
                      leading: Icon(Icons.favorite),
                      title: TextWidget(
                        title: "Relationship",
                        size: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      subtitle: TextWidget(
                        title: questionData.length != 0
                            ? "${questionData[0]["question_2"]}"
                            : "",
                        size: 16,
                        maxline: 2,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                    //  const Divider(color: Colors.black),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Living()));
                      },
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
                        color: greyColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChildScreen()));
                      },
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
                        color: greyColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SmokeScreen()));
                      },
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
                        color: greyColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Drink()));
                      },
                      leading: Icon(Icons.local_drink),
                      title: TextWidget(
                        maxline: 1,
                        title: "Drinking",
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
                        color: greyColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Gender()));
                      },
                      leading: Icon(Icons.child_care_sharp),
                      title: TextWidget(
                        title: "Sexuality",
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
                        color: greyColor,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      children: [
                        TextWidget(
                          title: "Social Accounts ",
                          size: 18,
                        ),
                        TextButton(
                          onPressed: () {
                            // print(socialAccounts[0].toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSocialAccount(),
                              ),
                            );
                          },
                          //icon: Icon(Icons.add),
                          child: Text("Add Account"),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    ListTile(
                      leading: CircleAvatar(
                        radius: width * 0.035,
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
                        title: socialAccounts.length != 0
                            ? "${socialAccounts[0]["phone_number"] ?? "Empty"}"
                            : "",
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: width * 0.035,
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
                        title: socialAccounts.length != 0
                            ? "${socialAccounts[0]["facebook"] ?? "Empty"}"
                            : "",
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: width * 0.035,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.g_mobiledata_sharp,
                          size: width * 0.1,
                          color: Colors.white,
                        ),
                      ),
                      title: TextWidget(
                        title: "Google",
                        size: 16,
                      ),
                      subtitle: TextWidget(
                        title: socialAccounts.length != 0
                            ? "${socialAccounts[0]["google"] ?? "Empty"}"
                            : "",
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
