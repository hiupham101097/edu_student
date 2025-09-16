import 'package:object_mapper/object_mapper.dart';

class DataTenantModal with Mappable {
  int id;
  String name;
  String tenancyName;
  String? status;
  bool isActive = true;

  DataTenantModal({
    this.id = 0,
    this.name = "",
    this.tenancyName = "",
    this.status,
    this.isActive = true,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("name", name, (v) => name = v);
    map("tenancyName", tenancyName, (v) => tenancyName = v);
    map("status", status, (v) => status = v);
    map("isActive", isActive, (v) => isActive = v);
  }

  factory DataTenantModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataTenantModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataTenantModal>();
    return obj ?? DataTenantModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}
