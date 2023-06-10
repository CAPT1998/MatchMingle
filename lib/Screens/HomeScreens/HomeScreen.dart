// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Provider/auth_provider.dart';
import '../../Provider/block_user_provider.dart';
import '../../Provider/chat_provider.dart';
import '../../Provider/like_provider.dart';
import '../../Provider/limituseraccess_provider.dart';
import '../../Provider/profile_provider.dart';
import '../../Provider/question_provider.dart';
import '../../Provider/user_list_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../ChatScreen/ChatScreens.dart';
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
  GlobalKey<State<StatefulWidget>> alertDialogKey = GlobalKey();

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
    super.initState();
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
                            Navigator.of(ctx).pop();
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
                          Navigator.of(ctx).pop();

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
                          /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen(
                                        distance: distence.toString(),
                                        age: ageValue.start.toString(),
                                        gender: gander.toString(),
                                        location: locationCTRL.text,
                                      )));
                                      */
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
                                    title: distence.toString(),
                                    size: 16,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ],
                              ),
                            ),
                            Slider(
                              activeColor: const Color(0xFFE00088),
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
                                  title:
                                      '${ageValue.start.toInt()} - ${ageValue.end.toInt()}',
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
              FutureBuilder(
                future: userListProvider.getNerebyUsersList(
                    authProvider.loginModel?.token,
                    authProvider.loginModel?.userData[0].id),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: SpinKitPumpingHeart(
                      color: Color(0XFFE90691),
                      size: 70.0,
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: SpinKitPumpingHeart(
                      color: Color(0XFFE90691),
                      size: 70.0,
                    ));
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
  int currentCardIndex = 0;
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
    return Consumer6<AuthProvider, LikeProvider, QuestionProvider,
            ProfileProvider, LimitUserAccessProvider, ChatProvider>(
        builder: (context, authProvider, likeProvider, QuestionProvider,
            profileProvider, LimitUserAccessProvider, chatProvider, child) {
      return Stack(
        children: [
          // const Center(child: CircularProgressIndicator()),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: 700,
                  child: SwipableStack(
                    detectableSwipeDirections: const {
                      SwipeDirection.right,
                      SwipeDirection.left,
                      SwipeDirection.up,
                    },
                    itemCount: widget.snapshot.data!.length,
                    controller: _controller,
                    stackClipBehaviour: Clip.none,
                    onSwipeCompleted: (index, direction) async {
                      print('===========$index, $direction');
                      if (direction == SwipeDirection.right) {
                        // provider.addfriend(index, true, false);
                        final userPackage =
                            LimitUserAccessProvider.checkFreePackage(
                          context,
                          authProvider.loginModel!.token,
                          authProvider.loginModel!.userData[0].id,
                        );
                        final connections =
                            await LimitUserAccessProvider.getconnectionscount(
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id);
                        print(connections.toString());
                        if (connections == "5" && userPackage == 0) {
                          SuccessFlushbar(
                              context, "Limit Reached", "Upgrade Your plan");
                          return;
                        }
                        print("not gonna call liked user provider");
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
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    chatProvider.sentSMS(
                                        context,
                                        authProvider.loginModel!.token,
                                        authProvider.loginModel!.userData[0].id,
                                        widget.snapshot.data![index]["id"],
                                        smsCTRL.text);
                                    PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: ChatScreen());
                                    Navigator.of(ctx).pop();
                                    SuccessFlushbar(context, "",
                                        "Message Sent"); // Close the AlertDialog
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
                            id: item['id'].toString(),
                            token: authProvider.loginModel!.token,
                            index: properties.index,
                            name: item['name'],
                            location: "asda",
                            assetPath: item["profile_pic_url"] ??
                                "https://19jungle.pakwexpo.com/api/auth/updateProfile",
                            onlineStatus: item["online"] ? "Online" : "Offline",
                            seeMore: () {
                              profileProvider.userDetail(
                                  id: widget
                                      .snapshot.data![properties.index]["id"]
                                      .toString(),
                                  token: authProvider.loginModel!.token,
                                  distance: widget.snapshot
                                      .data![properties.index]["distance"],
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
              ])),
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
  }
}
