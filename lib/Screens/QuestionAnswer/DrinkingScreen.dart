import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/SexualityScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/question_provider.dart';

class DrinkingScreen extends StatefulWidget {
  const DrinkingScreen({super.key});

  @override
  State<DrinkingScreen> createState() => _DrinkingScreenState();
}

enum Drinking { N, IS, ID, IA }

class _DrinkingScreenState extends State<DrinkingScreen> {
  Drinking Liveare = Drinking.N;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: blueColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    "assets/img/glass.png",
                    height: height * 0.1,
                  ),
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
            Consumer2<AuthProvider, QuestionProvider>(
                builder: (context, authProvider, questionProvider, child) {
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
                        trailing: Radio<Drinking>(
                          value: Drinking.N,
                          groupValue: Liveare,
                          onChanged: (Drinking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_6"] =
                                'No answer';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I drink Socially',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Drinking>(
                          value: Drinking.IS,
                          groupValue: Liveare,
                          onChanged: (Drinking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_6"] =
                                'I drink Socially';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I dont drink',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Drinking>(
                          value: Drinking.ID,
                          groupValue: Liveare,
                          onChanged: (Drinking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_6"] =
                                'I dont drink';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I am against drinking',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Drinking>(
                          value: Drinking.IA,
                          groupValue: Liveare,
                          onChanged: (Drinking? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_6"] =
                                'I am against drinking';
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
                              title: "6/7",
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
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SexualityScreen()),
                                  );
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
