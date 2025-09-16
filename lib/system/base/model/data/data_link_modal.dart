import 'package:edu_student/system/_variables/value/app_const.dart';
import 'package:edu_student/system/base/model/data/file_data_model.dart';
import 'package:object_mapper/object_mapper.dart';


class DataLinkModel with Mappable {
  String application;
  String? id;
  int? tenantId;
  String? groupId;
  int? senderId;
  int? receiverId;
  String? content;
  String? type;
  String? reference;
  String? status;
  String? hideValue;
  int? creatorUserId;
  String? value1;
  String? value2;
  DateTime? creationTime;

  List<FileDataModal>? listFile;

  DataLinkModel({
    this.application = AppConst.EDU_HUB,
    this.id,
    this.tenantId,
    this.groupId,
    this.senderId,
    this.receiverId,
    this.content,
    this.type,
    this.reference,
    this.status,
    this.hideValue,
    this.creatorUserId,
    this.creationTime,
    this.value1,
    this.value2,
    this.listFile,
  });

  @override
  void mapping(Mapper map) {
    map("application", application,
        (v) => application = v ?? AppConst.EDU_HUB);
    map("id", id, (v) => id = v);
    map("tenantId", tenantId, (v) => tenantId = v);
    map("groupId", groupId, (v) => groupId = v);
    map("senderId", senderId, (v) => senderId = v?? 0);
    map("receiverId", receiverId, (v) => receiverId = v ?? 0);
    map("content", content, (v) => content = v);
    map("type", type, (v) => type = v);
    map("reference", reference, (v) => reference = v);
    map("status", status, (v) => status = v);
    map("hideValue", hideValue, (v) => hideValue = v);
    map("creatorUserId", creatorUserId, (v) => creatorUserId = v);
    map("creationTime", creationTime, (v) => creationTime = v, const DateTransform());
    map("value1", value1, (v) => value1 = v);
    map("value2", value2, (v) => value2 = v);
    map<FileDataModal>("listFile", listFile, (v) => listFile = v);
  }

  factory DataLinkModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataLinkModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataLinkModel>();
    return obj ?? DataLinkModel();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

class DataTransferEventModal {
  String name;
  Function(List<Object>) function;

  DataTransferEventModal(this.name, this.function);
}
