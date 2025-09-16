import 'dart:convert';
import 'dart:io';

import 'package:edu_student/system/_variables/http/app_http_model.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/base/controller/Api/device_token/api_device_token_component.dart';
import 'package:edu_student/system/base/controller/Api/setting/setting_base_api.dart';
import 'package:edu_student/system/base/controller/Api/user/user_component.dart';
import 'package:edu_student/system/base/model/settings/setting_model.dart';
import 'package:edu_student/system/base/model/user/user_data_model.dart';
import 'package:edu_student/system/base/user/user_data_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../_variables/storage/fcm_storage_data.dart';

Future<void> buildUserInfomation(String accessToken) async {
  BuildContext? context;
  AppHttpModel<UserDataModal>? userResult;
  AppHttpModel<SettingModelDto>? setting;

  int count = 0;
  while (count != -1 && count < 5) {
    try {
      userResult = await UserComponent().getCurrentUser();

      // ignore: unnecessary_null_comparison
      if (userResult != null &&
          userResult.status == AppHttpModelStatus.Success &&
          userResult.value != null &&
          userResult.value!.id != 0) {
        count = -1;

        GlobalParams.setAuthToken(accessToken);
        // ignore: unused_local_variable
        GlobalParams.setEncryptedToken(
          await UserDataComponent().getEncrptedAuthToken(),
        );
        // ignore: prefer_interpolation_to_compose_strings, unused_local_variable
        var token = await GlobalParams.getAuthToken();
        var encry = GlobalParams.getEncryptedToken();
        // ignore: unused_local_variable
        var dataToken =
            'accessToken=${Uri.encodeComponent(token!.replaceAll("Bearer", "").trim())}&encryptedAccessToken=${Uri.encodeComponent(encry!)}';

        GlobalParams.setUserData(userResult.value!);
        if (userResult.value!.listInformation != null) {
          var data = userResult.value!.listInformation!
              .where((e) => e.key!.contains('Type'))
              .firstOrNull;
          if (data != null) {
            var type = json.decode(data.value!);
            if (type.length == 2) {
              GlobalParams.setPermision(
                type[0] == 'EMPLOYEE' && type[1] == 'TEACHER' ? true : false,
              );
            }
          }
        }
        // ignore: unnecessary_new
        String deviceId = await FCMStorageData.getDeviceId();
        String? firebaseToken = GlobalParams.getFirebaseToken();

        GlobalParams.deviceToken
          ..value = firebaseToken ?? ""
          ..deviceId = deviceId
          ..type = Platform.isIOS ? 'IOS' : 'ANDROID';
        // ignore: unnecessary_null_comparison
        if (deviceId == null || deviceId == "") {
          /// send token to server
          await ApiDeviceTokenComponent().createOrUpdate(
            GlobalParams.deviceToken,
          );
        }
        setting = await SettingBaseApi().getTenantByName();

        var apiKey = setting.value!.listUrl!
            .where((w) => w.code!.contains("EDUKEYGEMINI"))
            .firstOrNull;

        Gemini.init(apiKey: apiKey!.url.toString(), enableDebugging: true);
        GlobalParams.setListUrl(setting.value!.listUrl!);
      } else {
        count = -1;

        await UserDataComponent().removeAppToken();

        if (userResult.status != AppHttpModelStatus.Success) {
          // ignore: use_build_context_synchronously
          await showDialog<String>(
            // ignore: use_build_context_synchronously
            context: context!,
            builder: (BuildContext context) => AlertDialog(
              title: Text(userResult!.message!),
              content: Text(userResult.details!),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }

      if (count != -1) {
        count++;
      }
    } catch (err) {
      if (count != -1) {
        count++;
      }
    }
  }
}
