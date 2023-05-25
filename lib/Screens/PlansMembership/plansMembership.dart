import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';

import '../../Widgets/TextWidget.dart';

class plansMembership extends StatefulWidget {
  const plansMembership({super.key});

  @override
  State<plansMembership> createState() => _plansMembershipState();
}

class _plansMembershipState extends State<plansMembership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(
            title: "Plans Membership",
            size: 24,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.check,
          //       color: Colors.black,
          //     ),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              expandCard(
                title: 'FREE PLAN',
                price: '0',
                contact: '5',
                videocall: '0',
                photos: '5',
                bio: 'Short Bio',
                verified: 'Basic Verified',
                profile: 'Profile',
                limit: '1 Month',
                color: Color(0xFF167AA4),
              ),
              expandCard(
                title: 'START PLAN',
                price: '1,99',
                contact: '10',
                videocall: '3',
                photos: '3',
                bio: 'Short Bio',
                verified: 'Basic Verified',
                profile: 'MOBILE PHONE AND EMAIL',
                limit: '1 Month',
                color: Color(0xFFE00088),
              ),
              expandCard(
                title: 'POWER PLAN',
                price: '3,99',
                contact: '20',
                videocall: '3',
                photos: '5',
                bio: 'Long Bio',
                verified: 'Basic Verified',
                profile: 'MOBILE PHONE AND EMAIL',
                limit: '1 Month',
                color: Color(0xFFAC9100),
              ),
            ],
          ),
        ));
  }
}

class expandCard extends StatefulWidget {
  final String title;
  final String price;
  final String contact;
  final String videocall;
  final String bio;
  final String verified;
  final String profile;
  final String limit;
  final String photos;
  final Color color;
  const expandCard(
      {super.key,
      required this.title,
      required this.price,
      required this.contact,
      required this.videocall,
      required this.bio,
      required this.verified,
      required this.profile,
      required this.limit,
      required this.photos,
      required this.color});

  @override
  State<expandCard> createState() => _expandCardState();
}

class _expandCardState extends State<expandCard> {
  var show = false;

  @override
  Widget build(BuildContext context) {
    var vwidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: SizedBox(
                    width: vwidth - 40,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          title: widget.title,
                          size: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        TextWidget(
                          title: "€ ${widget.price}/MO",
                          size: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                show
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: vwidth - 50,
                                    child: TextWidget(
                                      title:
                                          "We Offer Maximum ${widget.contact} Contacts A Month Chatting Text",
                                      size: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  dotText("Video Call ${widget.videocall}"),
                                  dotText("Upload ${widget.photos} Photos"),
                                  dotText(widget.bio),
                                  dotText(widget.verified),
                                  dotText(widget.profile),
                                  dotText("${widget.limit} Discount"),
                                  SizedBox(
                                    width: vwidth - 55,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 38.0,
                                                  right: 38,
                                                  top: 8,
                                                  bottom: 8),
                                              child: Text("Pay Now"),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dotText(title) {
    return Row(
      children: [
        Image.asset(
          "assets/img/dot.png",
          width: 10,
        ),
        SizedBox(
          width: 5,
        ),
        TextWidget(
          title: title,
          size: 17,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
