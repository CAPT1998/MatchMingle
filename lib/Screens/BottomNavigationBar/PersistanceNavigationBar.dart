import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:teen_jungle/Screens/ChatScreen/ChatScreens.dart';
import 'package:teen_jungle/Screens/HomeScreens/CardsScreen.dart';
import 'package:teen_jungle/Screens/HomeScreens/HomeScreen.dart';
import 'package:teen_jungle/Screens/Profile/ProfileScreen.dart';

import '../../Constant.dart';
import '../LikesScreens/LikesScreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        items: _navBarsItems(),
        resizeToAvoidBottomInset: false,
        hideNavigationBarWhenKeyboardShows: true,
        screens: const [
          HomeScreen(),
          CardsScreen(),
          LikesScreen(),
          ChatScreen(),
          ProfileScreen(),
        ],
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard_outlined),
        title: ("Menu"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.card_membership_rounded,
        ),
        title: ("Cards"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.favorite_border,
        ),
        title: ("Likes"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.chat_bubble_2,
        ),
        title: ("Chat"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_pin),
        // icon: apbar_photo = Image.asset(
        //   "assets/logo/photo.png",
        //   height: 25,
        // ),
        title: ("Profile"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
