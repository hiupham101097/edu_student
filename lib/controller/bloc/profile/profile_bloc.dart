
import 'package:edu_student/controller/bloc/profile/profile_event.dart';
import 'package:edu_student/controller/bloc/profile/profile_state.dart';
import 'package:edu_student/system/_variables/http/app_http_model.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/base/controller/Api/user/user_component.dart';
import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:edu_student/system/base/model/user/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(BuildContext? context) : super(ProfileState()) {
    on<ProfileFetched>(
      _onClassFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ProfileModelChange>(_changeViewModalValues);
  }

  Future<void> _onClassFetched(
    ProfileFetched event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProfileStatus.initial) {
        var item = ProfileModel(GlobalParams.getUserData()!.id!);
        item.emailAddress = GlobalParams.getUserData()!.emailAddress;
        item.fullName = GlobalParams.getUserData()!.fullName;
        item.phoneNumber = GlobalParams.getUserData()!.phoneNumber ?? " ";
        item.address = GlobalParams.getUserData()!.address;
        return emit(state.copyWith(
          status: ProfileStatus.success,
          profileModel: item,
          hasReachedMax: false,
        ));
      }
      var item = ProfileModel(GlobalParams.getUserData()!.id!);
      item.emailAddress = GlobalParams.getUserData()!.emailAddress;
      item.fullName = GlobalParams.getUserData()!.fullName;
      item.phoneNumber = GlobalParams.getUserData()!.phoneNumber;
      item.address = GlobalParams.getUserData()!.address;
      final user = item;
      // ignore: unnecessary_null_comparison
      user != null
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ProfileStatus.success,
                profileModel: user,
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  Future<void> _changeViewModalValues(
    ProfileModelChange event,
    Emitter<ProfileState> emit,
  ) async {
    var value = event.view;
    emit(state.copyWith(view: value));
  }

  // ignore: unused_element
  Future<void> _buttonViewModalValues(
    ButtonProfileSave event,
    Emitter<ProfileState> emit,
  ) async {
    var profile = event.profileModel;

    var saveResult = await UserComponent().saveCurrenProfile(
      profile.toMap(),
    );

    if (event.view == "V") {
      event.view = "";
    } else {
      event.view = "V";
    }

    if (saveResult.status == AppHttpModelStatus.Success) {
      final userData = GlobalParams.getUserData();
      if (userData != null) {
        userData
          ..fullName = profile.fullName
          ..emailAddress = profile.emailAddress
          ..phoneNumber = profile.phoneNumber
          ..address = profile.address;

        GlobalParams.setUserData(userData); // Cập nhật lại vào GlobalParams
      }

      emit(state.copyWith(view: event.view, profileModel: profile));
    }
  }
}
