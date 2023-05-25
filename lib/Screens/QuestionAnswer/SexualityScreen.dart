import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/question_provider.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';

class SexualityScreen extends StatefulWidget {
  const SexualityScreen({super.key});

  @override
  State<SexualityScreen> createState() => _SexualityScreenState();
}

enum Sexuality { N, B, G, A, S }

class _SexualityScreenState extends State<SexualityScreen> {
  Sexuality Liveare = Sexuality.N;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(title: "Sexuality", size: 18),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Consumer2<AuthProvider, QuestionProvider>(
            builder: (context, authProvider, questionProvider, child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  title: TextWidget(
                    title: 'No answer',
                    size: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Radio<Sexuality>(
                    value: Sexuality.N,
                    groupValue: Liveare,
                    onChanged: (Sexuality? value) {
                      setState(() {
                        Liveare = value!;
                      });
                      questionProvider.questionData["question_6"] = 'No answer';
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: TextWidget(
                    title: 'Bisexual',
                    size: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Radio<Sexuality>(
                    value: Sexuality.B,
                    groupValue: Liveare,
                    onChanged: (Sexuality? value) {
                      setState(() {
                        Liveare = value!;
                      });
                      questionProvider.questionData["question_6"] = 'Bisexual';
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: TextWidget(
                    title: 'Gay',
                    size: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Radio<Sexuality>(
                    value: Sexuality.G,
                    groupValue: Liveare,
                    onChanged: (Sexuality? value) {
                      setState(() {
                        Liveare = value!;
                      });
                      questionProvider.questionData["question_6"] = 'Gay';
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: TextWidget(
                    title: 'Ask me',
                    size: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Radio<Sexuality>(
                    value: Sexuality.A,
                    groupValue: Liveare,
                    onChanged: (Sexuality? value) {
                      setState(() {
                        Liveare = value!;
                      });
                      questionProvider.questionData["question_6"] = 'Ask me';
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: TextWidget(
                    title: 'Straight',
                    size: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Radio<Sexuality>(
                    value: Sexuality.S,
                    groupValue: Liveare,
                    onChanged: (Sexuality? value) {
                      setState(() {
                        Liveare = value!;
                      });
                      questionProvider.questionData["question_6"] = 'Straight';
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(15),
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
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ),
                      TextWidget(
                        title: "7/7",
                        size: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      Container(
                        // padding: EdgeInsets.all(15),
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
                        child: IconButton(
                          onPressed: () async {
                            authProvider.loginModel!.userData[0].userQuestion =
                                [{}];
                            authProvider
                                    .loginModel!.userData[0].userQuestion[0] =
                                questionProvider.questionData;
                            print(
                                "object${authProvider.loginModel!.userData[0].userQuestion.toString()}");
                            await questionProvider.addQuestion(
                                context,
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id
                                    .toString());
                          },
                          icon: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
