import 'package:edu_student/controller/cubit/menu/menu_cubit.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:edu_student/system/base/model/settings/setting_model.dart';
import 'package:edu_student/system/base/view/default/default_view.dart';
import 'package:edu_student/view/profile/profile_view.dart';
import 'package:flutter/material.dart';
import '../../chatbot/chat_bot_view.dart';
import '../../webview/webview_view.dart';

// ignore: must_be_immutable
class MenuLayout extends DefaultView {
  // ignore: unused_field
  GlobalKey<FormState>? viewKey;
  // ignore: unused_field
  final BuildContext? _context;

  // ignore: use_key_in_widget_constructors
  MenuLayout(GlobalKey<FormState>? key, BuildContext? context)
    : _context = context,
      super() {
    key = viewKey;
  }

  static getToken() async {
    return await GlobalParams.getAuthToken();
  }

  static getPermision() async {
    return await GlobalParams.getPermision();
  }

  static joinUrl(context, title, url, value2, viewKey) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            WebviewView(title: title, url: url, checkChat: value2),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // 👈 Phải ➝ trái
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
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/menu5.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 65.0,
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/logo.png'),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "EDU",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      "Email:  ${GlobalParams.getUserData()!.emailAddress.toString()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5.0),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      "Name: ${GlobalParams.getUserData()!.fullName.toString()}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Column(
          children: buildMenuItems(
            context,
            GlobalParams.listUrl
                .where((ww) => ww.code!.contains('MENUEDUSTUDENT'))
                .toList(),
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: Row(
              children: [
                const Icon(Icons.support_agent, color: Color(0xFF95D4D4), size: 20),
                // ignore: avoid_unnecessary_containers
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text("Tư vấn"),
                ),
              ],
            ),
            onPressed: () async {
              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ChatBotView(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); // 👈 Trái ➝ phải
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
        ),
        Divider(
          color: AppStyle.colors[1][4],
          thickness: 1,
          endIndent: 0,
          indent: 0,
          height: 0,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: Row(
              children: [
                const Icon(
                  Icons.help_outline,
                  color: Color(0xFF95D4D4),
                  size: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text("Hướng dẫn sử dụng"),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
        Divider(
          color: AppStyle.colors[1][4],
          thickness: 1,
          endIndent: 0,
          indent: 0,
          height: 0,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user,
                  color: Color(0xFF95D4D4),
                  size: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text("Thông tin tài khoản"),
                ),
              ],
            ),
            onPressed: () async {
              await Navigator.of(context).push(ProfileView.route());
            },
          ),
        ),
        Divider(
          color: AppStyle.colors[1][4],
          thickness: 1,
          endIndent: 0,
          indent: 0,
          height: 0,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: Row(
              children: [
                const Icon(
                  Icons.exit_to_app,
                  color: Color(0xFF95D4D4),
                  size: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text("Đăng xuất"),
                ),
              ],
            ),
            onPressed: () {
              MenuControllerCubit().userLogout(context);
            },
          ),
        ),
        Divider(
          color: AppStyle.colors[1][4],
          thickness: 1,
          endIndent: 0,
          indent: 0,
          height: 0,
        ),
      ],
    );
  }

  List<Widget> buildMenuItems(BuildContext context, List<SettingJson> menus) {
    var rows = <Widget>[];


    // ignore: avoid_function_literals_in_foreach_calls
    menus.forEach((item) {
      rows.add(
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: TextButton(
            child: Row(
              children: [
                const Icon(Icons.circle, color: Color(0xFF95D4D4), size: 20),
                // ignore: avoid_unnecessary_containers
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(item.name.toString()),
                ),
              ],
            ),
            onPressed: () async {
              joinUrl(
                context,
                item.name.toString(),
                item.code!.contains('TUITION') == true ? item.url! + GlobalParams.getUserData()!.id.toString() : item.url,
                "task",
                viewKey,
              );
            },
          ),
        ),
      );

      rows.add(
        Divider(
          color: AppStyle.colors[1][4],
          thickness: 1,
          endIndent: 0,
          indent: 0,
          height: 0,
        ),
      );
    });

    return rows;
  }
}
