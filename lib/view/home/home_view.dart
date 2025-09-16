import 'package:edu_student/controller/bloc/home/home_bloc.dart';
import 'package:edu_student/controller/bloc/home/home_event.dart';
import 'package:edu_student/controller/bloc/webview/webview_bloc.dart';
import 'package:edu_student/controller/bloc/webview/webview_event.dart';
import 'package:edu_student/view/home/layouts/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  HomeView({this.diaglogContext});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeView());
  }

  final viewKey = GlobalKey<FormState>();
  BuildContext? diaglogContext;
  // ignore: unused_field
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) =>
              HomeBloc(context)..add(HomeFetched()),
        ),
        BlocProvider<WebviewBloc>(
          create: (BuildContext context) =>
              WebviewBloc(context)..add(WebviewFetched()),
        ),
      ],
      child: HomeLayout(diaglogContext: diaglogContext,),
    );
  }
}
