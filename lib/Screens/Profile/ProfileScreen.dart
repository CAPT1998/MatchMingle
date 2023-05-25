import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Screens/Profile/EditProfileScreen.dart';
import 'package:teen_jungle/Screens/Profile/seeProfile.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/DescribeYourSelf.dart';
import 'package:teen_jungle/Screens/Setting/SettingScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Constant.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../Payment.dart/Payment.dart';
import '../PlansMembership/plansMembership.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer2<AuthProvider, ProfileProvider>(
              builder: (context, authProvider, profileProvider, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SettingScreen(),
                          withNavBar: false,
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                    Image.asset(
                      "assets/img/logo.png",
                      height: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: EditProfileScreen(),
                          withNavBar: false,
                        );
                      },
                      icon: const Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: appColor),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title: authProvider.loginModel!.userData[0].name.toString(),
                  size: 24,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    seeProfile(context,authProvider.loginModel!.userData[0]);
                  },
                  child: TextWidget(
                    title: "Tap to see your Profile",
                    size: 25,
                    color: appColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Color(0XFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescribeYourSelf()));
                    },
                    leading: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Color(0XFF000000).withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: TextWidget(
                          title: "21%",
                          size: 20,
                          fontWeight: FontWeight.w400,
                          color: appColor),
                    ),
                    title: TextWidget(
                      title: "Get More attention compelte your Profile",
                      maxline: 2,
                      size: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => paymentScreen()));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: appColor,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                          title: TextWidget(
                            title: "Credites",
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: greyColor,
                          ),
                          subtitle: TextWidget(
                            title: "Add Credites",
                            size: 14,
                            maxline: 2,
                            fontWeight: FontWeight.w400,
                            color: appColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => plansMembership()));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: yellowColor,
                            child: Icon(
                              Icons.diamond_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: TextWidget(
                            title: "Badoo Premium",
                            size: 16,
                            fontWeight: FontWeight.w400,
                            color: greyColor,
                          ),
                          subtitle: TextWidget(
                            title: "Activate",
                            size: 14,
                            fontWeight: FontWeight.w400,
                            color: appColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
