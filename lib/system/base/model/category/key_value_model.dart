import 'package:object_mapper/object_mapper.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class KeyValueModal extends Equatable with Mappable {
  String? key;
  String? value;

  KeyValueModal({
    this.key,
    this.value,
  });

  @override
  void mapping(Mapper map) {
    map("key", key, (v) => key = v);
    map("value", value, (v) => value = v);
  }

  factory KeyValueModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return KeyValueModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<KeyValueModal>();
    return obj ?? KeyValueModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [key, value];
}
