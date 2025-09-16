import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

// ignore: must_be_immutable
class SettingModelDto extends Equatable with Mappable {
  int? userId;
  String? value;
  String? name;
  String? code;
  String? codeData;
  String? valueData;
  int? tenantId;
  String? status;
  String? id;
  List<SettingJson>? listUrl;

  SettingModelDto(
      {this.code,
      this.codeData,
      this.id,
      this.name,
      this.status,
      this.tenantId,
      this.userId,
      this.value,
      this.listUrl,
      this.valueData});

  @override
  void mapping(Mapper map) {
    map("userId", userId, (v) => userId = v);
    map("value", value, (v) => value = v);
    map("name", name, (v) => name = v);
    map("code", code, (v) => code = v);
    map("codeData", codeData, (v) => codeData = v);
    map("valueData", valueData, (v) => valueData = v);
    map("tenantId", tenantId, (v) => tenantId = v);
    map("status", status, (v) => status = v);
    map("id", id, (v) => id = v);
  }

  factory SettingModelDto.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return SettingModelDto();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<SettingModelDto>();
    return obj ?? SettingModelDto();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props =>
      [userId, value, name, code, codeData, valueData, tenantId];
}

// ignore: must_be_immutable
class SettingJson extends Equatable {
  String? url;
  String? name;
  String? code;
  String? entityId;
  @override
  List<Object?> get props => [url, name, code, entityId];
}

// ignore: must_be_immutable
class TokenUser extends Equatable {
  String? token;
  String? encryptToken;
  String? userId;
  String? expireInSeconds;
  @override
  List<Object?> get props => [token, encryptToken, userId, expireInSeconds];
}
