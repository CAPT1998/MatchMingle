import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/block_user_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Provider/like_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/user_list_provider.dart';
import '../../Widgets/TextWidget.dart';
import 'BottomButtonRow.dart';
import 'ExampleCard.dart';
import 'FilterScreen.dart';
import 'Overlay_Card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthProvider auth = AuthProvider();
  RangeValues ageValue = RangeValues(28, 34);
  int distence = 10;
  TextEditingController locationCTRL = TextEditingController();
  var gander = "Male";
  var show = true;
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      setState(() {
        show = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Image.asset(
          "assets/img/logo.png",
          height: 60,
        ),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                      TextWidget(
                        title: "Filter",
                        size: 26,
                        fontWeight: FontWeight.w800,
                      ),
                      IconButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: FilterScreen(
                              distance: distence.toString(),
                              age: ageValue.start.toString(),
                              gender: gander.toString(),
                              location: locationCTRL.text,
                            ),
                            withNavBar: false,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen(
                                        distance: distence.toString(),
                                        age: ageValue.start.toString(),
                                        gender: gander.toString(),
                                        location: locationCTRL.text,
                                      )));
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: TextWidget(
                                title: "Location",
                                size: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextField(
                                controller: locationCTRL,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'People Nearby',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    title: "Distance",
                                    size: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  TextWidget(
                                    title: "1000",
                                    size: 16,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ],
                              ),
                            ),
                            Slider(
                              activeColor: Color(0xFFE00088),
                              inactiveColor: Colors.red[300],
                              value: distence.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  distence = value.toInt();
                                });
                              },
                              min: 0,
                              max: 1000,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: TextWidget(
                                title: "Gender",
                                size: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      gander = "Male";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: gander == "Male"
                                              ? Colors.blue
                                              : Colors.black,
                                        )),
                                    height: 40,
                                    width: 70,
                                    child: Center(
                                      child: TextWidget(
                                        title: "Male",
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      gander = "Female";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: gander == "Female"
                                              ? Colors.blue
                                              : Colors.black,
                                        )),
                                    height: 40,
                                    width: 70,
                                    child: Center(
                                      child: TextWidget(
                                        title: "Female",
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      gander = "Both";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: gander == "Both"
                                              ? Colors.blue
                                              : Colors.black,
                                        )),
                                    height: 40,
                                    width: 70,
                                    child: Center(
                                      child: TextWidget(
                                        title: "Both",
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: TextWidget(
                                    title: "Age",
                                    size: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextWidget(
                                  title: "18-50",
                                  size: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ],
                            ),
                            RangeSlider(
                                activeColor: Color(0xFFE00088),
                                inactiveColor: Colors.red[300],
                                min: 18,
                                max: 50,
                                values: ageValue,
                                onChanged: (values) {
                                  setState(() {
                                    ageValue = values;
                                  });
                                }),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
            child: Image.asset(
              "assets/img/filterVector.png",
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Consumer3<AuthProvider, UserListProvider, ProfileProvider>(
            builder: (context, authProvider, userListProvider, profileProvider,
                child) {
          return Stack(
            children: [
              FutureBuilder<List<dynamic>>(
                future: userListProvider.getNerebyUsersList(
                    authProvider.loginModel!.token,
                    authProvider.loginModel!.userData[0].id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(child: Text("No data found"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return HomeCard(
                    snapshot: snapshot,
                  );
                },
              ),
              show
                  ? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Center()
            ],
          );
        }),
      ),
    );
  }
}

class HomeCard extends StatefulWidget {
  final AsyncSnapshot<List> snapshot;
  const HomeCard({super.key, required this.snapshot});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  SwipableStackController? _controller;
  TextEditingController smsCTRL = TextEditingController();

  void _listenController() => setState(() {});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   auth = Provider.of<AuthProvider>(context, listen: false);
    //   userList = Provider.of<UserListProvider>(context, listen: false);
    //   print("initState=====>");
    //   userList.getNerebyUsersList(
    //       auth.loginModel!.token, auth.loginModel!.userData[0].id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<AuthProvider, LikeProvider, ProfileProvider, BlockUser,
            ChatProvider>(
        builder: (context, authProvider, likeProvider, profileProvider,
            blockUser, chatProvider, child) {
      return Stack(
        children: [
          // const Center(child: CircularProgressIndicator()),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SwipableStack(
                detectableSwipeDirections: const {
                  SwipeDirection.right,
                  SwipeDirection.left,
                  SwipeDirection.up,
                },
                itemCount: widget.snapshot.data!.length,
                controller: _controller,
                stackClipBehaviour: Clip.none,
                onSwipeCompleted: (index, direction) {
                  print('===========$index, $direction');
                  if (direction == SwipeDirection.right) {
                    // provider.addfriend(index, true, false);
                    // provider.limituseraccess();
                    likeProvider.LikeUser(
                        context,
                        authProvider.loginModel!.token,
                        authProvider.loginModel!.userData[0].id,
                        widget.snapshot.data![index]["id"]);
                  }
                  if (direction == SwipeDirection.left) {
                    // print(index);
                    // provider.dislikefriend(
                    //   index,
                    // );
                    // provider.limituseraccess();
                    // blockUser.blockUser(
                    //     context,
                    //     authProvider.loginModel!.token,
                    //     authProvider.loginModel!.userData[0].id,
                    //     widget.snapshot.data![index]["id"]);
                  }
                  if (direction == SwipeDirection.up) {
                    print("===>up");
                    // print(index);
                    // provider.limituseraccess();
                  }
                  if (direction == SwipeDirection.down) {
                    print("===>down");
                    showDialog(
                      context: context,
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
                            (BuildContext context, StateSetter setState) {
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
                                chatProvider.sentSMS(
                                    context,
                                    authProvider.loginModel!.token,
                                    authProvider.loginModel!.userData[0].id,
                                    widget.snapshot.data![index]["id"],
                                    smsCTRL.text);
                              },
                              child: Text("Sent"))
                        ],
                      ),
                    );

                    // print(index);
                    // provider.limituseraccess();
                  }
                },
                horizontalSwipeThreshold: 0.8,
                verticalSwipeThreshold: 0.8,
                builder: (context, properties) {
                  // print(properties.index);
                  var item = widget.snapshot.data![properties.index];

                  return Stack(
                    children: [
                      ExampleCard(
                        index: properties.index,
                        name: item["name"],
                        location: "Lahore,pakistan",
                        assetPath: item["profile_pic_url"] ?? "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder",
                        onlineStatus: item["online"]?"Online":"Offline",
                        seeMore: () {
                          profileProvider.userDetail(
                              id: widget.snapshot.data![properties.index]["id"]
                                  .toString(),
                              token: authProvider.loginModel!.token,
                              distance: widget.snapshot.data![properties.index]
                                  ["distance"],
                              context: context);
                        },
                      ),
                      if (properties.stackIndex == 0 &&
                          properties.direction != null)
                        CardOverlay(
                          swipeProgress: properties.swipeProgress,
                          direction: properties.direction!,
                        )
                    ],
                  );
                },
              ),
            ),
          ),
          BottomButtonsRow(
            onSwipe: (direction) {
              _controller!.next(swipeDirection: direction);
            },
            onRewindTap: _controller!.rewind,
            canRewind: _controller!.canRewind,
          ),
        ],
      );
    });
    ;
  }
}
