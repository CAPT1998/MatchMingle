import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';

import '../../Widgets/FlushbarWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../Payment.dart/Payment.dart';

class plansMembership extends StatefulWidget {
  const plansMembership({super.key});

  @override
  State<plansMembership> createState() => _plansMembershipState();
}

class _plansMembershipState extends State<plansMembership> {
  Map<String, dynamic>? paymentIntent;

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
                photos: '2',
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
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    print(widget.price);
  }

  Future<void> makePayment() async {
    //tring price = rate.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedPrice = widget.price.replaceAll(',', '.');
    double priceValue = double.parse(formattedPrice);

    try {
      paymentIntent = await createPaymentIntent(priceValue.toString(), 'EUR');
      log("paymentIntent:::::::::${paymentIntent}");
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay:
                PaymentSheetGooglePay(merchantCountryCode: 'US', testEnv: true),
            // customFlow: true,
            //    applePay: PaymentSheetApplePay(
            //        merchantCountryCode: 'US',
            //   ),
            merchantDisplayName: '19 Jungle user subscription',
            // customerId: 'cus_NjsJj78KUlQoN6',
            paymentIntentClientSecret: paymentIntent!['client_secret'],
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        SuccessFlushbar(context, "Success", "Payment Successfull");

        // updatePaymentAndExpiry(widget.userid, id);
       // Future.delayed(Duration(seconds: 2));

      //  Navigator.pop(context);

        // paymentIntent = {};
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('DErrrrrr$e');
    }
  }

  int calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    print("calculated amount is " + calculatedAmount.toString());
    return calculatedAmount;
  }

  createPaymentIntent(String amount, String currency) async {
    print("In Price");
    final dio = Dio();

    try {
      print("In Try");

      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          // url("https://api.stripe.com/v1/prices"),
          // queryParameters: {},
          options: Options(headers: {
            'Authorization':
                'Bearer sk_test_51Hww9ZDlvBXPosmOQFUmcRbu2SUxCKAN19wlKBFJkmgBXUTh1Proqv5wLKQ2kO8ts2yqzGESeefdb3IWxZ1gupJe00VGEEeA4Z',
            'Content-Type': 'application/x-www-form-urlencoded',
          }),
          queryParameters: {
            'amount': calculateAmount(amount),
            'currency': currency,
            //'customer': 'cus_NjsJj78KUlQoN6',
            'payment_method_types[]': 'card',
          });

      if (response.statusCode == 200) {
        print(response.data);

        print("Ram::::::::::::Success");
      } else {
        print(response.data);
      }
      return response.data;
    } catch (e) {
      print("In Try");

      print(e);
      print("Ram::::::::::::False");
    }
  }

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
                                            onPressed: () {
                                              makePayment();
                                            },
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
