// import 'dart:io'; //InternetAddress utility
// import 'dart:async'; //For StreamController/Stream
//
// import 'package:connectivity/connectivity.dart';
//
// class ConnectionStatusSingleton {
//   //This creates the single instance by calling the `_internal` constructor specified below
//   static final ConnectionStatusSingleton _singleton = new ConnectionStatusSingleton._internal();
//   ConnectionStatusSingleton._internal();
//
//   //This is what's used to retrieve the instance through the app
//   static ConnectionStatusSingleton getInstance() => _singleton;
//
//   //This tracks the current connection status
//   bool hasConnection = false;
//
//   //This is how we'll allow subscribing to connection changes
//   StreamController connectionChangeController = new StreamController.broadcast();
//
//   //flutter_connectivity
//   final Connectivity _connectivity = Connectivity();
//
//   //Hook into flutter_connectivity's Stream to listen for changes
//   //And check the connection status out of the gate
//   void initialize() {
//     _connectivity.onConnectivityChanged.listen(_connectionChange);
//     checkConnection();
//   }
//
//   Stream get connectionChange => connectionChangeController.stream;
//
//   //A clean up method to close our StreamController
//   //   Because this is meant to exist through the entire application life cycle this isn't
//   //   really an issue
//   void dispose() {
//     connectionChangeController.close();
//   }
//
//   //flutter_connectivity's listener
//   void _connectionChange(ConnectivityResult result) {
//     checkConnection();
//   }
//
//   //The test to actually see if there is a connection
//   Future<bool> checkConnection() async {
//     bool previousConnection = hasConnection;
//
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         hasConnection = true;
//       } else {
//         hasConnection = false;
//       }
//     } on SocketException catch(_) {
//       hasConnection = false;
//     }
//
//     //The connection status changed send out an update to all listeners
//     if (previousConnection != hasConnection) {
//       connectionChangeController.add(hasConnection);
//     }
//
//     return hasConnection;
//   }
// }
import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class checkInternet{
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title,String content ,BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("بستن"))
              ]
          );
        }
    );
  }
  checkConnection(BuildContext context) async{
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          // InternetStatus = "Connected to the Internet";
          // contentmessage = "Connected to the Internet";
          // _showDialog(InternetStatus,contentmessage,context);
          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "عدم اتصال به اینترنت";
          contentmessage = "لطفا اتصال تلفن همراه به اینترنت را بررسی کنید.";
          _showDialog(InternetStatus,contentmessage,context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}