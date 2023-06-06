import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/ChatScreen/AdminChat/PaymentScreen.dart';
import 'package:teen_jungle/Screens/ChatScreen/MessageChatScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/chat_provider.dart';
import 'AdminChat/AdminChatScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Consumer2<AuthProvider, ChatProvider>(
                builder: (context, authProvider, chatProvider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/img/logo.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Image.asset("assets/img/img11.png"),
                  //     Image.asset("assets/img/img12.png"),
                  //     Image.asset("assets/img/img13.png"),
                  //     Image.asset("assets/img/img14.png"),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                      title: "Chat",
                      size: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: chatProvider.getChatData(
                        authProvider.loginModel!.token,
                        authProvider.loginModel!.userData[0].id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      if (snapshot.data?.isEmpty) {
                        return const Text("No chat");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data != null) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctx, index) {
                              var item = snapshot.data![index];
                              // print("===<${snapshot.data}");
                              return InkWell(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: MessageChatScreen(
                                          otherUserData: item),
                                      withNavBar: false,
                                    );
                                  },
                                  child: _Chats(item));
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),

                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       PersistentNavBarNavigator.pushNewScreen(
                  //         context,
                  //         screen: AdminChatScreen(),
                  //         withNavBar: false,
                  //       );
                  //     },
                  //     child: _Chats()),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget _Chats(data) {
  return ListTile(
    leading: data["profile_pic"] !=
            "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
        ? CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(data["profile_pic"]),
          )
        : const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/img/img8.png"),
          ),
    title: TextWidget(
      title: data["name"].toString(),
      size: 16,
      fontWeight: FontWeight.w400,
    ),
    subtitle: TextWidget(
      title: "${data["sms"]["text"]}",
      size: 12,
      fontWeight: FontWeight.w400,
    ),
    trailing: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextWidget(
          title: "${data["sms"]["time"]}",
          size: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 10,
        ),
        Icon(
          data["online"] ? Icons.circle : null,
          weight: 1,
          color: Color.fromARGB(255, 5, 230, 5),
        )
      ],
    ),
  );
}
