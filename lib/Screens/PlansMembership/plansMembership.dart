import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Provider/profile_provider.dart';

import '../../Provider/auth_provider.dart';
import '../../Widgets/FlushbarWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../../Widgets/api_urls.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';
import '../Payment.dart/Payment.dart';
import '../Profile/ProfileScreen.dart';

class plansMembership extends StatefulWidget {
  const plansMembership({super.key});

  @override
  State<plansMembership> createState() => _plansMembershipState();
}

class _plansMembershipState extends State<plansMembership> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProfileProvider>(
      builder: (context, authdata, profiledata, child) {
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
                children: [
                  expandCard(
                    id: authdata.loginModel!.userData[0].id.toString(),
                    token: authdata.loginModel!.token,
                    title: 'FREE PLAN',
                    price: '0',
                    contact: '5',
                    planid: '0',
                    videocall: '0',
                    photos: '2',
                    bio: 'Short Bio',
                    verified: 'Basic Verified',
                    profile: 'Profile',
                    limit: '1 Month',
                    color: Color(0xFF167AA4),
                  ),
                  expandCard(
                    id: authdata.loginModel!.userData[0].id.toString(),
                    token: authdata.loginModel!.token,
                    title: 'START PLAN',
                    price: '1,99',
                    planid: '1',
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
                    id: authdata.loginModel!.userData[0].id.toString(),
                    token: authdata.loginModel!.token,
                    title: 'POWER PLAN',
                    price: '3,99',
                    contact: '20',
                    videocall: '3',
                    photos: '5',
                    bio: 'Long Bio',
                    planid: '2',
                    verified: 'Basic Verified',
                    profile: 'MOBILE PHONE AND EMAIL',
                    limit: '1 Month',
                    color: Color(0xFFAC9100),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class expandCard extends StatefulWidget {
  final String title;
  final String price;
  final String contact;
  final String videocall;
  final String bio;
  final String planid;

  final String verified;
  final String id;
  final dynamic token;
  final String profile;
  final String limit;
  final String photos;
  final Color color;
  expandCard(
      {super.key,
      required this.id,
      required this.token,
      required this.title,
      required this.planid,
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
    print(widget.id + "id");
  }

  Future<void> makePayment(context) async {
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
      displayPaymentSheet(context);
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(context) async {
    AuthProvider authProvider = AuthProvider();
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await updateUserPlan(context, widget.id, widget.planid, widget.token);

        print("Id is " + widget.id + authProvider.loginModel!.token);

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
                'Bearer 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',
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

  Future<void> updateUserPlan(
    context,
    String userId,
    String planid,
    token,
  ) async {
    // API endpoint URL
    final String apiUrl = '${AppUrl.baseUrl}/users/plan/create';
//Uri.parse('${AppUrl.baseUrl}/auth/updateLatitudeLongitude');
    // Request body parameters

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'user_id': userId.toString(),
        'plan_id': planid,
      });
      print(response.body);
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const ProfileScreen(),
        withNavBar: true,
      );
      SuccessFlushbar(context, "Success", "Payment Successfull");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
      } else {
        // Error handling for unsuccessful request
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Exception handling
      print('An error occurred: $e');
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
                                              widget.planid == "0"
                                                  ? SuccessFlushbar(
                                                      context,
                                                      "Success",
                                                      "Plan Already Active")
                                                  : makePayment(context);
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
