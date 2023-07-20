import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';

import '../../Provider/auth_provider.dart';
import '../../Widgets/TextFormWidget.dart';
import 'package:http/http.dart' as http;

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

enum Sexuality { N, B, G, A, S }

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  TextEditingController name = TextEditingController();
  Sexuality Liveare = Sexuality.N;

  var expansionTile = false;
  TextEditingController nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        var profiledata = authProvider.loginModel!.userData[0];
        nameCtrl.text = profiledata.name;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: TextWidget(
              title: "Basic Info",
              size: 24,
              fontWeight: FontWeight.w400,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: [
              IconButton(
                onPressed: () async {
                  await authProvider.BasicInfoUpdate(
                      profiledata.id,
                      nameCtrl.text,
                      profiledata.gender,
                      profiledata.dob,
                      profiledata.location,
                      authProvider.loginModel!.token,
                      context,
                      false);
                  setState(() {
                    profiledata.name = nameCtrl.text;
                  });
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.black,
              ),
              textfieldProduct(
                context: context,
                controller: nameCtrl,
                name: profiledata.name,
                labelText: "Name",
                suffixIcon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),

              InkWell(
                onTap: () {
                  showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 50, 1),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      builder: (context, picker) {
                        return Container(
                          child: picker!,
                        );
                      }).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        profiledata.dob =
                            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                      });
                    }
                  });
                },
                child: ListTile(
                  title: TextWidget(
                    title: "Birthday",
                    size: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  subtitle: TextWidget(
                    title: profiledata.dob,
                    size: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              TextWidget(
                title: "   Gender",
                size: 24,
                fontWeight: FontWeight.w400,
              ),
              ExpansionTile(
                title: TextWidget(
                  title: profiledata.gender == "1"
                      ? "Male"
                      : profiledata.gender == "2"
                          ? "Female"
                          : profiledata.gender == "3"
                              ? "Other"
                              : "",
                  size: 15,
                  fontWeight: FontWeight.w500,
                ),
                onExpansionChanged: (value) {
                  setState(() {
                    expansionTile = value;
                  });
                },
                initiallyExpanded: expansionTile,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        profiledata.gender = "1";
                      });
                    },
                    child: Container(
                      width: width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Colors.grey[200],
                      child: TextWidget(
                        title: "Male",
                        size: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        profiledata.gender = "2";
                      });
                    },
                    child: Container(
                      width: width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Colors.grey[200],
                      child: TextWidget(
                        title: "Female",
                        size: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        profiledata.gender = "3";
                      });
                    },
                    child: Container(
                      width: width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Colors.grey[200],
                      child: TextWidget(
                        title: "Other",
                        size: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              // ListTile(
              //   title:
              //   subtitle: Row(
              //     children: [
              //       Radio(
              //         value: "Male",
              //         groupValue: gender,
              //         onChanged: (val) {
              //           setState(() {
              //             gender = "Male";
              //             profiledata.gender = "1";
              //           });
              //         },
              //       ),
              //       const Text(
              //         'Male',
              //         style: TextStyle(fontSize: 17.0),
              //       ),
              //       const SizedBox(
              //         width: 50,
              //       ),
              //       Radio(
              //         value: "Female",
              //         groupValue: gender,
              //         onChanged: (val) {
              //           setState(() {
              //             gender = "Female";
              //             profiledata.gender = "2";
              //           });
              //         },
              //       ),
              //       const Text(
              //         'Female',
              //         style: TextStyle(fontSize: 17.0),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
