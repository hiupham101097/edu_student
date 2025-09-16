import 'package:edu_student/controller/cubit/login/login.dart';
import 'package:edu_student/system/base/model/login/login_model.dart';
import 'package:edu_student/view/login/layouts/login_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key, this.diaglogContext});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginView());
  }

  static Page page() => MaterialPage<void>(child: LoginView());
  final viewKey = GlobalKey<FormState>();
  BuildContext? diaglogContext;
  @override
    Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<LoginModel>()),
       child: LoginLayout(context, viewKey, diaglogContext: diaglogContext,),
    );
  }
}
