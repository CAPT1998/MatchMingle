import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/user_list_provider.dart';
import 'filteruserprofiles.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  var show = true;
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      setState(() {
        show = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
        body: Consumer3<AuthProvider, UserListProvider, ProfileProvider>(
            builder: (context, authProvider, userListProvider, profileProvider,
                child) {
          var userData = authProvider.loginModel?.userData[0];
          return Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  Opacity(
                          //       opacity: 0,
                          //       child: Image.asset(
                          //         "assets/img/logo.png",
                          //          height: 60,
                          //        )),
                          const Spacer(),
                          Image.asset(
                            "assets/img/logo.png",
                            height: 60,
                          ),
                          const Spacer(),

                          //     IconButton(
                          //       onPressed: () {},
                          //       icon: const Icon(Icons.compare_arrows_rounded))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          FutureBuilder<List<dynamic>>(
                            future: userListProvider.getNerebyUsersList(
                              context,
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: SpinKitPumpingHeart(
                                  color: Color(0XFFE90691),
                                  size: 70.0,
                                ));
                              }

                              if (snapshot.hasError) {
                                return Text("Error${snapshot.error}");
                              }

                              if (snapshot.data!.isEmpty) {
                                return const Text("No User");
                              }

                              if (snapshot.data != null) {
                                return SingleChildScrollView(
                                  child:
                                      // Text(snapshot.data.toString())
                                      GridView.builder(
                                          shrinkWrap: true,
                                          controller: _scrollController,

                                          // physics: AlwaysScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 100,
                                                  childAspectRatio: 2 / 3,
                                                  crossAxisSpacing: 20,
                                                  mainAxisSpacing: 20),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            var item = snapshot.data![index];
                                            return CardWidget(
                                              authProvider: authProvider,
                                              index: index,
                                              item: item,
                                              profileProvider: profileProvider,
                                            );
                                          }),
                                );
                              }
                              return const Center(
                                  child: SpinKitPumpingHeart(
                                color: Color(0XFFE90691),
                                size: 70.0,
                              ));
                            },
                          ),
                          //   show
                          //       ? Container(
                          //           color: Colors.white,
                          //           height: 600,
                          //           width: 400,
                          //         )
                          //       : Center()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Map item;
  final int index;
  final ProfileProvider profileProvider;
  final AuthProvider authProvider;

  const CardWidget(
      {super.key,
      required this.item,
      required this.index,
      required this.profileProvider,
      required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          // bottom:
          //     index % 3 == 0 ||index % 3 == 2 ? 27.0 : 0.0,
          top: index % 3 == 1 ? 27.0 : 0.0),
      child: InkWell(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: Filteruserprofiles(
              id: item['id'].toString(),
              token: authProvider.loginModel!.token,
              index: 1,
              name: item['name'],
              location: "asda",
              assetPath: item["profile_pic_url"] ??
                  "https://19jungle.pakwexpo.com/api/auth/updateProfile",
              onlineStatus: "offline",
              seeMore: () {
                profileProvider.userDetail(
                    id: item["name"].toString(),
                    token: authProvider.loginModel!.token,
                    distance: "",
                    context: context);
              },
            ),
            withNavBar: false,
          );
        },
        child: Column(
          children: [
            item["profile_pic_url"] !=
                        "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder" &&
                    item["profile_pic_url"] != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(item["profile_pic_url"]),
                  )
                : const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/img/img8.png"),
                  ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              title: item["name"],
              size: 20,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
