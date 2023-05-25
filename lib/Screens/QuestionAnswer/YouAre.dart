import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/LiveWith.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/question_provider.dart';
class YouAre extends StatefulWidget {
  const YouAre({super.key});

  @override
  State<YouAre> createState() => _YouAreState();
}

enum you { N, I, S, T }

class _YouAreState extends State<YouAre> {
  you youare = you.N;
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
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    "assets/img/heart.png",
                    height: height * 0.1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      title: "You Are....",
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
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              ),
            ),
            Consumer<QuestionProvider>(
                builder: (context, questionProvider, child) {
              return Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: height * 0.56,
                  width: width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'No answer',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<you>(
                          value: you.N,
                          groupValue: youare,
                          onChanged: (you? value) {
                            setState(() {
                              youare = value!;
                            });
                            questionProvider.questionData[0]["question_2"] =
                                'No answer';
                          },
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'I am in a complicated relationship',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<you>(
                          value: you.I,
                          groupValue: youare,
                          onChanged: (you? value) {
                            setState(() {
                              youare = value!;
                            });
                            questionProvider.questionData[0]["question_2"] =
                                'I am in a complicated relationship';
                          },
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'Single',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<you>(
                          value: you.S,
                          groupValue: youare,
                          onChanged: (you? value) {
                            setState(() {
                              youare = value!;
                            });
                            questionProvider.questionData[0]["question_2"] =
                                'Single';
                          },
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'Taken',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<you>(
                          value: you.T,
                          groupValue: youare,
                          onChanged: (you? value) {
                            setState(() {
                              youare = value!;
                            });
                            questionProvider.questionData[0]["question_2"] =
                                'Taken';
                          },
                        ),
                      ),
                      const Divider(
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
                              title: "2/7",
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
                                          builder: (context) => LiveWith()));
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
