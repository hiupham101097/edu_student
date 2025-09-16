import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

// ignore: must_be_immutable
class TenantUserDto extends Equatable with Mappable {
  TenantUserDto({this.userId, this.code, this.status, this.valueData});
  int? userId;
  String? code;
  String? valueData;
  String? status;
  @override
  void mapping(Mapper map) {
    map("userId", userId, (v) => userId = v);
    map("code", code, (v) => code = v);
    map("status", status, (v) => status = v);
    map("valueData", valueData, (v) => valueData = v);
  }

  factory TenantUserDto.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return TenantUserDto();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<TenantUserDto>();
    return obj ?? TenantUserDto();
  }

  // ignore: annotate_overrides
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [userId, code, status, valueData];
}
