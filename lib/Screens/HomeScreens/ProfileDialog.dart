import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Widgets/TextWidget.dart';
import 'package:http/http.dart' as http;

profileDialog(context, userData, distance) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
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
                  SizedBox(
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
                        final uri = Uri.parse(userData["profile_pic"]);
                        final response = await http.get(uri);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        Share.shareFiles(['${path}'],
                            text:
                                'Hi! i am ${userData["name"]} install the 19jungle and visit my profile');
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
