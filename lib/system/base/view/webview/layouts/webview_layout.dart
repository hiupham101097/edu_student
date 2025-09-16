import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:edu_student/system/base/view/default_view/view_error.dart';
import 'package:edu_student/system/base/view/default_view/view_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../controller/bloc/webview/webview_bloc.dart';
import '../../../../../controller/bloc/webview/webview_event.dart';
import '../../../../../controller/bloc/webview/webview_state.dart';
import '../../../../../main.dart';
import '../../../../_variables/value/app_style.dart';
import '../../../controller/functions/setToken.dart';
import '../../../controller/functions/size/screen_width.dart';
import '../../../controller/functions/webToMobile.dart';
import '../../../model/category/status_bloc.dart';


// ignore: must_be_immutable
class AppWebViewLayout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  AppWebViewLayout({super.key, this.url, this.checkChat});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _AppWebViewLayout(checkChat);

  GlobalKey<FormState>? viewKey;
  BuildContext? diaglogContext;
  String? url;
  String? checkChat;
}

// ignore: unused_element

class _AppWebViewLayout extends State<AppWebViewLayout> {
  _AppWebViewLayout( this.checkChat);

  String? title;
  double length = 0;
  bool isCheck = false;
  XFile? imageFile;
  String? checkChat;
  bool? isChat;

  final GlobalKey webViewKey = GlobalKey();
  final TextEditingController _txtChat = TextEditingController();

  double progress = 0;
  final urlController = TextEditingController();

  Timer? _timer;
  int? _progress = 0;

  final int _totalActionTimeInSeconds = 3;
  dynamic ctrl;
  bool? checkData;
  final ReceivePort _port = ReceivePort();
  InAppWebViewController? webViewController;
  TokenAuth? setData;

  @override
  void initState() {
    super.initState();
    SetToken().setToken().then((value) {
      setData = value;
      setState(() {}); // để rebuild UI
    });

    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _txtChat.addListener(() {
      isCheck = _txtChat.text.isNotEmpty;
      // ignore: unnecessary_this
      setState(() => this.isCheck = isCheck);

      context.read<WebviewBloc>().add(WebviewModelChange("V"));
    });
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      // ignore: avoid_print
      print("Download progress: $progress%");

      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download $id completed!"),
        ));
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  var userAgent = Platform.isIOS == true
      ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
      : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  void _initCounter() {
    _timer?.cancel();
    _progress = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _progress = _progress! + 100);

      if (Duration(milliseconds: _progress!).inSeconds >=
          _totalActionTimeInSeconds) {
        _timer!.cancel();
        // Do something
      }
    });
  }

  void _stopCounter() {
    _timer?.cancel();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    setState(() => _progress = 0);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _txtChat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PullToRefreshController? pullToRefreshController;
    final screenWidth = MediaQuery.of(context).size.width;
    var length = ScreenWidth.setScreen(screenWidth);

    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
    return Card(
      color: AppStyle.colors[0][4],
      child: BlocBuilder<WebviewBloc, WebviewState>(builder: (context, state) {
        switch (state.status) {
          case BlocStatus.failure:
            return viewError(context);
          case BlocStatus.success:
            // ignore: deprecated_member_use
            return SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                      children: [
                        InAppWebView(
                          key: webViewKey,
                          initialUserScripts:
                              UnmodifiableListView<UserScript>([]),
                          initialSettings: settings,
                          pullToRefreshController: pullToRefreshController,
                          initialUrlRequest: URLRequest(
                              url: WebUri.uri(Uri.parse(widget.url.toString()))),
                          // initialOptions: options,
                          onPermissionRequest: (controller, request) async {
                            return PermissionResponse(
                                resources: request.resources,
                                action: PermissionResponseAction.GRANT);
                          },
                          onWebViewCreated: (controller) async {
                            webViewController = controller;
                            webViewMainController = controller;
                            await WebToMobile.webToMobile(
                                controller, context, checkChat, title, state);
                          },

                          onLoadStop: ((controller, url) async {
                            final prefs = await SharedPreferences.getInstance();
                            // ignore: unused_local_variable
                            var value = prefs.getString(
                              "SETTOKEN",
                            );

                            MobileToweb.mobiToWeb(
                              controller,
                              "SETTOKEN",
                              setData!.token,
                              data2: setData!.encAuthToken,
                              data3: setData!.tenant.toString(),
                            );
                          }),
                          shouldOverrideUrlLoading:
                              (controller, navigationAction) async {
                            var uri = navigationAction.request.url!;

                            if (![
                              "http",
                              "https",
                              "file",
                              "chrome",
                              "data",
                              "javascript",
                              "about"
                            ].contains(uri.scheme)) {
                              if (await canLaunchUrl(uri)) {
                                // Launch the App
                                await launchUrl(
                                  uri,
                                );
                                // and cancel the request
                                return NavigationActionPolicy.CANCEL;
                              }
                            }

                            return NavigationActionPolicy.ALLOW;
                          },
                          onProgressChanged: (controller, progress) {
                            if (progress == 100) {
                              pullToRefreshController?.endRefreshing();
                            }
                            setState(() {
                              this.progress = progress / 100;
                              urlController.text = widget.url!;
                            });
                          },
                          onDownloadStartRequest:
                              (controller, downloadStartRequest) async {
                            // Plugin must be initialized before using
                            var hasStoragePermission =
                                await Permission.storage.isGranted;
                            if (!hasStoragePermission) {
                              final status = await Permission.storage.request();
                              hasStoragePermission = status.isGranted;
                            }
                          },
                        ),
                        progress < 1.0
                            ? LinearProgressIndicator(value: progress)
                            : Container(),
                      ],
                    )),
                    checkChat == "chat"
                        ? GestureDetector(
                            onTapDown: (_) => _initCounter(),
                            onTapUp: (_) => _stopCounter(),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  color: AppStyle.colors[1][0],
                                  border:
                                      Border.all(color: AppStyle.colors[1][6])),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: AppStyle.colors[1]
                                                [4],
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    14,
                                                10)),
                                        onPressed: () {
                                          webViewController!.evaluateJavascript(
                                            source: 'openModalFile()',
                                          );
                                        },
                                        child: Icon(
                                          Icons.file_upload,
                                          size: 13,
                                          color: AppStyle.colors[1][7],
                                        ),
                                      ),
                                      Container(
                                          width: length,
                                          padding: const EdgeInsets.all(5),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_txtChat.text != "") {
                                                  isCheck = true;
                                                } else {
                                                  isCheck = false;
                                                }
                                                context.read<WebviewBloc>().add(
                                                    WebviewModelChange("V"));
                                              });
                                            },
                                            child: TextFormField(
                                              controller: _txtChat,
                                              focusNode: FocusNode(),
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0.0),
                                                border: InputBorder.none,
                                                hintText:
                                                    "Nhập nội dung tin nhắn",
                                                hintStyle:
                                                    TextStyle(fontSize: 13),
                                              ),
                                              scrollPadding:
                                                  const EdgeInsets.all(10),
                                              style:
                                                  const TextStyle(fontSize: 15),
                                              maxLines: 9999,
                                              minLines: 1,
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                          ))
                                    ],
                                  ),
                                  _txtChat.text == ""
                                      ? TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppStyle.colors[2][0],
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  10)),
                                          onPressed: () {
                                            webViewController!
                                                .evaluateJavascript(
                                                    source: 'sendLikeEvent()');
                                            // dataWebviewController!
                                            //     .evaluateJavascript(
                                            //         'sendLikeEvent()');
                                          },
                                          child: const Icon(
                                            Icons.thumb_up_alt_outlined,
                                            size: 13,
                                          ),
                                        )
                                      : TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppStyle.colors[2][0],
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  10)),
                                          onPressed: () {
                                            webViewController!.evaluateJavascript(
                                                source:
                                                    'sendEvent("${_txtChat.text}")');
                                            // dataWebviewController!
                                            //     .evaluateJavascript(
                                            //         'sendEvent("${_txtChat.text}")');
                                            _txtChat.text = "";
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            size: 13,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              );

          default:
            return viewDefault(title);
        }
      }),
    );
  }
}
