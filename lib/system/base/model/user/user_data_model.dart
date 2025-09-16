import 'dart:convert';
import 'package:edu_student/system/base/model/category/key_value_model.dart';
import 'package:edu_student/system/base/model/data/data_tenant_modal.dart';
import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

// ignore: must_be_immutable
class UserDataModal extends Equatable with Mappable {
  late int? id;
  String? userName;
  String? fullName;
  String? emailAddress;
  String? phoneNumber;
  String? address;

  int? tenantId;
  String? typeFamily;
  String? profiles;
  String? contacts;
  String? organization;
  String? name;
  String? surname;
  bool isActive;
  bool isEmailConfirmed;
  String? eduRole;
  String? titleFamily;
  DataTenantModal? tenant;
  List<DataTenantModal>? listTenant;
  
  List<KeyValueModal>? listInformation;

  UserDataModal(
    this.id,
    this.userName,
    this.fullName, {
    this.name,
    this.surname,
    this.emailAddress,
    this.phoneNumber,
    this.address,
    this.typeFamily,
    this.profiles,
    this.contacts,
    this.eduRole,
    this.titleFamily,
    this.listInformation,
    this.tenantId,
    this.tenant,
    this.listTenant,
    this.isActive = false,
    this.isEmailConfirmed = false,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("userName", userName, (v) => userName = v);
    map("name", name, (v) => name = v);
    map("surname", surname, (v) => surname = v);
    map("fullName", fullName, (v) => fullName = v);
    map("emailAddress", emailAddress, (v) => emailAddress = v);
    map("phoneNumber", phoneNumber, (v) => phoneNumber = v);
    map("typeFamily", typeFamily, (v) => typeFamily = v);
    map("profiles", profiles, (v) => profiles = v);
    map("contacts", contacts, (v) => contacts = v);
    map("tenantId", tenantId, (v) => tenantId = v);
    map<KeyValueModal>("listInformation", listInformation, (v) => listInformation = v);
    // map("isActive", isActive, (v) => isActive = v);
    // map("isEmailConfirmed", isEmailConfirmed, (v) => isEmailConfirmed = v);
    //map("isActive", isActive, (v) => isActive = v);
    map<DataTenantModal>(
        // ignore: unnecessary_new
        "tenant", tenant, (v) => tenant = v ?? new DataTenantModal());
    map<DataTenantModal>(
        "listTenant", listTenant, (v) => listTenant = v ?? <DataTenantModal>[]);
  }

  factory UserDataModal.fromJson(
    Map<String, dynamic>? jsonInput,
  ) {
    if (jsonInput == null) return UserDataModal(null, null, null);

    var user = Mapper.fromJson(jsonInput).toObject<UserDataModal>();

    if (jsonInput["profiles"] != null) {
      List<KeyValueModal> list = (jsonDecode(jsonInput["profiles"]) as Iterable)
          .map((item) => KeyValueModal.fromJson(item))
          .toList();
      var address = list.firstWhere((item) => item.key == "ADDRESS");
      user!.address = address.value ?? "";
    } else {
      user!.address = "";
    }

    if (jsonInput["listInformation"] != null) {
      List<KeyValueModal> list = (jsonInput["listInformation"] as Iterable)
          .map((item) => KeyValueModal.fromJson(item))
          .toList();

      var type = list.firstWhere((element) => element.key == "Type");
      if (type.value != null) {
        if (type.value!.toUpperCase().contains('STUDENT')) {
          user.eduRole = 'STUDENT';
        } else if (type.value!.toUpperCase().contains('PARENT')) {
          user.eduRole = 'PARENT';
        } else if (type.value!.toUpperCase().contains('FATHER')) {
          user.eduRole = 'PARENT';
          user.titleFamily = 'Bố';
        } else if (type.value!.toUpperCase().contains('MOTHER')) {
          user.eduRole = 'PARENT';
          user.titleFamily = 'Mẹ';
        } else {
          user.eduRole = 'TEACHER';
        }
      }
    }

    return user;
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        fullName,
        name,
        surname,
        emailAddress,
        phoneNumber,
        address,
        typeFamily,
        profiles,
        contacts,
        eduRole,
        titleFamily,
        tenantId,
        isActive,
        isEmailConfirmed
      ];

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_new, prefer_collection_literals
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["userName"] = userName;
    map["fullName"] = fullName;

    map["name"] = name;
    map["surname"] = surname;
    map["emailAddress"] = emailAddress;
    map["phoneNumber"] = phoneNumber;
    map["tenantId"] = tenantId;

    map["eduRole"] = eduRole;
    map["titleFamily"] = titleFamily;
    map["isActive"] = isActive;
    map["isEmailConfirmed"] = isEmailConfirmed;

    return map;
  }
}
