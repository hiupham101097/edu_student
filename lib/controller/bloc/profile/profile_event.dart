import 'package:edu_student/system/base/model/user/profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileFetched extends ProfileEvent {}

// ignore: must_be_immutable
class ProfileModelChange extends ProfileEvent {
  ProfileModelChange(this.view);

  late String view;
  @override
  List<Object> get props => [view];
}

// ignore: must_be_immutable
class ButtonProfileSave extends ProfileEvent {
  ButtonProfileSave(this.profileModel, this.view);

  late ProfileModel profileModel;
  late String view;

  @override
  List<Object> get props => [profileModel, view];
}
