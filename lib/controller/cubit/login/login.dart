import 'package:edu_student/system/base/model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginModel> {
  LoginCubit(this._loginModel) : super(LoginModel());

  // ignore: unused_field
  final LoginModel _loginModel;

  void gotoChangePassWord(BuildContext context) {
    // var url = EduMobileAppHttp.eduUrl("");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => AppWebView(
    //             url: url,
    //             title: "Dổi mật khẩu",
    //             checkChat: "task",
    //           )),
    // );
  }

  void gotoCreate(BuildContext context) {
    // var url = EduMobileAppHttp.eduUrl("/account/register");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => AppWebView(
    //             url: url,
    //             title: "Đăng ký",
    //             checkChat: "task",
    //           )),
    // );
  }
}
