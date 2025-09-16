// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:edu_student/system/base/model/data/data_link_modal.dart';
import 'package:edu_student/system/base/model/data/data_organization_model.dart';
import 'package:object_mapper/object_mapper.dart';

import 'data_group_user_model.dart';


class DataGroupModel with Mappable {
  String? key;
  String? name;
  int numberNotRead;
  String? type;
  DateTime? creationTime;
  DateTime? lastModificationTime;
  String? value;
  String? value1;
  String title = "";
  DataLinkModel? dataLinkModal;

  DataGroupUserModel? member;
  List<DataOrganizationModel>? listOrganization;

  DataGroupModel({
    this.key,
    this.name,
    this.numberNotRead = 0,
    this.type,
    this.creationTime,
    this.lastModificationTime,
    this.value,
    this.value1,
    this.title = "",
    this.member,
    this.listOrganization,
  });

  @override
  void mapping(Mapper map) {
    map("key", key, (v) => key = v);
    map("name", name, (v) => name = v);
    map("numberNotRead", numberNotRead, (v) => numberNotRead = v ?? 0);
    map("type", type, (v) => type = v);
    map("creationTime", creationTime, (v) => creationTime = v, const DateTransform());
    map("lastModificationTime", lastModificationTime,
        (v) => lastModificationTime = v, const DateTransform());
    map("value", value, (v) => value = v);
    map("value1", value1, (v) => value1 = v);
    map<DataGroupUserModel>("member", member, (v) => member = v);
    map("title", title, (v) => title = v ?? "");
  }

  factory DataGroupModel.fromJson(Map<String, dynamic>? jsonInput, int userId) {
    if (jsonInput == null) {
      return DataGroupModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataGroupModel>();

    if (obj != null) {
      if (obj.value != null) {
        try {
          obj.listOrganization =
              (json.decode(obj.value!)["listOrganization"] as Iterable)
                  .map((e) => DataOrganizationModel.fromJson(e))
                  .toList();
        // ignore: empty_catches
        } catch (e) {}
      }

      if (obj.value1 != null) {
        try {
          var listUser = (json.decode(obj.value1!) as Iterable)
              .map((e) => DataGroupUserInfoModal.fromJson(e))
              .toList();

          obj.title = "";
          listUser.where((user) => user.userId != userId).forEach((user) {
            obj.title += "<${user.fullName!}>";
          });

          obj.title = obj.title
              .replaceAll("><", " - ")
              .replaceAll(">", "")
              .replaceAll("<", "");
        // ignore: empty_catches
        } catch (e) {}
      }

      obj.title = obj.title != "" ? obj.title : obj.name!;
    }

    return obj ?? DataGroupModel();
  }

  Map<String, dynamic> toMap() {
    this.value = jsonEncode(this.listOrganization);

    return this.toJson();
  }
}
