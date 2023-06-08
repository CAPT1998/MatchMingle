import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';
import 'Recordingbutton.dart';

class ChatInputField extends StatelessWidget {
  final dynamic message;
  final void Function() press;
    final void Function(String) voicemessagecallback;

  dynamic filePress;
  ChatInputField(
      {Key? key,
      required this.message,
            required this.voicemessagecallback,

      required this.press,
      required this.filePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0 / 2,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: appColor.withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 20.0 * 0.01,
                  // ),
                  decoration: BoxDecoration(
                    color: appColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      SizedBox(width: 20.0 / 4),
                      Expanded(
                        child: TextField(
                          controller: message,
                          decoration: InputDecoration(
                            hintText: "Type message",
                            hintStyle: TextStyle(fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      //   child:
                      IconButton(
                        onPressed: filePress,
                        icon: Icon(
                          CupertinoIcons.folder,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),
                      // ),
                      // SizedBox(width: 10),
                      /*   IconButton(
                        onPressed: () {
                          
                        },
                        icon: Icon(Icons.mic),
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      */
                      RecordButton(recordingFinishedCallback: (String x) { 
                          voicemessagecallback(x);
                       },
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                  color: appColor.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: press,
                    icon: Icon(Icons.send_sharp, color: appColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
