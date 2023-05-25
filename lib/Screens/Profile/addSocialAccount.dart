import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/social_account_provider.dart';
import '../../Widgets/TextFormWidget.dart';

class addSocialAccount extends StatefulWidget {
  const addSocialAccount({super.key});

  @override
  State<addSocialAccount> createState() => _addSocialAccountState();
}

class _addSocialAccountState extends State<addSocialAccount> {
  TextEditingController phNoCtrl = TextEditingController();
  TextEditingController facebookCtrl = TextEditingController();
  TextEditingController googleCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<AuthProvider, SocialAccountProvider>(
          builder: (context, authProvider, socialAccountProvider, child) {
        var profiledata = authProvider.loginModel!.userData[0];
        var social_accounts = profiledata.social_accounts[0];

        phNoCtrl.text = profiledata.social_accounts[0]['phone_number'];
        facebookCtrl.text = profiledata.social_accounts[0]['google'];
        googleCtrl.text = profiledata.social_accounts[0]['facebook'];
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
                )),
            actions: [
              IconButton(
                onPressed: () {
                  social_accounts ["phone_number"]= phNoCtrl.text;
                  social_accounts ["facebook"]= facebookCtrl.text;
                  social_accounts ["google"]= googleCtrl.text;
       
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
                  authProvider.update();
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
                name: profiledata.name,
                labelText: "Phone No",
                suffixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              textfieldProduct(
                context: context,
                controller: facebookCtrl,
                name: profiledata.name,
                labelText: "Facebook",
                suffixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              textfieldProduct(
                context: context,
                controller: googleCtrl,
                name: profiledata.name,
                labelText: "Google",
                suffixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
