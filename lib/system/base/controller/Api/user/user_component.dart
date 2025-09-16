import 'dart:convert';

import 'package:edu_student/system/_variables/http/app_http_model.dart';
import 'package:edu_student/system/_variables/http/sso_app_http.dart';
import 'package:edu_student/system/base/model/category/criteria.dart';
import 'package:edu_student/system/base/model/category/token_model.dart';
import 'package:edu_student/system/base/model/login/login_model.dart';

import 'package:edu_student/system/base/model/user/user_data_model.dart';
import 'package:edu_student/system/base/user/user_data_component.dart';


import '../../../model/data/data_menu_modal_.dart';
class UserComponent {
  UserComponent();

  Future<AppHttpModel<TokenModel>> userLogin(
    LoginModel data,
  ) async {
    final response = await SSOAppHttp.getData(
      'api/TokenAuth/Authenticate',
      data.toMap(),
      null,
    );

    if (response.statusCode == 200) {
      return AppHttpModel<TokenModel>(
        TokenModel.fromJson(
          json.decode(response.body)["result"],
        ),
      );
    } else {
      return AppHttpModel.getError<TokenModel>(response.body);
    }
  }

  Future<AppHttpModel<bool>> saveCurrenProfile(Map input) async {
    final response = await SSOAppHttp.getData(
      'api/services/sso/write/User/UpdateInfo',
      input,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      return AppHttpModel<bool>(
        true,
      );
    } else {
      return AppHttpModel.getError<bool>(response.body);
    }
  }

  Future<AppHttpModel<List<UserDataModal>>> getByListUserId(
      List<int?> listUserId) async {
    final response = await SSOAppHttp.getData(
        'api/services/sso/read/User/GetByListUserId',
        listUserId,
        await UserDataComponent().getAppToken());

    var content = json.decode(response.body)['result'];

    content.forEach((item) {
      item["isEmailConfirmed"] = true;
    });

    if (response.statusCode == 200) {
      List<UserDataModal> items =
          (content as Iterable).map((e) => UserDataModal.fromJson(e)).toList();

      return AppHttpModel<List<UserDataModal>>(items);
    } else {
      return AppHttpModel.getError<List<UserDataModal>>(response.body);
    }
  }

  Future<AppHttpModel<UserDataModal>> getCurrentUser() async {
    final response = await SSOAppHttp.getData(
      'api/services/sso/read/User/GetCurrentUser',
      null,
      await UserDataComponent().getAppToken(),
    );

    if (response.statusCode == 200) {
      return AppHttpModel<UserDataModal>(
        UserDataModal.fromJson(
          json.decode(response.body)["result"],
        ),
      );
    } else {
      return AppHttpModel.getError<UserDataModal>(response.body);
    }
  }

    Future<AppHttpModel<List<DataMenuModal>>> getUserMenus() async {
    // ignore: unnecessary_new
    var getMenuModal = new DataGetModal(
      criterias: [
        DataCriteriaModal(
          propertyName: "groupCode",
          operation: "Contains",
          value: "EDU",
        ),
      ],
    );

    final response = await SSOAppHttp.getData(
      'api/services/sso/read/Menu/GetList',
      getMenuModal.toMap(),
      await UserDataComponent().getAppToken(),
    );

    var content = json.decode(response.body);

    if (response.statusCode == 200) {
      List<DataMenuModal> items = (content['result'] as Iterable)
          .map((e) => DataMenuModal.fromJson(e))
          .toList();

      return AppHttpModel<List<DataMenuModal>>(items);
    } else {
      return AppHttpModel.getError<List<DataMenuModal>>(response.body);
    }
  }
}
