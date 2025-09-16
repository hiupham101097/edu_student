import 'package:edu_student/system/base/model/category/criteria.dart';
import 'package:edu_student/system/base/model/category/key_value_model.dart';
import 'package:edu_student/system/base/model/category/token_model.dart';
import 'package:edu_student/system/base/model/city/city_model.dart';
import 'package:edu_student/system/base/model/data/data_device_token_modal.dart';
import 'package:edu_student/system/base/model/data/data_group_user_model.dart';
import 'package:edu_student/system/base/model/data/data_link_modal.dart';
import 'package:edu_student/system/base/model/data/data_menu_modal_.dart';
import 'package:edu_student/system/base/model/data/data_organization_model.dart';
import 'package:edu_student/system/base/model/data/data_tenant_modal.dart';
import 'package:edu_student/system/base/model/data/file_data_model.dart';
import 'package:edu_student/system/base/model/settings/setting_model.dart';
import 'package:edu_student/system/base/model/user/profile_model.dart';
import 'package:edu_student/system/base/model/user/user_data_model.dart';
import 'package:object_mapper/object_mapper.dart';
import '../model/data/data_group_model.dart';

class StartMap {
  static void mapModal() {
    Mappable.factories = {
      KeyValueModal: () => KeyValueModal(),
      DataGetModal: () => DataGetModal(),
      CityModel: () => CityModel(),
      DataDeviceTokenModel: () => DataDeviceTokenModel(),
      DataGroupModel: () => DataGroupModel(),
      DataLinkModel: () => DataLinkModel(),
      DataGroupUserModel: () => DataGroupUserModel(),
      DataMenuModal: () => DataMenuModal(),
      DataOrganizationModel: () => DataOrganizationModel(),
      DataTenantModal: () => DataTenantModal(),

      FileDataModal: () => FileDataModal(),


      SettingModelDto: () => SettingModelDto(),
      SettingJson: () => SettingJson(),
      ProfileModel: () => ProfileModel(0),
      TokenModel: () => const TokenModel(""),
      
      UserDataModal: () => UserDataModal(0, "", ""),
    };
  }
}
