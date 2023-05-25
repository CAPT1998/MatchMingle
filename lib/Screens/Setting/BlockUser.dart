import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/Setting/AccountScreen.dart';
import 'package:teen_jungle/Screens/Setting/BasicInfo.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/block_user_provider.dart';


class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

enum Sexuality { N, B, G, A, S }

class _BlockUserScreenState extends State<BlockUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, BlockUser>(
        builder: (context, authProvider, blockUser, child) {
      var userData = authProvider.loginModel!.userData[0];
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: TextWidget(
              title: "Block Users",
              size: 24,
              fontWeight: FontWeight.w400,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          body: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                future: blockUser.getBlockData(authProvider.loginModel!.token,
                    authProvider.loginModel!.userData[0].id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return const Text("No Block User");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextWidget(
                                            title: "Select Option",
                                            size: 24,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await blockUser.unblockUser(
                                                  context,
                                                  authProvider
                                                      .loginModel!.token,
                                                  userData.id,
                                                  item["id"]);
                                              Future.delayed(Duration.zero, () {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: TextWidget(
                                              title: "Unblock",
                                              size: 24,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: TextWidget(
                                              title: "Cancel",
                                              size: 24,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(item["profile_pic"].toString()),
                          ),
                          title: TextWidget(
                            title: item["name"].toString(),
                            size: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
