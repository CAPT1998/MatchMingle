import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:teen_jungle/Constant.dart';
import 'package:teen_jungle/Widgets/TextWidget.dart';
import '../../Provider/auth_provider.dart';
import '../../Provider/get_location_provider.dart';
import '../AuthScreens/UploadPhotoScreen.dart';
import '../BottomNavigationBar/PersistanceNavigationBar.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  bool visiblePassword = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          leading: Icon(Icons.close),
          title: Text("Live Allow"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Consumer2<AuthProvider, GeoLocation>(
              builder: (context, authProvider, geoLocation, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: "Enable Location",
                    size: 40,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: "Enale your live location",
                    size: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  RoundedLoadingButton(
                    controller: buttonController,
                    borderRadius: 10,
                    onPressed: () async {
                      await geoLocation.determinePosition(
                          authProvider.loginModel!.token,
                          authProvider.loginModel!.userData[0].id,
                          context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UploadPhotoScreen()));
                      buttonController.reset();
                    },
                    child: TextWidget(
                      title: "Allow Location",
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}