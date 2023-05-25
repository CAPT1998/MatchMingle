import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width <= 600;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 245, 212, 222),
                  Color.fromARGB(255, 227, 243, 209),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: isSmallScreen ? 300 : 290,
              width: isSmallScreen ? 300 : 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:20, right: 20,top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Contact Us",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  textfieldProduct(
                    context: context,
                    onChanged: (value) {
                      // profiledata.name = value;
                    },
                    // name: profiledata.name,
                    name: "Mudassir Mukhtar",
                    labelText: "Name",
                  ),
                  textfieldProduct(
                    context: context,
                    onChanged: (value) {
                      // profiledata.name = value;
                    },
                    // name: profiledata.name,
                    name: "abc@gmail.com",
                    labelText: "Email",
                  ),
                  textfieldProduct(
                    context: context,
                    onChanged: (value) {
                      // profiledata.name = value;
                    },
                    // name: profiledata.name,
                    name: "Enter Your Message",
                    labelText: "Message",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/img/sent.jpg",),width: 50,),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        title: "Sent",
                        size: 22,
                        color: Color.fromRGBO(158, 92, 233, 1),
                        fontWeight: FontWeight.w800,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // const Positioned(
          //   left: 100,
          //   top: 600,
          //   child: SizedBox(
          //       height: 200,
          //       width: 200,
          //       child: Center(child: Image(image: AssetImage(number)))),
          // )
        ],
      ),
    );
  }
}
