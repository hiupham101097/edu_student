import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

// ignore: must_be_immutable
class FileDataModal extends Equatable with Mappable {
  String? group;
  int? tenantId;
  String? name;
  String? type;
  String? data;
  String? fileUrl;
  bool? thumbnail;
  String? reference;
  String? id;
  String? base64;

  FileDataModal({
    this.name,
    this.tenantId,
    this.type,
    this.data,
    this.fileUrl,
    this.group,
    this.thumbnail,
    this.reference,
    this.id,
    this.base64,
  });
  @override
  void mapping(Mapper map) {
    map("group", group, (v) => group = v);
    map("tenantId", tenantId, (v) => tenantId = v);
    map("name", name, (v) => name = v);
    map("type", type, (v) => type = v);
    map("data", data, (v) => data = v);
    map("fileUrl", fileUrl, (v) => fileUrl = v);
    map("thumbnail", thumbnail, (v) => thumbnail = v);
    map("reference", reference, (v) => reference = v);
    map("id", id, (v) => id = v);
  }

  factory FileDataModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return FileDataModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<FileDataModal>();
    return obj ?? FileDataModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [name, tenantId, type, data, fileUrl, group, id];
}
