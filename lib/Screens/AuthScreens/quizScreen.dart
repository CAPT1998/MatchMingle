import 'package:flutter/material.dart';
import 'package:teen_jungle/Screens/Location/LocationAccessScreen.dart';
import 'package:teen_jungle/Screens/QuestionAnswer/DescribeYourSelf.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.cancel_sharp,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logoprivacy.png',
              height: MediaQuery.of(context).size.height * 1 / 3,
            ).pOnly(bottom: 30).centered(),
            TextWidget(
                    title: "Take our quick quiz to complete your profile",
                    size: 26)
                .pOnly(bottom: 20),
            "Get a great profile in just a few minutes!"
                .text
                .size(18)
                .color(Colors.grey)
                .align(TextAlign.start)
                .make()
                .pOnly(bottom: 70),
            btn1(
                textcolor: Colors.white,
                color: Color(0XFF24ABE3),
                text: Text("Start The Quiz"),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescribeYourSelf()));
                }).pOnly(bottom: 20),
            btn1(
                textcolor: Color(0XFF24ABE3),
                text: Text("Maybe Later"),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationAccessScreen()));
                }).pOnly(bottom: 10),
          ],
        ).px(20).py(20),
      ),
    );
  }
}

class btn1 extends StatelessWidget {
  btn1(
      {super.key,
      required this.textcolor,
      this.color,
      required this.text,
      required this.ontap});
  final Text text;
  final color;
  final Color textcolor;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: text.text.size(16).color(textcolor).bold.make().centered(),
      ),
    );
  }
}
