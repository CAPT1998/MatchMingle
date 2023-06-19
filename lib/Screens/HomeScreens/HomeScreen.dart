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
import '../LikesScreens/LikesScreen.dart';
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
  bool isSending = false;

  int distence = 10;
  TextEditingController locationCTRL = TextEditingController();
  var gander = "Male";
  var show = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  builder: (ctx) => StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.7, // 80% of the screen height
                            // 80% of the screen width
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Color(0xFFE00088),
                                            fontSize: 26,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Text(
                                              "Location",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: TextField(
                                              controller: locationCTRL,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'People Nearby',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Distance",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  distence.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Slider(
                                            activeColor:
                                                const Color(0xFFE00088),
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
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Text(
                                              "Gender",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    gander = "Male";
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: gander == "Male"
                                                          ? Colors.blue
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  height: 40,
                                                  width: 70,
                                                  child: Center(
                                                    child: Text(
                                                      "Male",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: gander == "Female"
                                                          ? Colors.blue
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  height: 40,
                                                  width: 70,
                                                  child: Center(
                                                    child: Text(
                                                      "Female",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: gander == "Both"
                                                          ? Colors.blue
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  height: 40,
                                                  width: 70,
                                                  child: Center(
                                                    child: Text(
                                                      "Both",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8),
                                                child: Text(
                                                  "Age",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${ageValue.start.toInt()} - ${ageValue.end.toInt()}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                ),
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
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 200, // Specify the desired width
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Color(
                                                  0xFFE00088)), // Set the desired background color
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: FilterScreen(
                                              distance: distence.toString(),
                                              age: ageValue.start.toString(),
                                              gender: gander.toString(),
                                              location: locationCTRL.text,
                                            ),
                                            withNavBar: false,
                                          );
                                        },
                                        child: Text('Apply Filter'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
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
                  context,
                    authProvider.loginModel?.token,
                    authProvider.loginModel?.userData[0].id),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: SpinKitPumpingHeart(
                      color: Color(0XFFE90691),
                      size: 70.0,
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitPumpingHeart(
                      color: Color(0XFFE90691),
                      size: 70.0,
                    ));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Nearby Users"),
                    );
                  }
                  //   print("user plan is "+ authProvider.loginModel!.userData[0].planid);

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
  bool isSending = false;

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
                        final planid =
                            await LimitUserAccessProvider.getUserPlan(
                          context,
                          authProvider.loginModel!.token,
                          authProvider.loginModel!.userData[0].id,
                        );
                        final connections =
                            await LimitUserAccessProvider.getconnectionscount(
                                authProvider.loginModel!.token,
                                authProvider.loginModel!.userData[0].id);
                        print(
                            "User plan id is $planid and connections are $connections");
                        if (connections == "5" && planid == '0') {
                          ErrorFlushbar(
                              context, "Limit Reached", "Upgrade Your plan");
                          return;
                        } else if (connections == "5" && planid == '1') {
                          likeProvider.LikeUser(
                            context,
                            authProvider.loginModel!.token,
                            authProvider.loginModel!.userData[0].id,
                            widget.snapshot.data![index]["id"],
                          );
                        } else if (connections == "10" && planid == '1') {
                          ErrorFlushbar(
                              context, "Limit Reached", "Upgrade Your plan");
                          return;
                        }

                        likeProvider.LikeUser(
                          context,
                          authProvider.loginModel!.token,
                          authProvider.loginModel!.userData[0].id,
                          widget.snapshot.data![index]["id"],
                        );
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
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SendMessageScreen(
                            token: authProvider.loginModel!.token,
                            senderId: authProvider.loginModel!.userData[0].id,
                            receiverId: widget.snapshot.data![index]["id"],
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
                      var item;

                      if (widget.snapshot.data != null &&
                          widget.snapshot.data!.isNotEmpty) {
                        item = widget.snapshot.data![properties.index];
                      } else {
                        item = {}; // Empty map as a default value
                        return Center(child: Text("No Nearby Users"));
                      }

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
