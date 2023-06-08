// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Models/LoginModel.dart';
import '../../Widgets/api_urls.dart';
import 'BottomButtonRow.dart';

class ExampleCard extends StatefulWidget {
  ExampleCard({
    required this.index,
    required this.id,
    required this.token,
    required this.name,
    required this.location,
    required this.assetPath,
    required this.onlineStatus,
    required this.seeMore,
    // super.key,
  });
  final int index;
  final String id;
  final String token;
  final String name;
  final String location;
  final assetPath;
  final String onlineStatus;
  final Function seeMore;

  @override
  State<ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<ExampleCard> {
  int? age;
  DateTime currentdate = DateTime.now();
  Duration? diff;
  String? location;
  List<dynamic> q1 = [];
  final ScrollController _scrollController = ScrollController();

  void getquetionsdata(String id, String token) async {
    print('inside question data');
    print(widget.id);
    LoginModel? loginModel;
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/users/detail?id=$id');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> data = await json.decode(response.body);
      print(data["data"][0]["location"]);
      String? location = data["data"][0]["location"] ?? "";
      List<dynamic> q1 = data["data"][0]["userQuestion"] ?? "";

      setState(() {
        this.location = location ?? "";
        this.q1 = q1;
      });
      print(response.statusCode);
      print(q1);

      if (response.statusCode == 200) {
      } else {
        // ErrorFlushbar(context, "Block User", data["message"]);
      }
    } catch (e) {
      print("===>$e");
    }
  }

  @override
  void initState() {
    // DateTime date = DateTime.parse(
    //     Provider.of<UserProvider>(context, listen: false)
    //         .userslist[widget.index]
    //         .date!);
    // diff = currentdate.difference(date);
    // age = (double.parse(((diff!.inDays / 365)).toString()).floor());
    // print(diff!.inDays);
    super.initState();
    getquetionsdata(widget.id, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(14),
      child: Scrollbar(
        //thumbVisibility: true,

        thickness: 6,
        radius: Radius.circular(3),
        child: CustomScrollView(
          controller: _scrollController,
          // physics: BouncingScrollPhysics(), // Apply the bouncing effect

          slivers: [
            SliverAppBar(
              expandedHeight: 700,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: widget.index,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              //  borderRadius: BorderRadius.circular(44),
                              image: widget.assetPath ==
                                      "http://jungle19.pakwexpo.com/public/images/updateProfile"

                                  // "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder"
                                  // &&   widget.assetPath == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          "assets/img/profilerectangle.png"),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage(widget.assetPath),
                                      fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 26,
                                  color: Colors.black.withOpacity(0.80),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: <Color>[
                                Colors.black12.withOpacity(0),
                                Colors.black12.withOpacity(.4),
                                Colors.black12.withOpacity(.82),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(14),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black12.withOpacity(0),
                                Colors.black12.withOpacity(.4),
                                Colors.black12.withOpacity(.82),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 489),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.name,
                                  style: theme.textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Text(
                                //   age.toString(),
                                //   style: theme.textTheme.headline6!.copyWith(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 25,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          widget.seeMore();
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.info_circle_fill,
                                          color: Colors.white,
                                        )),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: widget.onlineStatus == "Online"
                                      ? Colors.green
                                      : Colors.white,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.onlineStatus,
                                  style: theme.textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  location ?? " ",
                                  style: theme.textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: BottomButtonsRow.height)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                  child: Container(
                    color: Colors.white,
                    //margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_1'] != null &&
                              q1[0]['question_1'].isNotEmpty,
                          child: Text(
                            'About me',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_1'] != null &&
                              q1[0]['question_1'].isNotEmpty,
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      q1.isNotEmpty
                                          ? q1[0]['question_1']
                                          : "No info Available",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_2'] != null &&
                              q1[0]['question_2'].isNotEmpty,
                          child: Text(
                            'Relationship Status',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_2'] != null &&
                              q1[0]['question_2'].isNotEmpty,
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      q1.isNotEmpty
                                          ? q1[0]['question_2']
                                          : "No info Available",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.network(
                              widget.assetPath,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                );
                              },
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Text('No other images found');
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_3'] != null &&
                              q1[0]['question_3'].isNotEmpty,
                          child: Text(
                            'Living Arrangements',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_3'] != null &&
                              q1[0]['question_3'].isNotEmpty,
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      q1.isNotEmpty
                                          ? q1[0]['question_3']
                                          : "No info Available",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_4'] != null &&
                              q1[0]['question_4'].isNotEmpty,
                          child: Text(
                            'Views on Parenthood',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_4'] != null &&
                              q1[0]['question_4'].isNotEmpty,
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      q1.isNotEmpty
                                          ? q1[0]['question_4']
                                          : "No info Available",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_5'] != null &&
                              q1[0]['question_5'].isNotEmpty,
                          child: Text(
                            'Opinions on Smoking and Drink',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Visibility(
                          visible: q1.isNotEmpty &&
                              q1[0]['question_5'] != null &&
                              q1[0]['question_5'].isNotEmpty,
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(
                                      q1.isNotEmpty
                                          ? q1[0]['question_5']
                                          : "No info Available",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                  SizedBox(height: 24),
                  
                  Center(
                    child: Row(
                      children: [
                        Text(
                          '${widget.name}\'s info',
                           style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                               Center (child: Row(
                    children: [
                      Icon(Icons.language, color: Colors.blue),
                      SizedBox(width: 6),
                      Text(
                        'English',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.music_note, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        'Music',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.people_alt_rounded, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        'Single',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      ),
                      // Add more keyword icons and texts if needed
                    ],
                  ),
                               ),
                  */
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey[600]),
                            SizedBox(width: 8),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    color: Colors.blue,
                                    Icons
                                        .map_sharp, // Replace with your logo icon
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    location ?? "Not available",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.verified, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              'Verification Status: Verified',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 90),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.black12.withOpacity(0),
                                  Colors.black12.withOpacity(.4),
                                  Colors.black12.withOpacity(.42),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
