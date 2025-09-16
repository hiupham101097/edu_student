import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CallBack {
  static willPopCallback(String? url, InAppWebViewController webViewController,
      BuildContext context) async {
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
      return false;
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return true;
    }
  }
}
