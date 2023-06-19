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
import 'ExampleCard.dart';
import 'filteruserprofiles.dart';

class FilterScreen extends StatefulWidget {
  final String location;
  final String distance;
  final String gender;
  final String age;

  const FilterScreen({
    Key? key,
    required this.location,
    required this.distance,
    required this.gender,
    required this.age,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var show = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        show = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer3<AuthProvider, UserListProvider, ProfileProvider>(
          builder: (context, authProvider, userListProvider, profileProvider,
              child) {
            var userData = authProvider.loginModel!.userData[0];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Image.asset(
                        "assets/img/logo.png",
                        height: 60,
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: [
                        FutureBuilder<List<dynamic>>(
                          future: userListProvider.getFilterUsersList(
                            authProvider.loginModel!.token,
                            authProvider.loginModel!.userData[0].id,
                            widget.distance,
                            widget.gender,
                            widget.age,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SpinKitPumpingHeart(
                                  color: Color(0XFFE90691),
                                  size: 70.0,
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: SpinKitPumpingHeart(
                                  color: Color(0XFFE90691),
                                  size: 70.0,
                                ),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "No Users Found",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "💔",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (snapshot.data != null) {
                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 100,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  var item = snapshot.data![index];
                                  return CardWidget(
                                    snapshot: snapshot,
                                    authProvider: authProvider,
                                    index: index,
                                    item: item,
                                    profileProvider: profileProvider,
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: Text('No user Found'),
                            );
                          },
                        ),
                        if (show)
                          Container(
                            color: Colors.white,
                            height: 600,
                            width: 400,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Map item;
  final int index;
  final AsyncSnapshot<List> snapshot;

  final ProfileProvider profileProvider;
  final AuthProvider authProvider;

  const CardWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.snapshot,
    required this.profileProvider,
    required this.authProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: index % 3 == 1 ? 27.0 : 0.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Filteruserprofiles  (
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
            ),
          );
        },
        child: Column(
          children: [
            item["profile_pic_url"] !=
                    "http://jungle19.pakwexpo.com/public/images/updateProfile"
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(item["profile_pic_url"]),
                  )
                : const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/img/img8.png"),
                  ),
            const SizedBox(height: 10),
            TextWidget(
              title: item["name"],
              size: 20,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
