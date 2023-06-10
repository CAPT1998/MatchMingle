import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/TextWidget.dart';

seeProfile(context, _userData) {
  var questionData = _userData.userQuestion;
  print('==>${questionData}');
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          height: 460,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                questionData.length != 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 150,
                            width: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: _userData.profilePic ==
                                      // "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                                      "https://19jungle.pakwexpo.com/api/auth/showProfileImage"
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          "assets/img/profilerectangle.png"),
                                      fit: BoxFit.scaleDown)
                                  : DecorationImage(
                                      image: NetworkImage(_userData.profilePic),
                                      fit: BoxFit.scaleDown),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextWidget(
                            title: "About Me",
                            size: 20,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(height: 5),
                          TextWidget(
                            title: "${questionData[0]["question_1"]}",
                            overflow: TextOverflow.ellipsis,
                            size: 16,
                            fontWeight: FontWeight.w200,
                          ),
                          SizedBox(height: 5),
                          questionData.length != 0
                              ? Row(
                                  children: [
                                    profileCard(
                                        "${questionData[0]["question_3"]}",
                                        Icons.home,
                                        180.0),
                                    profileCard(
                                        "${questionData[0]["question_2"]}",
                                        Icons.favorite,
                                        90.0)
                                  ],
                                )
                              : Container(),
                          questionData.length != 0
                              ? Row(
                                  children: [
                                    profileCard(
                                        "${questionData[0]["question_5"]}",
                                        Icons.smoke_free,
                                        180.0),
                                    profileCard(
                                        "${questionData[0]["question_6"]}",
                                        Icons.emoji_emotions,
                                        90.0)
                                  ],
                                )
                              : Container(),
                          Stack(
                            children: [
                              SizedBox(
                                child: questionData.length != 0
                                    ? Row(
                                        children: [
                                          profileCard(
                                              "${questionData[0]["question_7"]}",
                                              Icons.local_drink,
                                              100.0),
                                          const SizedBox(
                                            height: 80,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              Positioned(
                                right: 20,
                                bottom: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey[200],
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                const Divider(
                  color: Colors.black,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      final uri = Uri.parse(_userData.profilePic);
                      final response = await http.get(uri);
                      final bytes = response.bodyBytes;
                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);
                      Share.shareFiles(['${path}'],
                          text:
                              'Hi! i am ${_userData.name} install the 19jungle and visit my profile');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE00088),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 58.0,
                              right: 58.0,
                              top: 12.0,
                              bottom: 12.0,
                            ),
                            child: Text("Share this profile"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}

Widget profileCard(title, icon, width) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[200],
    ),
    width: width,
    child: Container(
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: SizedBox(
              width: width - 40,
              child: TextWidget(
                overflow: TextOverflow.ellipsis,
                title: title,
                size: 12,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
