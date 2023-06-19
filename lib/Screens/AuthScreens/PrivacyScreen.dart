import 'package:flutter/material.dart';
import 'package:teen_jungle/Screens/AuthScreens/quizScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              // backgroundColor: Colors.purple,
              radius: 50,
              backgroundImage: AssetImage('assets/img/logoprivacy.png'),
            ).pOnly(bottom: 30),
            TextWidget(title: "We care about your privacy", size: 22)
                .pOnly(bottom: 20),
            "We and our partners store and process infromation from your device to provide certain features, show you relevant ads and improve marketing campaigns"
                .text
                .align(TextAlign.center)
                .size(20)
                .color(Colors.grey[600])
                .make()
                .pOnly(bottom: 20),
            "You can personalise tour preferences or opt out at any time. Learn more in our\n"
                .text
                .size(20)
                .color(Colors.grey[600])
                .align(TextAlign.center)
                .make(),
            "Privacy Policy"
                .text
                .color(Colors.grey[700])
                .size(20)
                .align(TextAlign.center)
                .underline
                .make()
                .pOnly(bottom: 30),
            btn1(
              text: Text("I Accept"),
              textcolor: Colors.white,
              color: Color(0XFF24ABE3),
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizScreen()));
              },
            ).pOnly(bottom: 20),
            btn1(
              text: Text("may be later"),
              textcolor: Color(0XFF24ABE3),
              ontap: () {},
            )
          ]).px(20),
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
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: text.text.size(18).color(textcolor).bold.make().centered(),
      ),
    );
  }
}
