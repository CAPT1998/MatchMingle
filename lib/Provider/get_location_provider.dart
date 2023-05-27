import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class GeoLocation with ChangeNotifier {
  var location;
  determinePosition(token, userId, context) async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission Not Given");
      LocationPermission asked = await Geolocator.requestPermission();
      // permission = await Geolocator.requestPermission();
      // if (permission == LocationPermission.denied) {
      //   return Future.error('Location permissions are denied');
      // }
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition();
    }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    // var location = await Geolocator.getCurrentPosition();
    print("location====>$location");
    try {
      var url = Uri.parse('${AppUrl.baseUrl}/auth/updateLatitudeLongitude');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'id': userId.toString(),
        'latitude': location.latitude.toString(),
        'longitude': location.longitude.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Location", data["message"]);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Location", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print("=====>$e");
      ErrorFlushbar(context, "Location", e.toString());
    }
    return location;
  }
}
