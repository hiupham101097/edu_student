// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../controller/bloc/webview/webview_bloc.dart';
import '../../../../controller/bloc/webview/webview_event.dart';
import '../../../../controller/bloc/webview/webview_state.dart';
import '../../../_variables/storage/global_params.dart';
import '../../../_variables/value/app_const.dart';

// ignore: camel_case_types--
class WebToMobile {
  // ignore: unused_element
  static Future<void> webToMobile(
      InAppWebViewController controller,
      BuildContext context,
      String? checkChat,
      String? title,
      WebviewState state) async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var value = prefs.getString(
      "SETTOKEN",
    );

    controller.addJavaScriptHandler(
      handlerName: 'webToMobile',
      callback: (args) async {
        // ignore: avoid_print
        print(args);
        // ignore: unused_local_variable
        var isCheck = false;
        if (args.isNotEmpty) {
          if (args[0] == "SETCOOKIE") {
            isCheck = true;
          }

          if (args[0][0] == 'title') {
            title = args[0][1];
            var view = state.view == "" ? "V" : "";

            context.read<WebviewBloc>().add(WebviewModelChange(view));
          }

          if (args[0][0] == 'class') {
            title = args[0][1];
            var view = state.view == "" ? "V" : "";

            context.read<WebviewBloc>().add(ChangeClass(title.toString(),
                AppConst.urlQlEDU + args[0][2], context, "task", view));
          }

          if (args[0][0] == 'meet') {
            var url = args[0][1];
            final uri = Uri.parse(url);
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }

          if (args[0] == 'message') {
            var view = state.view == "" ? "V" : "";
            var urlChat = GlobalParams.listUrl
                .where((w) => w.code!.contains("MENUEDUCHATQL"))
                .firstOrNull;

            // ignore: use_build_context_synchronously
            context.read<WebviewBloc>().add(ChangeToChat(
                urlChat!.name.toString(),
                urlChat.url.toString(),
                context,
                "task",
                view));
          }

          if (args[0][0] == 'message') {
            var dataLink = args[0][2];
            title = args[0][1];
            var view = state.view == "" ? "V" : "";
            var link = GlobalParams.listUrl
                .where((w) => w.code!.contains("EDUCHATBOX"))
                .firstOrNull;
            var url = link!.url! + dataLink;
            // ignore: use_build_context_synchronously
            context.read<WebviewBloc>().add(ChangeToChat(
                title.toString(), url.toString(), context, "chat", view));
          }

          if (args[0][0] == 'Học sinh') {
            checkChat = 'task';
            var view = 'V';
            // ignore: use_build_context_synchronously
            context.read<WebviewBloc>().add(WebviewModelChange(view));
          }

          if (args[0][0] == 'Phụ huynh') {
            checkChat = 'chat';
            var view = '';
            // ignore: use_build_context_synchronously
            context.read<WebviewBloc>().add(WebviewModelChange(view));
          }
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("SETTOKEN", "false");
      },
    );
  }
}

class MobileToweb {
  static mobiToWeb(
    InAppWebViewController controller,
    String key,
    String data1, {
    String? data2 = "",
    String? data3 = "",
    String? data4 = "",
    String? data5 = "",
  }) {
    controller.evaluateJavascript(
      source:
          'mobileToWeb("$key", "$data1", "$data2", "$data3", "$data4", "$data5")',
    );
  }
}
