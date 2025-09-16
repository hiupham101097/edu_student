import 'package:object_mapper/object_mapper.dart';

import '../../../_variables/value/app_const.dart';


class DataDeviceTokenModel with Mappable {
  /// DeviceId
  late String deviceId;

  /// ClientTokens
  late String value;

  String application = AppConst.EDU_HUB;
  String? type;

  DataDeviceTokenModel({
    this.deviceId = "",
    this.value = "",
    this.type = "",
    this.application = AppConst.EDU_HUB,
  });

  @override
  void mapping(Mapper map) {
    map("key", deviceId, (v) => deviceId = v);
    map("value", value, (v) => value = v);
    map("application", application, (v) => application = v);
    map("type", type, (v) => type = v);
  }

  factory DataDeviceTokenModel.fromJson(Map<String, dynamic>? jsonInput) {
    if(jsonInput == null)
    {
        return DataDeviceTokenModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataDeviceTokenModel>();
    return obj ?? DataDeviceTokenModel();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}
