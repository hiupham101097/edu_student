import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

// ignore: must_be_immutable
class CityModel extends Equatable with Mappable {
  CityModel({this.id, this.name, this.slug, this.type, this.typeText});

  int? id;
  String? name;
  String? slug;
  int? type;
  String? typeText;

  @override
  void mapping(Mapper map) {
    map("phone_code", id, (v) => id = v);
    map("name", name, (v) => name = v);
    map("code_name", slug, (v) => slug = v);
    map("code", type, (v) => type = v);
    map("division_type", typeText, (v) => typeText = v);
  }

  factory CityModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return CityModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<CityModel>();
    return obj ?? CityModel();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [id, name, slug, type, typeText];
}
