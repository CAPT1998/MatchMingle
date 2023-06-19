import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Provider/like_provider.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Widgets/ChatInputWidget.dart';
import '../../Widgets/FlushbarWidget.dart';
import 'videoPlayer.dart';
import 'package:voice_message_package/voice_message_package.dart';

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
  var otheruserid = ""; // Create a variable outside the ListView.builder scope
  late GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _refreshKey,
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
            title: Column(
              children: [
                TextWidget(
                  title: widget.otherUserData["name"],
                  size: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                TextWidget(
                    title:
                        widget.otherUserData["online"] ? "Online" : "Offline",
                    size: 15,
                    fontWeight: widget.otherUserData["online"]
                        ? FontWeight.w500
                        : FontWeight.w600,
                    color: widget.otherUserData["online"]
                        ? Color.fromARGB(255, 5, 230, 5)
                        : Color.fromARGB(255, 226, 221, 221),
                    textAlign: TextAlign.left),
              ],
            ),
            actions: [
              //  IconButton(
              //   onPressed: () {},
              //  icon: const Icon(Icons.call),
              // ),
              //    IconButton(
              //      onPressed: () {},
              //      icon: Icon(Icons.videocam_outlined),
              //    ),
              IconButton(
                onPressed: () {
                  _actionButton(context, widget.otherUserData);
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitPumpingHeart(
                    color: Color(0XFF24ABE3),
                    size: 70.0,
                  ));
                }
                if (snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: Center(child: Text("No chat")),
                  );
                }

                if (snapshot.data != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          //reverse: true, // Scroll to the bottom
                          controller: _scrollController, // Add controller
                          itemCount: snapshot.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctx, index) {
                            var item = snapshot.data![index];
                            var item2 = snapshot
                                .data![0]; // Select the first item in the list

                            otheruserid = item2["id"].toString();
                            print(snapshot.data.toString());
                            print("Current user id is " +
                                authProvider.loginModel!.userData[0].id
                                    .toString() +
                                "other use id is " +
                                otheruserid);
                            return
                                // Text(
                                //     "${authProvider.loginModel!.userData[0].name}===>${ item["user_id"]}");
                                authProvider.loginModel!.userData[0].id
                                            .toString() ==
                                        item["id"].toString()
                                    ? _leftChat(
                                        context,
                                        item["text"],
                                        Colors.black,
                                        item["time"],
                                        item["image"],
                                        item["video"],
                                        item["audio"])
                                    : _RightChat(
                                        context,
                                        Colors.white,
                                        item["text"],
                                        item["time"],
                                        item["image"],
                                        item["video"],
                                        item["audio"]);
                          }),
                    ),
                  );
                }
                return const Center(
                    child: SpinKitPumpingHeart(
                  color: Color(0XFF24ABE3),
                  size: 70.0,
                ));
              },
            ),
          ),
          bottomSheet: ChatInputField(
            message: message,
            press: () async {
              String encodedText = message.text.replaceAllMapped(
                RegExp(
                  r'([\u{1F910}-\u{1F918}\u{1F980}-\u{1F984}\u{1F9C0}])',
                  unicode: true,
                ),
                (Match match) => '@@@${match.group(0)}',
              );
              List<int> encodedBytes = utf8.encode(encodedText);
              String encodedMessage = base64UrlEncode(encodedBytes);
              await chatProvider.sentSMS(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  widget.otherUserData["user_id"],
                  encodedMessage);
              print("message is " + encodedMessage);
              setState(() {
                _refreshKey = GlobalKey<RefreshIndicatorState>();
              });
              message.clear();
            },
            filePress: () {
              _fileButton(
                  context, authProvider, chatProvider, widget.otherUserData);
            },
            voicemessagecallback: (String x) {
              chatProvider.sendVoiceMessage(
                  context,
                  authProvider.loginModel!.token,
                  authProvider.loginModel!.userData[0].id,
                  widget.otherUserData["user_id"],
                  x);
              setState(() {
                _refreshKey = GlobalKey<RefreshIndicatorState>();
              });
            },
          ),
        );
      }),
    );
  }
}

Widget _buildChatContent(
    BuildContext context, color, sms, image, video, audio) {
  if (sms != null) {
    List<int> encodedBytes = base64Url.decode(sms);
    String encodedText = utf8.decode(encodedBytes);
    String decodedText = encodedText.replaceAll('@@@', '');
    return TextWidget(
      title: decodedText,
      size: 12,
      maxline: 3,
      fontWeight: FontWeight.w400,
      color: color,
    );
  } else if (image != null) {
    return Image.network(image);
  } else if (audio != null) {
    return VoiceMessage(
      audioSrc: audio,
      played: false, // To show played badge or not.
      me: true, // Set message side.
      onPlay: () {}, // Do something when voice played.
    );
  } else if (video != null) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VideoApp(url: video)),
        );
      },
      child: Text(video),
    );
  } else {
    return Container();
  }
}

Widget _RightChat(context, sms, color, time, image, video, audio) {
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
            child: _buildChatContent(context, sms, color, image, video, audio),
          ),
          const SizedBox(
            height: 10,
          ),
          TextWidget(
              title: "Received $time",
              size: 10,
              fontWeight: FontWeight.w400,
              color: greyColor)
        ],
      ),
    ),
  );
}

Widget _leftChat(context, sms, color, time, image, video, audio) {
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
            child: _buildChatContent(context, color, sms, image, video, audio),
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
              title: "Sent $time",
              size: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black),
          SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}

void _actionButton(BuildContext context, otherUserData) {
  LikeProvider likeProvider = Provider.of<LikeProvider>(context, listen: false);
  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Unmatch User',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () async {
              await likeProvider.disLikeUser(
                context,
                authProvider.loginModel!.token,
                authProvider.loginModel!.userData[0].id,
                otherUserData["user_id"],
              );
              // Navigator.pop(context);
              SuccessFlushbar(context, "Success", " Match removed");
            },
          ),
          ListTile(
            title: Text(
              'No Message',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              // Perform the desired action
            },
          ),
          ListTile(
            title: Text(
              'Cancel',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              // Handle 'Cancel' option tap
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

_fileButton(BuildContext context, authProvider, chatProvider, otherUserData) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              "Select",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            onTap: () async {
              chatProvider.sentImage(
                context,
                authProvider.loginModel!.token,
                authProvider.loginModel!.userData[0].id,
                otherUserData["user_id"],
                "Camera",
              );

              Navigator.pop(context);
              Navigator.pop(context);
                            SuccessFlushbar(context, "Success", "Media Sent");

            },
            leading: Icon(Icons.camera_alt),
            title: Text(
              "Take A picture",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(color: Colors.grey),
          ListTile(
            onTap: () {
              chatProvider.sentImage(
                context,
                authProvider.loginModel!.token,
                authProvider.loginModel!.userData[0].id,
                otherUserData["user_id"],
                "Gallery",
              );


              Navigator.pop(context);
              Navigator.pop(context);
                            SuccessFlushbar(context, "Success", "Media Sent");

            },
            leading: Icon(Icons.image),
            title: Text(
              "Choose From Gallery",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(color: Colors.grey),
          ListTile(
            onTap: () {
              chatProvider.sentImage(
                context,
                authProvider.loginModel!.token,
                authProvider.loginModel!.userData[0].id,
                otherUserData["user_id"],
                "Video",
              );

              Navigator.pop(context);
              Navigator.pop(context);
                            SuccessFlushbar(context, "Success", "Media Sent");

            },
            leading: Icon(Icons.video_library),
            title: Text(
              "Select a Video",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(color: Colors.grey),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.cancel),
            title: Text(
              "Cancel",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    ),
  );
}
