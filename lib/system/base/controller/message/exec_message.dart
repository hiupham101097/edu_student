
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';

class ExecMessage {
  static void exec(RemoteMessage message) {
    var navigatorKey = GlobalParams.getGlobalKeyNavigatorState();
    //var context = GlobalParams.getContext();

    if (navigatorKey.currentState != null) {
      // Navigator.pushReplacement(
      //   navigatorKey.currentState!.context,
      //   MaterialPageRoute(builder: (context) => ContactCustomerView()),
      // );
    } else {
      // Navigator.pushReplacement(
      //   context!,
      //   MaterialPageRoute(builder: (context) => ContactCustomerView()),
      // );
    }
  }

  static List<Widget> getValues(RemoteMessage? message) {
    List<Widget> values = [];

    if (message != null) {
      if (message.notification != null) {
        values.add(Text(message.notification!.body ?? ""));
      }
    } else {
      values.add(const Text("Content"));
    }

    return values;
  }
}
