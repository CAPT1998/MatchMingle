import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/block_user_provider.dart';
import '../../Provider/like_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/user_list_provider.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
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
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Text("No User Liked");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var item = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                profileProvider.userDetail(
                                    id: item["id"].toString(),
                                    token: authProvider.loginModel!.token,distance:"0.0",
                                    context: context);
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
                                          image:
                                              NetworkImage(item["profile_pic"]),
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
