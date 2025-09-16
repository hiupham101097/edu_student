

import 'package:edu_student/controller/bloc/profile/profile_bloc.dart';
import 'package:edu_student/controller/bloc/profile/profile_event.dart';
import 'package:edu_student/controller/bloc/profile/profile_state.dart';
import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:edu_student/system/_variables/value/text_app_data.dart';
import 'package:edu_student/view/menu/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfileLayout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  ProfileLayout(GlobalKey<FormState>? key)
      : super() {
    viewKey = key;
  }
  GlobalKey<FormState>? viewKey;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ProfileLayout(viewKey);
}

class _ProfileLayout extends State<ProfileLayout> {
  _ProfileLayout(GlobalKey<FormState>? key) {
    viewKey = key;
  }
  GlobalKey<FormState>? viewKey;
  String? selectRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      switch (state.status) {
        case ProfileStatus.failure:
          return Container(
            padding: const EdgeInsets.only(top: 50),
            // ignore: prefer_const_constructors
            child: Column(
              children: const [
                Center(child: Text("kết nối gặp lỗi, Vui lòng chờ đợi")),
                Center(child: CircularProgressIndicator())
              ],
            ),
          );
        case ProfileStatus.success:
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
                elevation: 1,
                backgroundColor: AppStyle.colors[0][4],
                title: Text(
                  TextAppData.getValue("profile"),
                )),
            drawer: Drawer(
                child: MenuView()),
            body: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                itemCount: 1,
                // ignore: avoid_unnecessary_containers
                itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Text(TextAppData.getValue("userName")),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15),
                            height: 47,
                            child: Text(
                              state.profileModel!.emailAddress!,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppStyle.colors[0][4],
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Text(TextAppData.getValue("fullName")),
                          ),
                          Container(
                            child: state.view != "V"
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 47,
                                    child: Text(
                                      state.profileModel!.fullName!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: AppStyle.colors[0][4],
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    width: 250,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: state.profileModel!.fullName),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      state.view == ""
                          ? const Divider(
                              height: 3,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Text(TextAppData.getValue("email")),
                          ),
                          Container(
                            child: state.view != "V"
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 47,
                                    child: Text(
                                      state.profileModel!.emailAddress!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: AppStyle.colors[0][4],
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    width: 250,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text:
                                              state.profileModel!.emailAddress),
                                      keyboardType: TextInputType.emailAddress,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      state.view == ""
                          ? const Divider(
                              height: 3,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Text(TextAppData.getValue("phone")),
                          ),
                          Container(
                            child: state.view != "V"
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 47,
                                    child: Text(
                                      state.profileModel!.phoneNumber!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: AppStyle.colors[0][4],
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    width: 250,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text:
                                              state.profileModel!.phoneNumber),
                                      keyboardType: TextInputType.phone,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      state.view == ""
                          ? const Divider(
                              height: 3,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Text(TextAppData.getValue("address")),
                          ),
                          Container(
                            child: state.view != "V"
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 47,
                                    child: Text(
                                      state.profileModel!.address!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: AppStyle.colors[0][4],
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    width: 250,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: state.profileModel!.address),
                                      keyboardType: TextInputType.streetAddress,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      state.view == ""
                          ? const Divider(
                              height: 3,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                          child: state.view != "V"
                              ? Container(
                                  height: 33,
                                  decoration: BoxDecoration(
                                      color: AppStyle.colors[0][1],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3))),
                                  child: TextButton(
                                    child: Text(
                                      TextAppData.getValue(
                                        "edit",
                                      ),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ProfileBloc>()
                                          .add(ProfileModelChange("V"));
                                    },
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33,
                                      decoration: BoxDecoration(
                                          color: AppStyle.colors[0][1],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3))),
                                      child: TextButton(
                                        child: Text(
                                          TextAppData.getValue(
                                            "save",
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          context.read<ProfileBloc>().add(
                                              ButtonProfileSave(
                                                  state.profileModel!, ""));
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        height: 33,
                                        decoration: BoxDecoration(
                                            color: AppStyle.colors[2][2],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3))),
                                        child: TextButton(
                                          child: Text(
                                            TextAppData.getValue(
                                              "cancelEdit",
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<ProfileBloc>()
                                                .add(ProfileModelChange(""));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                    ],
                  ),
                ),
              ),
            ),
          );
        default:
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 1,
              backgroundColor: AppStyle.colors[0][4],
              title: Text(TextAppData.getValue("profile")),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
      }
    });
  }
}
