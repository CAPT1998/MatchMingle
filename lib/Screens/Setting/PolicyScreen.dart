import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Widgets/TextWidget.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: TextWidget(
          title: "Privacy Policay",
          size: 24,
          fontWeight: FontWeight.w400,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: Image(image: AssetImage("assets/img/group_pic.jpg"))),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              """At teen_jungle, accessible from www.teen_jungle.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by teen_jungle and how we use it.

If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.

This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in teen_jungle. This policy is not applicable to any information collected offline or via channels other than this website.""",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
