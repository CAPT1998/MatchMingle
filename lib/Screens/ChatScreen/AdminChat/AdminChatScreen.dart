import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../../Widgets/ChatInputWidget.dart';
import 'PaymentScreen.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          // leading: Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage("assets/img/img7.png"),
          //   ),
          // ),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/img/img7.png"),
                ),
              ),
              TextWidget(
                title: "Admin",
                size: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.videocam_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                _RightChat(),
                SizedBox(
                  height: 20,
                ),
                _RightChat(),
                SizedBox(
                  height: 20,
                ),
                _leftChat(),
                SizedBox(
                  height: 20,
                ),
                _RightChat(),
                SizedBox(
                  height: 50,
                ),
               ],
            ),
          ),
        ),
        bottomSheet: ChatInputField(
          message: message,
          press: () {},
          filePress: () {
            _fileButton(context);
          },
        ),
      ),
    );
  }
}

Widget _RightChat() {
  return Align(
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: width * 0.6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: TextWidget(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
            size: 12,
            maxline: 3,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
            title: "Sent at 03:03 PM",
            size: 10,
            fontWeight: FontWeight.w400,
            color: greyColor)
      ],
    ),
  );
}

Widget _leftChat() {
  return Align(
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0XFFE6E6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: TextWidget(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
            size: 12,
            maxline: 3,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
            title: "Sent at 03:03 PM",
            size: 10,
            fontWeight: FontWeight.w400,
            color: greyColor)
      ],
    ),
  );
}

_actionButton(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title: "Select Option",
            size: 30,
          ),
          SizedBox(
            height: 20,
          ),
          TextWidget(
            title: "Un Match User",
            size: 30,
            fontWeight: FontWeight.w400,
          ),
          TextWidget(
            title: "Block User",
            size: 30,
            fontWeight: FontWeight.w400,
          ),
          TextWidget(
            title: "Cancle",
            size: 30,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    ),
  );
}

_fileButton(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title: "Select",
            size: 30,
          ),
          SizedBox(
            height: 20,
          ),
          TextWidget(
            title: "Take A picture",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Choose Photo From Gallery",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Select Vedio",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Cancle",
            size: 20,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    ),
  );
}
