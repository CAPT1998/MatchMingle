import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Screens/ChatScreen/AdminChat/AdminChatScreen.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../../Widgets/ChatInputWidget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          // leading: Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage("assets/img/img7.png"),
          //   ),
          // ),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/img/img7.png"),
                ),
              ),
              TextWidget(
                title: "Admin",
                size: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: appColor, width: 20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        title: "Pending Amount",
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextWidget(
                        title: "Total Amoutn Rs. 472",
                        size: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: appColor,
                        minWidth: width,
                        height: 45,
                        onPressed: () {},
                        child: TextWidget(
                          title: "Pay Now",
                          color: Colors.white,
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Colors.red,
                        minWidth: width,
                        height: 45,
                        onPressed: () {},
                        child: TextWidget(
                          title: "Pay Pal",
                          color: Colors.white,
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Color(0XFFEE8822),
                        minWidth: width,
                        height: 45,
                        onPressed: () {},
                        child: TextWidget(
                          title: "Master Card",
                          color: Colors.white,
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextWidget(title: "Payment Methods ", size: 20),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                        "assets/img/1933703_charge_credit card_debit_mastercard_payment_icon.png"),
                    TextWidget(
                      title: "  Credit Card ",
                      size: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                 SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                        "assets/img/3668846_money_cash_finance_icon.png"),
                    TextWidget(
                      title: "  Cash",
                      size: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomSheet: ChatInputField(
          message: message,
          press: () {},
          filePress: () {
            _fileButton(context);
          },
        ),
      ),
    );
  }
}

Widget _RightChat() {
  return Align(
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: width * 0.6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: TextWidget(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
            size: 12,
            maxline: 3,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
            title: "Sent at 03:03 PM",
            size: 10,
            fontWeight: FontWeight.w400,
            color: greyColor)
      ],
    ),
  );
}

Widget _leftChat() {
  return Align(
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0XFFE6E6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: TextWidget(
            title: "Lorem ipsum dolor sit amet, consectetur adipiscing ",
            size: 12,
            maxline: 3,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
            title: "Sent at 03:03 PM",
            size: 10,
            fontWeight: FontWeight.w400,
            color: greyColor)
      ],
    ),
  );
}

_actionButton(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title: "Select Option",
            size: 30,
          ),
          SizedBox(
            height: 20,
          ),
          TextWidget(
            title: "Un Match User",
            size: 30,
            fontWeight: FontWeight.w400,
          ),
          TextWidget(
            title: "Block User",
            size: 30,
            fontWeight: FontWeight.w400,
          ),
          TextWidget(
            title: "Cancle",
            size: 30,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    ),
  );
}

_fileButton(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            title: "Select",
            size: 30,
          ),
          SizedBox(
            height: 20,
          ),
          TextWidget(
            title: "Take A picture",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Choose Photo From Gallery",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Select Vedio",
            size: 20,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 10,
          ),
          TextWidget(
            title: "Cancle",
            size: 20,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    ),
  );
}
