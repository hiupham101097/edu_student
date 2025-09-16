import 'package:object_mapper/object_mapper.dart';

class Criteria {
  String? propertyName;
  int? operation;
  String? value;

  Criteria({this.propertyName, this.operation, this.value});

  static Criteria fromJson(dynamic json) {
    return Criteria(
      propertyName: json['propertyName'] as String,
      operation: json['operation'] as int,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_new, prefer_collection_literals
    var map = new Map<String, dynamic>();

    map['propertyName'] = propertyName;
    map['operation'] = operation;
    map['value'] = value;

    return map;
  }
}

class DataGetModal with Mappable {
  int? tenantId;
  int? skipCount;
  int? maxResultCount;

  List<DataCriteriaModal>? criterias;

  DataGetModal({
    this.tenantId,
    this.criterias,
    this.skipCount = 0,
    this.maxResultCount = 9999,
  });

  @override
  void mapping(Mapper map) {
    map("tenantId", tenantId, (v) => tenantId = v);
    map("criterias", criterias, (v) => criterias = v);
    map("skipCount", skipCount, (v) => skipCount = v);
    map("maxResultCount", maxResultCount, (v) => maxResultCount = v);
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

class DataCriteriaModal with Mappable {
  String? propertyName;
  String? operation;
  String? value;

  DataCriteriaModal(
      {this.propertyName = "", this.operation = "", this.value = ""});

  @override
  void mapping(Mapper map) {
    map("propertyName", propertyName, (v) => propertyName = v);
    map("operation", operation, (v) => operation = v);
    map("value", value, (v) => value = v);
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

