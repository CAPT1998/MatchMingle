import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(
            title: "Inbox",
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
          children: [
            SizedBox(
              height: 50,
            ),
            _chats(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            _chats(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            _chats(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            _chats(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            _chats(),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chats() {
  return ListTile(
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage("assets/img/img9.png"),
    ),
    title: TextWidget(
      title: "William",
      size: 16,
      fontWeight: FontWeight.w400,
    ),
    subtitle: TextWidget(
      title: "Thank you so much",
      size: 12,
      fontWeight: FontWeight.w400,
    ),
    trailing: Column(
      children: [
        TextWidget(
          title: "40 Sec Ago",
          size: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 10,
        ),
        CircleAvatar(
          radius: 12,
          backgroundColor: pinkColor,
          child: TextWidget(
            title: "12",
            size: 10,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
