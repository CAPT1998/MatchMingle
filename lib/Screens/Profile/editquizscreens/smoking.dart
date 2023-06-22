import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Provider/auth_provider.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/DrinkingScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../../Provider/question_provider.dart';



class SmokeScreen extends StatefulWidget {
  const SmokeScreen({super.key});

  @override
  State<SmokeScreen> createState() => _SmokingScreenState();
}

enum Smoking { N, IA, IH, ID }

class _SmokingScreenState extends State<SmokeScreen> {
  Smoking Liveare = Smoking.N;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: brownColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset("assets/img/Vector (1).png"),
                  SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      title: "You are feeling about \nsmoking are...",
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
            Consumer2<QuestionProvider,AuthProvider>(
                builder: (context, questionProvider, authProvider,child) {
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
                        trailing: Radio<Smoking>(
                          value: Smoking.N,
                          groupValue: Liveare,
                          onChanged: (Smoking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_5"] =
                                'No answer';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I am have smoker',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Smoking>(
                          value: Smoking.IA,
                          groupValue: Liveare,
                          onChanged: (Smoking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_5"] =
                                'I am have smoker';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I hate smoking',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Smoking>(
                          value: Smoking.IH,
                          groupValue: Liveare,
                          onChanged: (Smoking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_5"] =
                                'I hate smoking';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I don’t like it',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Smoking>(
                          value: Smoking.ID,
                          groupValue: Liveare,
                          onChanged: (Smoking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_5"] =
                                'I don’t like it';
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

                                   authProvider.loginModel!.userData[0]
                                          .userQuestion[0] =
                                      questionProvider.questionData;
                                 
                                  questionProvider.addQuestion(
                                      context,
                                      authProvider.loginModel!.token,
                                      authProvider.loginModel!.userData[0].id
                                          .toString());
                                  print("done");
                                 // Navigator.pushReplacement(
                               //       context,
                               ////       MaterialPageRoute(
                               //           builder: (context) =>
                                //              DrinkingScreen()));
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
