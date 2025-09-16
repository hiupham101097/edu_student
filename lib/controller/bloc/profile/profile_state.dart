import 'package:edu_student/system/base/model/user/profile_model.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, success, failure }

// ignore: must_be_immutable
class ProfileState extends Equatable {
  ProfileState(
      {this.status = ProfileStatus.initial,
      this.profileModel,
      this.hasReachedMax = false,
      this.view = ''});
  final ProfileStatus? status;
  final ProfileModel? profileModel;
  final bool hasReachedMax;
  String view;

  ProfileState copyWith(
      {ProfileStatus? status,
      ProfileModel? profileModel,
      bool? hasReachedMax,
      String? view}) {
    return ProfileState(
        status: status ?? this.status,
        profileModel: profileModel ?? this.profileModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        view: view ?? this.view);
  }

  @override
  String toString() {
    return '''ClassState { status: $status, hasReachedMax: $hasReachedMax, profileModel:$profileModel}, view:$view}''';
  }

  @override
  List<Object?> get props => [status, profileModel, hasReachedMax, view];
}
