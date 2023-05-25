import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Screens/SplashScreen/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Provider/auth_provider.dart';
import 'Provider/block_user_provider.dart';
import 'Provider/chat_provider.dart';
import 'Provider/get_location_provider.dart';
import 'Provider/like_provider.dart';
import 'Provider/profile_provider.dart';
import 'Provider/question_provider.dart';
import 'Provider/social_account_provider.dart';
import 'Provider/user_list_provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<BlockUser>(create: (context) => BlockUser()),
        ChangeNotifierProvider<QuestionProvider>(
            create: (context) => QuestionProvider()),
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider()),
        ChangeNotifierProvider<UserListProvider>(
            create: (context) => UserListProvider()),
        ChangeNotifierProvider<GeoLocation>(create: (context) => GeoLocation()),
        ChangeNotifierProvider<LikeProvider>(
            create: (context) => LikeProvider()),
        ChangeNotifierProvider<SocialAccountProvider>(
            create: (context) => SocialAccountProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const Text("Some thing Went Wrong");
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return SplashScreen();
              // LoginView();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
