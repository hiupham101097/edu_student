import 'package:edu_student/controller/bloc/profile/profile_bloc.dart';
import 'package:edu_student/controller/bloc/profile/profile_event.dart';
import 'package:edu_student/view/profile/layouts/profile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key,})  : 
        super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ProfileView(
            ));
  }

  final viewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(context, )..add(ProfileFetched()),
      child: ProfileLayout(viewKey),
    );
  }
}
