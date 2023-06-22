import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Provider/limituseraccess_provider.dart';
import 'package:teen_jungle/Provider/question_provider.dart';
import 'package:teen_jungle/Screens/Profile/EditProfileScreen.dart';
import 'package:teen_jungle/Screens/Profile/seeProfile.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/DescribeYourSelf.dart';
import 'package:teen_jungle/Screens/Setting/SettingScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constant.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/social_account_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../AuthScreens/LoginScreen.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';
import '../Payment.dart/Payment.dart';
import '../PlansMembership/plansMembership.dart';
import '../Setting/BasicInfo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Key avatarKey;
  String? planid = "";
  // late final QuestionProvider questionProvider = QuestionProvider();
  late QuestionProvider
      questionProviderInstance; // Rename the variable to avoid conflict
  String email = "";
  var password = "";
  late String islogedin;
  late String isgooglelogin;
  late String completionText;
  bool fetching = true;
  void initState() {
    // TODO: implement initState
    avatarKey = UniqueKey(); // Generate a new unique key initially

    super.initState();
    print("asd");
    myFunction(context);
    fetchUserPlan();
  }

  void myFunction(BuildContext context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    QuestionProvider questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    await profileProvider.userDetail(
        id: authProvider.loginModel!.userData[0].id.toString(),
        token: authProvider.loginModel!.token,
        distance: "",
        context: context);
    print(authProvider.loginModel!.userData[0].id.toString() + " curent id");
    await questionProvider.fetchUserQuestions(
        authProvider.loginModel!.userData[0].id.toString(),
        authProvider.loginModel!.token);
    setState(() {
      fetching = false;
    });
  }

  Future<void> fetchUserPlan() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    LimitUserAccessProvider limit =
        Provider.of<LimitUserAccessProvider>(context, listen: false);
    planid = await limit.getUserPlan(
      context,
      authProvider.loginModel!.token,
      authProvider.loginModel!.userData[0].id.toString(),
    );

    if (planid != null) {
      print("User plan id is $planid");
      // Rest of your logic here
    } else {
      print("Failed to get user plan");
      // Handle the error case here
    }
  }

  mupdate(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email") ?? '';
      password = prefs.getString("password") ?? '';
      islogedin = prefs.getString('islogedin') ?? "";
      isgooglelogin = prefs.getString('isgooglelogin') ?? "";
    });

    // ignore: unnecessary_null_comparison
    if (islogedin == "true") {
      await value.mLoginAuth(context,
          email: email.toString(), password: password.toString());
      print("isloged in is " + islogedin);
      Timer(const Duration(seconds: 2), () {
        //   Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (_) => const BottomNavigationScreen()));
      });
    } else if (isgooglelogin == 'true') {
      await value.googleSignUp(context);
      if (value.loginMessage == "User Login Successfully") {
        //  Navigator.push(
        //      context,
        //     MaterialPageRoute(
        //       builder: (context) => const BottomNavigationScreen()));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer5<AuthProvider, ProfileProvider, QuestionProvider,
                  LimitUserAccessProvider, SocialAccountProvider>(
              builder: (context, authProvider, profileProvider,
                  questionProviderData, limituseraccess, socialinfo, child) {
            var userData = authProvider.loginModel!.userData[0];
            var questionData = userData.userQuestion.isNotEmpty
                ? userData.userQuestion[0]
                : {};
            print("in widget the plan id comming is " + planid!);
            bool allQuestionsAnswered = questionData.isNotEmpty
                ? questionData.values.every((answer) => answer != 'No answer')
                : false;
            var socialAccounts = userData.social_accounts;
            bool allAccountsNotEmpty = socialAccounts.isNotEmpty &&
                socialAccounts.every((account) {
                  return account != null &&
                      account.containsKey("phone_number") &&
                      account.containsKey("facebook") &&
                      account.containsKey("google") &&
                      account["phone_number"] != null &&
                      account["facebook"] != null &&
                      account["google"] != null;
                });

            print("social status is");
            print(allAccountsNotEmpty);
            // var socialcompleterion
            String completionText;
            if (allQuestionsAnswered &&
                authProvider.loginModel!.userData[0].profilePic !=
                    'https://19jungle.pakwexpo.com/images/profile_picture_folder' &&
                allAccountsNotEmpty) {
              completionText = '100%';
            } else if (allQuestionsAnswered) {
              completionText = '70%';
            } else if (allQuestionsAnswered &&
                authProvider.loginModel!.userData[0].profilePic !=
                    'https://19jungle.pakwexpo.com/images/profile_picture_folder') {
              completionText = '70%';
            } else if (authProvider.loginModel!.userData[0].profilePic !=
                'https://19jungle.pakwexpo.com/images/profile_picture_folder') {
              completionText = '20%';
            } else if (allAccountsNotEmpty) {
              completionText = '10%';
            } else if (allAccountsNotEmpty &&
                authProvider.loginModel!.userData[0].profilePic !=
                    'https://19jungle.pakwexpo.com/images/profile_picture_folder') {
              completionText = '30%';
            } else {
              completionText = '0%';
            }
            //String completionText = allQuestionsAnswered ? '70%' : authProvider.loginModel!.userData[0].profilePic == 'https://19jungle.pakwexpo.com/images/profile_picture_folder'? '30' :'50%';
            String profilecomplete = allQuestionsAnswered
                ? 'Edit Profile'
                : 'Get More attention, Compelte your Profile';
            return fetching
                ? const Center(
                    child: SpinKitPumpingHeart(
                    color: Color(0XFFE90691),
                    size: 70.0,
                  ))
                : Column(
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
                                authProvider.loginModel!.userData[0]
                                    .profilePic = profileProvider.profile;
                                mupdate(authProvider);
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
                        title: authProvider.loginModel!.userData[0].name
                            .toString(),
                        size: 24,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      planid == '1' ||
                              planid == '2' ||
                              planid == '3' ||
                              planid == '4' ||
                              planid == '5'
                          ? const Text(
                              'You are a Premium User!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFCD2626),
                                // Additional text style properties
                                letterSpacing: 1.2,
                                fontStyle: FontStyle.normal,
                                decorationColor: Colors.blue,
                                decorationThickness: 2.0,
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          seeProfile(
                              context, authProvider.loginModel!.userData[0]);
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
                            if (profilecomplete ==
                                "Get More attention, Compelte your Profile") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DescribeYourSelf()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfileScreen()));
                            }
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
                                title: completionText,
                                size: 20,
                                fontWeight: FontWeight.w400,
                                color: appColor),
                          ),
                          title: TextWidget(
                            title: profilecomplete,
                            maxline: 2,
                            size: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                      //Spacer(),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            plansMembership()));
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
                                  title: "19 Jungle Premium",
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor,
                                  maxline: 1,
                                ),
                                subtitle: TextWidget(
                                  title: "Upgrade",
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
                              onTap: () {},
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: yellowColor,
                                  child: Icon(
                                    Icons.diamond_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                title: TextWidget(
                                  title: planid == '0'
                                      ? "Free plan"
                                      : planid == "1"
                                          ? "Start Plan"
                                          : planid == "2"
                                              ? "Power Plan"
                                              : "Free plan",
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  color: greyColor,
                                ),
                                subtitle: TextWidget(
                                  title: "Activated",
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
