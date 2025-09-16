import 'package:object_mapper/object_mapper.dart';

class DataMenuModal with Mappable {
  String? codeData;
  String? name;
  String? valueData;

  DataMenuModal({
    this.codeData,
    this.name,
    this.valueData,
  });

  @override
  void mapping(Mapper map) {
    map("codeData", codeData, (v) => codeData = v);
    map("name", name, (v) => name = v);
    map("valueData", valueData, (v) => valueData = v);
  }

  factory DataMenuModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataMenuModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataMenuModal>();
    return obj ?? DataMenuModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}
