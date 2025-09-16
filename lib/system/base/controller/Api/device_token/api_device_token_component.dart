import 'dart:convert';

import 'package:edu_student/system/_variables/http/app_http_model.dart';
import 'package:edu_student/system/_variables/http/hub_app_http.dart';
import 'package:edu_student/system/base/model/data/data_device_token_modal.dart';
import 'package:edu_student/system/base/user/user_data_component.dart';


class ApiDeviceTokenComponent {
  Future<AppHttpModel<dynamic>> createOrUpdate(
      DataDeviceTokenModel input) async {
    final response = await HubAppHttp.getData(
        'api/services/HUB/write/DeviceToken/CreateOrUpdate',
        input.toMap(),
        await UserDataComponent().getAppToken());

    if (response.statusCode == 200) {
      return AppHttpModel(json.decode(response.body)['result']);
    } else {
      return AppHttpModel.getError(response.body);
    }
  }

  Future<AppHttpModel<dynamic>> delete(DataDeviceTokenModel deviceToken) async {
    final response = await HubAppHttp.getData(
        'api/services/HUB/write/DeviceToken/Delete',
        deviceToken.toMap(),
        await UserDataComponent().getAppToken());

    if (response.statusCode == 200) {
      return AppHttpModel(json.decode(response.body)['result']);
    } else {
      return AppHttpModel.getError(response.body);
    }
  }
}
