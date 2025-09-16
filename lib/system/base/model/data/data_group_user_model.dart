import 'package:object_mapper/object_mapper.dart';

class DataGroupUserModel with Mappable {
  String? application;
  int userId;
  String? fullName;
  String? emailAddress;
  int friendId;
  String? key;
  int? tenantId;
  DateTime? creationTime;
  String? typeUser;
  String? value;
  String? value1;
  String? value2;

  @override
  void mapping(Mapper map) {
    map("application", application, (v) => application = v);
    map("userId", userId, (v) => userId = v);
    map("fullName", fullName, (v) => fullName = v);
    map("friendId", friendId, (v) => friendId = v ?? 0);
    map("key", key, (v) => key = v);
    map("creationTime", creationTime, (v) => creationTime = v, const DateTransform());
    map("typeUser", typeUser, (v) => typeUser = v);
    map("value", value, (v) => value = v);
    map("value1", value1, (v) => value1 = v);
    map("value2", value2, (v) => value2 = v);
  }

  DataGroupUserModel({
    this.application,
    this.userId = 0,
    this.fullName,
    this.emailAddress,
    this.friendId = 0,
    this.key,
    this.tenantId,
    this.creationTime,
    this.typeUser,
    this.value,
    this.value1,
    this.value2,
  });

  factory DataGroupUserModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataGroupUserModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataGroupUserModel>();
    return obj ?? DataGroupUserModel();
  }
}

class DataGroupUserInfoModal with Mappable {
  int userId;
  String? fullName;

  @override
  void mapping(Mapper map) {
    map("userId", userId, (v) => userId = int.parse(v.toString()));
    map("fullName", fullName, (v) => fullName = v);
  }

  DataGroupUserInfoModal({
    this.userId = 0,
    this.fullName,
  });

  factory DataGroupUserInfoModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataGroupUserInfoModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataGroupUserInfoModal>();
    return obj ?? DataGroupUserInfoModal();
  }
}
