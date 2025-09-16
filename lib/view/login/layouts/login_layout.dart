import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/_variables/storage/storage_data.dart';
import 'package:edu_student/system/_variables/value/app_const.dart';
import 'package:edu_student/system/base/config/config_info.dart';
import 'package:edu_student/system/base/user/user_data_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginLayout extends StatefulWidget {
  //ignore: use_key_in_widget_constructors
  LoginLayout(
    BuildContext context,
    GlobalKey<FormState>? key, {
    this.diaglogContext,
  }) : _context = context {
    viewKey = key;
  }
  GlobalKey<FormState>? viewKey;
  // ignore: prefer_final_fields, unused_field
  BuildContext? _context;
  BuildContext? diaglogContext;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _LoginLayout();
}

class _LoginLayout extends State<LoginLayout> {
  // ignore: unused_field
  bool _isLoading = false;

  Future<void> _webToMobile(
    InAppWebViewController controller,
    BuildContext? context,
  ) async {
    // ignore: unused_local_variable
    final prefs = await SharedPreferences.getInstance();
    controller.addJavaScriptHandler(
      handlerName: 'getTokenFromWeb',
      callback: (args) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("SETTOKEN", "false");
        // ignore: use_build_context_synchronously
        setToken(args, context!);
      },
    );
  }

  Future<void> setToken(List<dynamic>? accestoken, BuildContext context) async {
    var token = accestoken![0]["accessToken"];
    var enc = accestoken[0]["encryptedAccessToken"];
    var second = accestoken[0]["expireInSeconds"];
    GlobalParams.setEncryptedToken(enc);
    GlobalParams.setAuthToken(token);
    GlobalParams.setTimeLine(second);
    StorageData.setValue('token', token);
    await UserDataComponent().setAppToken(token);
    await UserDataComponent().setEncrptedAuthToken(enc);
    await buildUserInfomation(token);
    // ignore: use_build_context_synchronously
    await Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey webViewKey = GlobalKey();
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
    );

    return Scaffold(
      key: _key,
      body: Stack(
        children: [
          Center(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri("${AppConst.api}/web-view/login"),
              ),
              initialSettings: settings,
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT,
                );
              },
              // onLoadStop: (controller, url) {
              //   if (!_isLoading) {
              //     setState(() {
              //       _isLoading = true;
              //     });
              //   }
              // },
              onProgressChanged: (controller, progress) {
                Navigator.of(widget.diaglogContext!).pop();
                if (!_isLoading) {
                  if (progress >= 100) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                }
              },
              // ignore: deprecated_member_use
              onLoadError: (controller, url, code, message) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              },
              onReceivedError: (controller, request, error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(error.description)));
              },
              onWebViewCreated: (controller) {
                _webToMobile(controller, context);
              },
            ),
          ),
          // !_isLoading
          //     ? Center(
          //         child: LoadingAnimationWidget.staggeredDotsWave(
          //         color: Colors.black,
          //         size: 100,
          //       ))
          //     : Container()
        ],
      ),
    );
  }
}
