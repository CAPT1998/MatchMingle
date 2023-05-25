// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BottomButtonRow.dart';

class ExampleCard extends StatefulWidget {
  ExampleCard({
    required this.index,
    required this.name,
    required this.location,
    required this.assetPath,
    required this.onlineStatus,
    required this.seeMore,
    // super.key,
  });
  final int index;
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: widget.index,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: widget.assetPath ==
                              "http://marriageapi.pakwexpo.com/public/images/profile_picture_folder" 
                              // &&   widget.assetPath == null
                      ? const DecorationImage(
                          image: AssetImage("assets/img/profilerectangle.png"),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: NetworkImage(widget.assetPath),
                          fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 26,
                      color: Colors.black.withOpacity(0.08),
                    ),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                          : Colors.grey,
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
                      widget.location,
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
    );
  }
}
