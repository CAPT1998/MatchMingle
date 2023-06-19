import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/block_user_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Provider/like_provider.dart';
import '../../Provider/limituseraccess_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/user_list_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';
import '../ChatScreen/ChatScreens.dart';
import '../HomeScreens/filteruserprofiles.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  bool _isLoading = false;
  TextEditingController smsCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChatProvider chatdata = Provider.of<ChatProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Consumer5<AuthProvider, UserListProvider, ProfileProvider,
                LikeProvider, BlockUser>(
            builder: (context, authProvider, userListProvider, profileProvider,
                likeProvider, blockUser, child) {
          var userData = authProvider.loginModel!.userData[0];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/likes.png",
                        height: 100,
                      ),
                    ],
                  ),
                  TextWidget(
                    title: "Your Likes List",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: userListProvider.getLikedUsersList(
                        authProvider.loginModel!.token,
                        authProvider.loginModel!.userData[0].id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: SpinKitPumpingHeart(
                          color: Color.fromARGB(255, 243, 158, 211),
                          size: 70.0,
                        ));
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      if (snapshot.data!.isEmpty) {
                        return const Text("No User Liked");
                      }

                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var item = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                //   profileProvider.likeduserDetail(
                                //       id: item["id"].toString(),
                                //       token: authProvider.loginModel!.token,
                                //      distance: "0.0",
                                //     context: context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Filteruserprofiles(
                                      id: item['id'].toString(),
                                      token: authProvider.loginModel!.token,
                                      index: 1,
                                      name: item['name'],
                                      location: "",
                                      assetPath: item["profile_pic"] ??
                                          "https://19jungle.pakwexpo.com/api/auth/updateProfile",
                                      onlineStatus: "offline",
                                      seeMore: () {
                                        profileProvider.userDetail(
                                            id: item["name"].toString(),
                                            token:
                                                authProvider.loginModel!.token,
                                            distance: "",
                                            context: context);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  image: item["profile_pic"] ==
                                          "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              "assets/img/profilerectangle.png"),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(
                                              item["profile_pic".toString()]),
                                          fit: BoxFit.cover),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                blockUser.blockUser(
                                                    context,
                                                    authProvider
                                                        .loginModel!.token,
                                                    authProvider.loginModel!
                                                        .userData[0].id,
                                                    item["id"]);
                                              },
                                              icon: const Icon(Icons.close)),
                                          Container(
                                            height: 30,
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                likeProvider.disLikeUser(
                                                    context,
                                                    authProvider
                                                        .loginModel!.token,
                                                    authProvider.loginModel!
                                                        .userData[0].id,
                                                    item["id"]);
                                              },
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.pinkAccent,
                                              )),
                                          Container(
                                            height: 30,
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SendMessageScreen(
                                                      token: authProvider
                                                          .loginModel!.token,
                                                      senderId: authProvider
                                                          .loginModel!
                                                          .userData[0]
                                                          .id,
                                                      receiverId:
                                                          item["id"].toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.chat_bubble_outline_sharp,
                                                color: Color.fromARGB(
                                                    255, 206, 48, 74),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SendMessageScreen extends StatefulWidget {
  final String token;
  final int senderId;
  final dynamic receiverId;

  const SendMessageScreen({
    required this.token,
    required this.senderId,
    required this.receiverId,
  });

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  TextEditingController smsCTRL = TextEditingController();
  bool _isSending = false;

  Future<void> _sendMessage() async {
    setState(() {
      _isSending = true;
    });
    ChatProvider chatdata = Provider.of<ChatProvider>(context, listen: false);
    LimitUserAccessProvider limit =
        Provider.of<LimitUserAccessProvider>(context, listen: false);

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    final planid = await limit.getUserPlan(
      context,
      authProvider.loginModel!.token,
      authProvider.loginModel!.userData[0].id,
    );
    final connections = await limit.getconnectionscount(
        authProvider.loginModel!.token,
        authProvider.loginModel!.userData[0].id);

    if (connections == "5" && planid == '0') {
      Navigator.of(context).pop();

      ErrorFlushbar(context, "Limit Reached", "Upgrade Your plan");
      return;
    } else if (connections == "5" && planid == '1') {
      await chatdata.sentSMS(
        context,
        widget.token,
        widget.senderId,
        widget.receiverId,
        smsCTRL.text,
      );

      PersistentNavBarNavigator.pushNewScreen(context, screen: ChatScreen());
      Navigator.of(context).pop();
      SuccessFlushbar(context, "Success", "Message Sent");
    } else if (connections == "10" && planid == '1') {
      Navigator.of(context).pop();

      ErrorFlushbar(context, "Limit Reached", "Upgrade Your plan");
      return;
    }

    String encodedText = smsCTRL.text.replaceAllMapped(
      RegExp(
        r'([\u{1F910}-\u{1F918}\u{1F980}-\u{1F984}\u{1F9C0}])',
        unicode: true,
      ),
      (Match match) => '@@@${match.group(0)}',
    );
    List<int> encodedBytes = utf8.encode(encodedText);
    String encodedMessage = base64UrlEncode(encodedBytes);
    await chatdata.sentSMS(
      context,
      widget.token,
      widget.senderId,
      widget.receiverId,
      encodedMessage,
    );

    Navigator.of(context).pop();
    SuccessFlushbar(context, "", "Message Sent");
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: ChatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sent Message",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: smsCTRL,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your message...',
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendMessage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: _isSending
                    ? SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
