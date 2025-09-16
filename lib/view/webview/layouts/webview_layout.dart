// ignore_for_file: constant_pattern_never_matches_value_type
import 'package:edu_student/controller/bloc/webview/webview_bloc.dart';
import 'package:edu_student/controller/bloc/webview/webview_state.dart';
import 'package:edu_student/system/base/view/default_view/view_error.dart';
import 'package:edu_student/system/base/view/default_view/view_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../../system/_variables/value/app_style.dart';
import '../../../system/_variables/value/text_app_data.dart';
import '../../../system/base/controller/functions/callback.dart';
import '../../../system/base/model/category/status_bloc.dart';
import '../../../system/base/view/webview/layouts/webview_layout.dart';
import '../../chatbot/chat_bot_view.dart';
import '../../menu/menu_view.dart';

// ignore: must_be_immutable
class WebviewLayout extends StatefulWidget {
  WebviewLayout({super.key, this.title, this.url, this.checkChat});

  String? title;
  String? url;
  String? checkChat;

  @override
  State<StatefulWidget> createState() => _WebviewLayoutState();
}

class _WebviewLayoutState extends State<WebviewLayout> {
  final viewKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewBloc, WebviewState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.failure:
            return viewError(context);
          case BlocStatus.success:
            // ignore: deprecated_member_use
            return WillPopScope(
              onWillPop: () => CallBack.willPopCallback(
                widget.url,
                webViewMainController!,
                context,
              ),
              child: Scaffold(
                key: _key,
                backgroundColor: AppStyle.colors[1][0],
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  titleSpacing: 0.0,
                  elevation: 1.0,
                  backgroundColor: AppStyle.colors[0][4],

                  title: Text(
                    TextAppData.getValue(widget.title.toString()),
                    style: TextStyle(color: AppStyle.colors[1][0]),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.support_agent,
                        color: AppStyle.colors[1][0],
                      ),
                      onPressed: () {
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ChatBotView(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(
                                    1.0,
                                    0.0,
                                  ); // 👈 Trái ➝ phải
                                  const end = Offset.zero;
                                  final tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: Curves.easeInOut));
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                drawer: Drawer(
                  backgroundColor: AppStyle.colors[1][0],
                  child: MenuView(),
                ),
                body: AppWebViewLayout(
                  key: viewKey,
                  url: widget.url.toString(),
                  checkChat: widget.checkChat,
                ),
              ),
            );
          default:
            return viewDefault(widget.title);
        }
      },
    );
  }
}
