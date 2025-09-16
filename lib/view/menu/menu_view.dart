import 'package:edu_student/controller/cubit/menu/menu_cubit.dart';
import 'package:edu_student/view/menu/layouts/menu_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class MenuView extends StatelessWidget {
  final BuildContext? _context;

  final viewKey = GlobalKey<FormState>();
  // ignore: use_super_parameters
  MenuView({Key? key, BuildContext? context})
      : _context = context,
        super(key: key);

  static Page page() => MaterialPage<void>(child: MenuView());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuControllerCubit(),
      child: MenuLayout( viewKey, _context),
    );
  }
}
