import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Provider/auth_provider.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/KidsScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../../Provider/question_provider.dart';

class Living extends StatefulWidget {
  const Living({super.key});

  @override
  State<Living> createState() => _LiveWithState();
}

enum Live { N, B, S, W }

class _LiveWithState extends State<Living> {
  Live Liveare = Live.N;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: redColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Icon(
                    Icons.home,
                    size: 100,
                    color: Colors.white,
                  ),
                  // Image.asset("assets/img/ico1.png"),
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                      title: "Who do you live with...",
                      size: 24,
                      textAlign: TextAlign.center,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Color(0XFF9AE2FF),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              ),
            ),
            Consumer2<QuestionProvider, AuthProvider>(
                builder: (context, questionProvider, AuthProvider, child) {
              return Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: height * 0.56,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'No answer',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Live>(
                          value: Live.N,
                          groupValue: Liveare,
                          onChanged: (Live? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_3"] =
                                'No answer';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'By myself',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Live>(
                          value: Live.B,
                          groupValue: Liveare,
                          onChanged: (Live? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_3"] =
                                'By myself';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'Student residence',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Live>(
                          value: Live.S,
                          groupValue: Liveare,
                          onChanged: (Live? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_3"] =
                                'Student residence';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'with parents',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Live>(
                          value: Live.W,
                          groupValue: Liveare,
                          onChanged: (Live? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_3"] =
                                'with parents';
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
                                  // AuthProvider.loginModel!.userData[0]
                                  //     .userQuestion = [{}];
                                  AuthProvider.loginModel!.userData[0]
                                          .userQuestion[0] =
                                      questionProvider.questionData;
                                 
                                  questionProvider.addQuestion(
                                      context,
                                      AuthProvider.loginModel!.token,
                                      AuthProvider.loginModel!.userData[0].id
                                          .toString());
                                  print("done");
                                  // Navigator.pop(context);

                                  //   Navigator.pushReplacement(
                                  //      context,
                                  //      MaterialPageRoute(
                                  //      builder: (context) => KidsScreen()));
                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
