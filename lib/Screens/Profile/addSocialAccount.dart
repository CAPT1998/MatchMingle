import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/social_account_provider.dart';
import '../../Widgets/TextFormWidget.dart';

class AddSocialAccount extends StatefulWidget {
  const AddSocialAccount({Key? key}) : super(key: key);

  @override
  _AddSocialAccountState createState() => _AddSocialAccountState();
}

class _AddSocialAccountState extends State<AddSocialAccount> {
  TextEditingController phNoCtrl = TextEditingController();
  TextEditingController facebookCtrl = TextEditingController();
  TextEditingController googleCtrl = TextEditingController();
  String email = "";
  var password = "";
  late String islogedin;
  late String isgooglelogin;

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
      child: Consumer2<AuthProvider, SocialAccountProvider>(
        builder: (context, authProvider, socialAccountProvider, child) {
          var profiledata = authProvider.loginModel!.userData[0];
          var socialAccounts = profiledata.social_accounts;

          if (socialAccounts.isNotEmpty) {
            phNoCtrl.text = socialAccounts[0]['phone_number'] ?? "";
            facebookCtrl.text = socialAccounts[0]['facebook'] ?? "";
            googleCtrl.text = socialAccounts[0]['google'] ?? "";
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              title: TextWidget(
                title: "Social Accounts",
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
              actions: [
                IconButton(
                  onPressed: () {
                    if (socialAccounts.isNotEmpty) {
                      socialAccounts[0]['phone_number'] = phNoCtrl.text;
                      socialAccounts[0]['facebook'] = facebookCtrl.text;
                      socialAccounts[0]['google'] = googleCtrl.text;
                    }

                    socialAccountProvider.addSocialAccount(
                      context,
                      authProvider.loginModel!.token,
                      {
                        "id": profiledata.id.toString(),
                        "phone_number": phNoCtrl.text,
                        "facebook": facebookCtrl.text,
                        "google": googleCtrl.text,
                      },
                    );
                    mupdate(authProvider);
                    // authProvider.update();
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.black,
                ),
                textfieldProduct(
                  context: context,
                  controller: phNoCtrl,
                  name: "Number",
                  labelText: "Phone No",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                textfieldProduct(
                  context: context,
                  controller: facebookCtrl,
                  name: "",
                  labelText: "Facebook",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                textfieldProduct(
                  context: context,
                  controller: googleCtrl,
                  name: "",
                  labelText: "Google",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
