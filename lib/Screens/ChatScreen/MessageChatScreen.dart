import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Widgets/ChatInputWidget.dart';
import 'videoPlayer.dart';

class MessageChatScreen extends StatefulWidget {
  final Map otherUserData;
  const MessageChatScreen({
    super.key,
    required this.otherUserData,
  });

  @override
  State<MessageChatScreen> createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<AuthProvider, ChatProvider>(
          builder: (context, authProvider, chatProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            leading: Padding(
              padding: EdgeInsets.all(5.0),
              child: widget.otherUserData["profile_pic"] !=
                      "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(widget.otherUserData["profile_pic"]),
                    )
                  : const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/img/img8.png"),
                    ),
            ),
            title: TextWidget(
              title: widget.otherUserData["name"],
              size: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam_outlined),
              ),
              IconButton(
                onPressed: () {
                  _actionButton(context);
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: FutureBuilder<List<dynamic>>(
              future: chatProvider.getMessageData(
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  widget.otherUserData["thread_id"]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: Center(child: Text("No chat")),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctx, index) {
                            var item = snapshot.data![index];
                            return
                                // Text(
                                //     "${authProvider.loginModel!.userData[0].name}===>${ item["user_id"]}");
                                authProvider.loginModel!.userData[0].id
                                            .toString() ==
                                        item["user_id"].toString()
                                    ? _leftChat(item["text"], item["time"],
                                        item["image"], item["video"])
                                    : _RightChat(context,item["text"], item["time"],
                                        item["image"], item["video"]);
                          }),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          bottomSheet: ChatInputField(
            message: message,
            press: () {
              chatProvider.sentSMS(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  widget.otherUserData["user_id"],
                  message.text);
              message.clear();
            },
            filePress: () {
              _fileButton(
                  context, authProvider, chatProvider, widget.otherUserData);
            },
          ),
        );
      }),
    );
  }
}

Widget _RightChat(context ,sms, time, image, video) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: width * 0.6,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: appColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: sms != null
                ? TextWidget(
                    title: sms,
                    size: 12,
                    maxline: 3,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  )
                : image != null
                    ? Image.network(image)
                    : InkWell(
                        onTap: () {  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>  VideoApp(url: video,)));},
                        child: Text(video),
                      ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextWidget(
              title: "Sent at $time",
              size: 10,
              fontWeight: FontWeight.w400,
              color: greyColor)
        ],
      ),
    ),
  );
}

Widget _leftChat(sms, time, image, video) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
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
              title: sms,
              size: 12,
              maxline: 3,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
              title: "Sent at $time",
              size: 10,
              fontWeight: FontWeight.w400,
              color: greyColor)
        ],
      ),
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
            title: "No Message",
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

_fileButton(BuildContext context, authProvider, chatProvider, otherUserData) {
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
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              chatProvider.sentImage(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  otherUserData["user_id"],
                  "Camera");
            },
            child: TextWidget(
              title: "Take A picture",
              size: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              // print(
              //     '===>${authProvider.loginModel!.token}===>${authProvider.loginModel!.userData[0].id}===>${otherUserData["user_id"]}');
              chatProvider.sentImage(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  otherUserData["user_id"],
                  "Gallery");
            },
            child: TextWidget(
              title: "Choose Photo From Gallery",
              size: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              chatProvider.sentImage(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  otherUserData["user_id"],
                  "Video");
            },
            child: TextWidget(
              title: "Select Vedio",
              size: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
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
