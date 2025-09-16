import 'package:edu_student/controller/bloc/home/home_bloc.dart';
import 'package:edu_student/controller/bloc/home/home_state.dart';
import 'package:edu_student/system/_variables/value/app_const.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:edu_student/system/_variables/value/text_app_data.dart';
import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:edu_student/view/menu/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../system/base/view/webview/layouts/webview_layout.dart';
import '../../chatbot/chat_bot_view.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class HomeLayout extends StatefulWidget {
  HomeLayout({super.key, this.diaglogContext});
  GlobalKey<FormState>? viewKey;
  BuildContext? diaglogContext;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  State<StatefulWidget> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  GlobalKey<FormState>? viewKey;

  @override
  void initState() {
    super.initState();
    setState(() {}); // để rebuild UI
  }

  @override
  Widget build(Object context) {
    var url = '${AppConst.urlEDU}/webview/home';

    if (widget.diaglogContext != null) {
      Navigator.of(widget.diaglogContext!).pop();
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.failure:
            return Scaffold(
              backgroundColor: AppStyle.colors[0][4],
              appBar: AppBar(
                automaticallyImplyLeading: true,
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title: Text(TextAppData.getValue("home")),
              ),
              body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ925rJ2StQ_G3Z11SkP5BDHZE08isHL7MbpA&s',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Shoe Details',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Shoe Details description',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(backgroundColor: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            );
          case BlocStatus.success:
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                titleSpacing: 0.0,
                elevation: 1.0,
                backgroundColor: AppStyle.colors[0][4],
                title:
                    // ignore: avoid_unnecessary_containers
                    Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
                      child: Text(
                        TextAppData.getValue("home"),
                        style: TextStyle(color: AppStyle.colors[1][0]),
                      ),
                    ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.support_agent, color: AppStyle.colors[1][0]),
                    onPressed: () {
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ChatBotView(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                url: url.toString(),
                checkChat: "task",
              ),
            );
          default:
            return Scaffold(
              backgroundColor: AppStyle.colors[0][4],
              appBar: AppBar(
                automaticallyImplyLeading: true,
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title: Text(
                  TextAppData.getValue("home"),
                  style: TextStyle(color: AppStyle.colors[1][0]),
                ),
              ),
              drawer: Drawer(child: MenuView()),
              body: Card(
                color: AppStyle.colors[0][4],
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.black),
                  itemCount: 1,
                  itemBuilder: (context, index) =>
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Center(child: CircularProgressIndicator()),
                        // ignore: avoid_unnecessary_containers
                      ),
                ),
              ),
            );
        }
      },
    );
  }
}
