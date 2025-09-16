
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/base/controller/Api/device_token/api_device_token_component.dart';
import 'package:edu_student/system/base/user/user_data_component.dart';
import 'package:edu_student/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../system/_variables/storage/fcm_storage_data.dart';

class MenuControllerCubit extends Cubit {
  MenuControllerCubit() : super(null);

  Future<void> logout() async {
    ApiDeviceTokenComponent().delete(GlobalParams.deviceToken);
    GlobalParams.clearAll();
    /// remove store data on your phone
    await FCMStorageData.removeToken();
    await FCMStorageData.removeDeviceId();
    await UserDataComponent().removeAppToken();

  }

  void userLogout(BuildContext context) async {

    ApiDeviceTokenComponent().delete(GlobalParams.deviceToken);
    GlobalParams.clearAll();
    /// remove store data on your phone
    await FCMStorageData.removeToken();
    await FCMStorageData.removeDeviceId();
    await UserDataComponent().removeAppToken();



    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
