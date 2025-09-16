
import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext? context)
      : super(HomeState()) {
    on<HomeFetched>(
      _onHomeFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<HomeNavigator>(_onHomeNavigator);
  }

  late Emitter<HomeState> umit;

  Future<void> _onHomeFetched(
    HomeFetched event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == BlocStatus.initial) {
        await _homeInit(emit);
      } else {
        await _homeReInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  Future<void> _homeInit(Emitter<HomeState> emit) async {
    state.view = null;
    return emit(state.copyWith(
      view: "view",
      status: BlocStatus.success,
      hasReachedMax: false,
    ));
  }

  Future<void> _homeReInit(Emitter<HomeState> emit) async {
    state.view = null;
    return emit(state.copyWith(
      view: "view",
      status: BlocStatus.success,
      hasReachedMax: false,
    ));
  }

  _onHomeNavigator(
    HomeNavigator event,
    Emitter<HomeState> emit,
  ) {
    // Navigator.of(event.context).push(
    //     AppWebView.route(event.title, event.url, event.isCheck));
  }
}
