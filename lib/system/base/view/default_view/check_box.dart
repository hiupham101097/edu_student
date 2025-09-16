
import 'package:flutter/material.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:edu_student/system/base/model/login/login_model.dart';

class RememberMeCheckbox extends StatefulWidget {
  final void Function(bool) onRememberChanged;
  final String? emailAddress;
  final String? password;

  const RememberMeCheckbox({
    super.key,
    required this.onRememberChanged,
    required this.emailAddress,
    required this.password,
  });

  @override
  State<RememberMeCheckbox> createState() =>
  // ignore: no_logic_in_create_state
  _RememberMeCheckboxState(emailAddress: emailAddress, password: password);
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool isRemember = false;

  _RememberMeCheckboxState({
    required this.emailAddress,
    required this.password,
  });
  final String? emailAddress;
  final String? password;

  LoginModel? login = LoginModel();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isRemember = !isRemember;
          login!.userName = emailAddress;
          login!.password = password;
          GlobalParams.setUserLogin(login!);
        });

        widget.onRememberChanged(isRemember);
      },
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: isRemember ? AppStyle.colors[2][5] : null,
              borderRadius: BorderRadius.circular(6),
              border:
                  !isRemember ? Border.all(color: AppStyle.colors[1][0]) : null,
            ),
            child:
                isRemember
                    ? Icon(Icons.done, size: 14, color: AppStyle.colors[1][0])
                    : null,
          ),
          const SizedBox(width: 10),
          Text(
            'Ghi nhớ đăng nhập',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: AppStyle.colors[1][0],
            ),
          ),
        ],
      ),
    );
  }
}
