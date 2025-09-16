import 'package:edu_student/controller/bloc/webview/webview_bloc.dart';
import 'package:edu_student/controller/bloc/webview/webview_event.dart';
import 'package:edu_student/view/webview/layouts/webview_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class WebviewView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  WebviewView({this.title, this.url, this.checkChat});

  final viewKey = GlobalKey<FormState>();
  String? url;
  String? title;
  String? checkChat;
  // ignore: unused_field
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<WebviewBloc>(
          create: (BuildContext context) => WebviewBloc(context)..add(WebviewFetched()),
        ),
      ],
      child: WebviewLayout(url: url, title: title, checkChat: checkChat,),
    );
  }
}
