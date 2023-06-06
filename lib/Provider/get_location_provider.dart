import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Widgets/FlushbarWidget.dart';
import '../Widgets/api_urls.dart';

class GeoLocation with ChangeNotifier {
//   void requestLocationPermission() async {
//   PermissionStatus status = await Permission.location.request();
//   if (status.isGranted) {
//     print('Location permission granted');
//     getCurrentLocation();
//   } else {
//     print('Location permission denied');
//   }
// }

// void getCurrentLocation() async {
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (serviceEnabled) {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       print('Location permissions are permanently denied');
//     } else if (permission == LocationPermission.denied) {
//       print('Location permissions are denied');
//       await Geolocator.openAppSettings(); // Open app settings to enable permissions
//     } else {
//       print('Location permissions are granted');
//       Position position = await Geolocator.getCurrentPosition();
//       determinePosition(position.latitude.toDouble(), position.longitude.toString, det);
//     }
//   } else {
//     print('Location services are disabled');
//   }
// }

//     determinePosition(token, latitude, longitude, userid, context) async {

//       final url = 'https://19jungle.pakwexpo.com/api/auth/updateLatitudeLongitude';
//         final headers = {
//     'Content-Type': 'application/json',
//     // Add any other headers required by your API
//   };

//   final data = {
//     'id' : userid,
//     'latitude': latitude,
//     'longitude': longitude,
//   };
//   final body = jsonEncode(data);

//    try {
//     final response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       print('Location uploaded successfully');
//     } else {
//       print('Failed to upload location. Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Failed to upload location. Error: $e');
//   }
// }
//     }

  var location;
  determinePosition(token, userId, context, latitude, longitude) async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are disabled, so prompt the user to enable them
      bool serviceRequested = await Geolocator.openLocationSettings();

      if (!serviceRequested) {
        // User declined to enable location services
        throw Exception('Location services are disabled.');
      }
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission Not Given");
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // User declined to grant location permission
        throw Exception('Location permissions are denied.');
      }
    }

    Position currentPosition = await Geolocator.getCurrentPosition();

    print("user latitude is" + currentPosition.latitude.toString());
    print("user latitude is" + currentPosition.longitude.toString());

    try {
      var url = Uri.parse('${AppUrl.baseUrl}/auth/updateLatitudeLongitude');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'id': userId.toString(),
        'latitude': currentPosition.latitude.toString(),
        'longitude': currentPosition.longitude.toString(),
      });
      // final Map<String, dynamic> data = json.decode(response.body);
      var data = jsonDecode(response.body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        SuccessFlushbar(context, "Location", data["message"]);
        print(response.body);
        notifyListeners();
      } else {
        ErrorFlushbar(context, "Location", data["message"]);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    // // var location = await Geolocator.getCurrentPosition();
    // print("location====>$location");

    // return location;
  }
}
