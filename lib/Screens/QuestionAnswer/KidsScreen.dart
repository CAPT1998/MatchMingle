import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/SmokingScreen.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/question_provider.dart';

class KidsScreen extends StatefulWidget {
  const KidsScreen({super.key});

  @override
  State<KidsScreen> createState() => _KidsScreenState();
}

enum Kids { N, G, A, No }

class _KidsScreenState extends State<KidsScreen> {
  Kids Liveare = Kids.N;
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
                  Image.asset("assets/img/Vector.png"),
                  SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      title: "Your thoughts on having \nkids",
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
            Consumer<QuestionProvider>(
                builder: (context, questionProvider, child) {
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
                        trailing: Radio<Kids>(
                          value: Kids.N,
                          groupValue: Liveare,
                          onChanged: (Kids? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_4"] =
                                'No answer';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'Grown up',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Kids>(
                          value: Kids.G,
                          groupValue: Liveare,
                          onChanged: (Kids? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_4"] =
                                'Grown up';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'Already have',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Kids>(
                          value: Kids.A,
                          groupValue: Liveare,
                          onChanged: (Kids? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_4"] =
                                'Already have';
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        title: TextWidget(
                          title: 'No never',
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: Radio<Kids>(
                          value: Kids.No,
                          groupValue: Liveare,
                          onChanged: (Kids? value) {
                            setState(() {
                              Liveare = value!;
                            });
                            questionProvider.questionData["question_4"] =
                                'No never';
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
                              title: "4/7",
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
                                          builder: (context) =>
                                              SmokingScreen()));
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
