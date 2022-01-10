// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class Connection extends GetxController {
//   String connectionStatus = 'Unknown';
//   final Connectivity connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> connectivitySubscription;

//   @override
//   void onInit() {
//     // TODO: implement onInit
// connectivitySubscription =
//         connectivity.onConnectivityChanged.listen(updateConnectionStatus);
//     super.onInit();
//   }

//   Future<void> initConnectivity() async {
//     ConnectivityResult result = ConnectivityResult.none;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }

//     return updateConnectionStatus(result);
//   }

//   Future<void> updateConnectionStatus(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.wifi:
//       case ConnectivityResult.mobile:
//       case ConnectivityResult.none:
//          connectionStatus = result.toString();
//         break;
//       default:
//          connectionStatus = 'Failed to get connectivity.';
//         break;
//     }
//   }
  
  
// }
