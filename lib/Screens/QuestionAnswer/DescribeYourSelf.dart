import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/YouAre.dart';
import 'package:teen_jungle/Widgets/TextFormWidget.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/question_provider.dart';

class DescribeYourSelf extends StatefulWidget {
  const DescribeYourSelf({super.key});

  @override
  State<DescribeYourSelf> createState() => _DescribeYourSelfState();
}

class _DescribeYourSelfState extends State<DescribeYourSelf> {
  TextEditingController DescribeCTRL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: pinkColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset("assets/img/ico3.png"),
                  SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                      title: "How You Describe \nYour Self.....",
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
                  padding: EdgeInsets.all(20),
                  height: height * 0.52,
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
                        height: 100,
                      ),
                      textfieldProduct(
                        context: context,
                        labelText:
                            "Describe Your Self to someone who Dosn’t Know you ",
                        name: "",
                        maxlength: 250,
                        controller: DescribeCTRL,
                      ),
                      Spacer(),
                      Row(
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
                            title: "1/7",
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
                                questionProvider.questionData["question_1"] =
                                    DescribeCTRL.text;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => YouAre()),
                                );
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
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
