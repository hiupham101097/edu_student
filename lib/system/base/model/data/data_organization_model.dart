import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

class DataOrganizationModel with Mappable {
  String? id;
  String? code;
  String? name;

  DataOrganizationModel({
    this.id,
    this.code,
    this.name,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("code", code, (v) => code = v);
    map("name", name, (v) => name = v);
  }

  factory DataOrganizationModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataOrganizationModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataOrganizationModel>();
    return obj ?? DataOrganizationModel();
  }
}

class SSOOrganization with Mappable {
  SSOOrganization(
      {this.organizationId, this.name, this.order, this.code, this.listUser, this.view});

  String? organizationId;
  String? name;
  int? order;
  String? code;
  List<SSOTypeUserDto>? listUser;
  String? view = '';

  @override
  void mapping(Mapper map) {
    map("organizationId", organizationId, (v) => organizationId = v);
    map("name", name, (v) => name = v);
    map("order", order, (v) => order = v);
    map("code", code, (v) => code = v);
    map<SSOTypeUserDto>("listUser", listUser, (v) => listUser = v);
  }

  factory SSOOrganization.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return SSOOrganization();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<SSOOrganization>();
    return obj ?? SSOOrganization();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

// ignore: must_be_immutable
class SSOTypeUserDto extends Equatable with Mappable {
  SSOTypeUserDto({
    this.key,
    this.info,
    this.name,
    this.code,
    this.emailAddress,
    this.surname,
    this.title,
    this.type,
  });

  String? key;
  String? info;
  String? name;
  String? surname;
  String? emailAddress;
  String? title;
  String? code;
  String? type;
  @override
  void mapping(Mapper map) {
    map("key", key, (v) => key = v);
    map("info", info, (v) => info = v);
    map("name", name, (v) => name = v);
    map("surname", surname, (v) => surname = v);
    map("emailAddress", emailAddress, (v) => emailAddress = v);
    map("title", title, (v) => title = v);
    map("code", code, (v) => code = v);
    map("type", type, (v) => type = v);
  }

  factory SSOTypeUserDto.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return SSOTypeUserDto();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<SSOTypeUserDto>();
    return obj ?? SSOTypeUserDto();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [
        key,
        info,
        name,
        surname,
        emailAddress,
        title,
        code,
        type,
      ];
}
