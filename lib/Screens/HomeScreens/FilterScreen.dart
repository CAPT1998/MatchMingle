import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/HomeScreens/HomeScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/user_list_provider.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';

class FilterScreen extends StatefulWidget {
  final String location;
  final String distance;
  final String gender;
  final String age;
  const FilterScreen(
      {super.key,
      required this.location,
      required this.distance,
      required this.gender,
      required this.age});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var show = true;
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      setState(() {
        show = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer3<AuthProvider, UserListProvider, ProfileProvider>(
            builder: (context, authProvider, userListProvider, profileProvider,
                child) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                          opacity: 0,
                          child: Image.asset(
                            "assets/img/logo.png",
                            height: 60,
                          )),
                      Image.asset(
                        "assets/img/logo.png",
                        height: 60,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.compare_arrows_rounded))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      FutureBuilder<List<dynamic>>(
                        future: userListProvider.getFilterUsersList(
                            authProvider.loginModel!.token,
                            authProvider.loginModel!.userData[0].id,
                            widget.distance,
                            widget.gender,
                            widget.age),
                        builder: (context, snapshot) {
                          print('snapshot data is' + snapshot.data.toString());
                          if (snapshot.hasError) {
                            // return Text("${snapshot.error}");
                            return const Center(
                                child: SpinKitPumpingHeart(
                              color: Color(0XFFE90691),
                              size: 70.0,
                            ));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: SpinKitPumpingHeart(
                              color: Color(0XFFE90691),
                              size: 70.0,
                            ));
                          }

                          if (snapshot.data != null) {
                            return SingleChildScrollView(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 100,
                                          childAspectRatio: 2 / 3,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext ctx, index) {
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
                            child: Text('No user Found'),
                          );
                        },
                      ),
                      show
                          ? Container(
                              color: Colors.white,
                              height: 600,
                              width: 400,
                            )
                          : Center()
                    ],
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
          profileProvider.userDetail(
              id: item["id"].toString(),
              token: authProvider.loginModel!.token,
              distance: item['distance'],
              context: context);
        },
        child: Column(
          children: [
            item["profile_pic_url"] !=
                    "http://jungle19.pakwexpo.com/public/images/updateProfile"
                // "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
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
