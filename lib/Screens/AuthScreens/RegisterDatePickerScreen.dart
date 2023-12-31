import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/AuthScreens/RegisterGenderScreen.dart';
import 'package:teen_jungle/Screens/Location/LocationAccessScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import 'PrivacyScreen.dart';

class RegisterDatePickerScreen extends StatefulWidget {
  const RegisterDatePickerScreen({super.key});

  @override
  State<RegisterDatePickerScreen> createState() =>
      _RegisterDatePickerScreenState();
}

class _RegisterDatePickerScreenState extends State<RegisterDatePickerScreen> {
  bool visiblePassword = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, child) {
        var profiledata = authProvider.loginModel!.userData[0];

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  /*   TextWidget(
                    title:
                        "Hey! ${authProvider.loginModel!.userData[0].name}!, What's your\nbirthday",
                    size: 20,
                    maxline: 2,
                    fontWeight: FontWeight.w400,
                  ),
                  */
                  SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 50, 1),
                          lastDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          builder: (context, picker) {
                            return Container(
                              child: picker!,
                            );
                          }).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            final formattedDate =
                                "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                            authProvider.loginModel!.userData[0].dob =
                                formattedDate;
                          });
                        }
                      });
                    },
                    child: ListTile(
                      title: TextWidget(
                        title:
                            "Hey! ${authProvider.loginModel!.userData[0].name}!, What's your birthday",
                        size: 20,
                        fontWeight: FontWeight.w200,
                      ),
                      subtitle: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextWidget(
                            title: authProvider.loginModel!.userData[0].dob ??
                                "Select Your Date",
                            size: 22,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextWidget(
                    title: "You must be at least 18 to use 19 Teen Jungle",
                    size: 12,
                    maxline: 2,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Spacer(),
                  RoundedLoadingButton(
                    controller: buttonController,
                    borderRadius: 10,
                    onPressed: () async {
                      // Check if the selected date is at least 18 years old
                      final selectedDate =
                          authProvider.loginModel!.userData[0].dob;
                      final currentDate = DateTime.now();
                      final parsedSelectedDate = DateTime.parse(selectedDate!);
                      var ageDifference =
                          currentDate.year - parsedSelectedDate.year;

                      if (currentDate.month < parsedSelectedDate.month ||
                          (currentDate.month == parsedSelectedDate.month &&
                              currentDate.day < parsedSelectedDate.day)) {
                        ageDifference--;
                      }

                      if (ageDifference >= 18) {
                        print(ageDifference.toString());
                        await authProvider.BasicInfoUpdate(
                          profiledata.id,
                          profiledata.name,
                          profiledata.gender,
                          profiledata.dob,
                          profiledata.location,
                          authProvider.loginModel!.token,
                          context,
                          true,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyScreen()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Age'),
                              content: Text(
                                  'You must be at least 18 years old to use 19 Teen Jungle.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      buttonController.reset();
                    },
                    child: TextWidget(
                      title: "Continue",
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
