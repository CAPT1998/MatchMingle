import 'package:flutter/material.dart';
import 'package:teen_jungle/Constant.dart';

import '../../Widgets/TextWidget.dart';

class paymentScreen extends StatefulWidget {
  const paymentScreen({super.key});

  @override
  State<paymentScreen> createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: TextWidget(
            title: "Payment",
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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              TextWidget(
                title: "Pending Amount",
                size: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    title: "Total Amount is ",
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    title: "\$ 3,99/Mo",
                    size: 18,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              smallButtton("Pay Now"),
              smallButtton("Paypal"),
              smallButtton("Master Card"),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: "Payment Methods",
                      size: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              paymentMethod("Credit Card", "assets/img/card_debit.png"),
              paymentMethod("Cash", "assets/img/cash_finance.png"),
            ],
          ),
        ));
  }
}

Widget smallButtton(title) {
  return Container(
    width: 200,
    padding: const EdgeInsets.only(top: 12, bottom: 12),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF167AA4),
    ),
    child: Center(
      child: TextWidget(
        title: title,
        size: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget paymentMethod(title, img) {
  return Row(children: [
    Image.asset(img),
    const SizedBox(
      width: 10,
    ),
    TextWidget(
      title: title,
      size: 18,
      fontWeight: FontWeight.w400,
    ),
  ]);
}
