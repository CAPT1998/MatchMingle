// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../../Widgets/TextWidget.dart';
import 'package:http/http.dart' as http;

import '../BottomNavigationBar/PersistanceNavigationBar.dart';
import '../ChatScreen/ChatScreens.dart';

likeuserdialog(context, userData, distance) {
  TextEditingController smsCTRL = TextEditingController();
  ChatProvider chatdata = Provider.of<ChatProvider>(context, listen: false);
  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (ctx2) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      // clipBehavior: Clip.antiAliasWithSaveLayer,

      content: StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: userData["profile_pic"] ==
                              "http://jungle19.pakwexpo.com/public/images/updateProfile"
                          // "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                          ? const DecorationImage(
                              image:
                                  AssetImage("assets/img/profilerectangle.png"),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: NetworkImage(userData["profile_pic"]),
                              fit: BoxFit.scaleDown),
                    ),
                  ),

                  userData["userQuestion"].length != 0
                      ? TextWidget(
                          title: "About Me",
                          size: 20,
                          fontWeight: FontWeight.w400,
                        )
                      : Container(),
                  const SizedBox(
                    height: 5,
                  ),
                  userData["userQuestion"].length != 0
                      ? TextWidget(
                          title: "${userData["userQuestion"][0]["question_1"]}",
                          size: 16,
                          fontWeight: FontWeight.w200,
                        )
                      : Container(),
                  TextWidget(
                    title: "Current Location",
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  TextWidget(
                    title: "${distance} miles away",
                    size: 16,
                    fontWeight: FontWeight.w200,
                  ),
                  userData["userQuestion"].length != 0
                      ? Row(
                          children: [
                            profileCard(
                                "${userData["userQuestion"][0]["question_2"]}",
                                Icons.home,
                                180.0),
                            // profileCard(
                            //     "${userData["userQuestion"][0]["question_2"]}",
                            //     Icons.favorite,
                            //     90.0)
                          ],
                        )
                      : Container(),
                  // userData["userQuestion"].length != 0
                  //     ? Row(
                  //         children: [
                  //           profileCard(
                  //               "${userData["userQuestion"][0]["question_3"]}",
                  //               Icons.smoke_free,
                  //               180.0),
                  //           profileCard(
                  //               "${userData["userQuestion"][0]["question_4"]}",
                  //               Icons.emoji_emotions,
                  //               90.0)
                  //         ],
                  //       )
                  //     : Container(),
                  // userData["userQuestion"].length != 0
                  //     ? Row(
                  //         children: [
                  //           profileCard(
                  //               "${userData["userQuestion"][0]["question_5"]}",
                  //               Icons.smoke_free,
                  //               180.0),
                  //           profileCard(
                  //               "${userData["userQuestion"][0]["question_6"]}",
                  //               Icons.emoji_emotions,
                  //               90.0)
                  //         ],
                  //       )
                  //     : Container(),
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       child: userData["userQuestion"].length != 0
                  //           ? Row(
                  //               children: [
                  //                 profileCard(
                  //                     "${userData["userQuestion"][0]["question_7"]}",
                  //                     Icons.local_drink,
                  //                     100.0),
                  //                 const SizedBox(
                  //                   height: 80,
                  //                 ),
                  //               ],
                  //             )
                  //           : Container(),
                  //     ),
                  //     Positioned(
                  //       right: 20,
                  //       bottom: 10,
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(50),
                  //           color: Colors.grey[200],
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             icon: const Icon(
                  //               Icons.close,
                  //             )),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          //  key: alertDialogKey,

                          builder: (ctx) => AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  title: "Sent Message",
                                  size: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),

                            content: StatefulBuilder(builder:
                                (BuildContext context2, StateSetter setState) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: smsCTRL,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type some...',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              const Spacer(),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.of(ctx).pop();

                                    await chatdata.sentSMS(
                                        context,
                                        authProvider.loginModel!.token,
                                        authProvider.loginModel!.userData[0].id,
                                        userData["id"],
                                        smsCTRL.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavigationScreen()));
                                    SuccessFlushbar(
                                        context, "", "Message Sent");
                                  },
                                  child: const Text("Sent"))
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE00088),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 58.0,
                                right: 58.0,
                                top: 12.0,
                                bottom: 12.0,
                              ),
                              child: Text("Start Chat"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}

Widget profileCard(title, icon, width) {
  return SingleChildScrollView(
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        width: width,
        // height: 700,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: width - 30,
                  child: TextWidget(
                    title: title,
                    size: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
