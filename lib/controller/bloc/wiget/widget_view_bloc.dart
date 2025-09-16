
import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget_view_event.dart';
import 'widget_view_state.dart';

class WidgetViewBloc extends Bloc<WidgetViewEvent, WidgetViewState> {
  WidgetViewBloc(BuildContext? context)
      : super(WidgetViewState()) {
    on<WidgetViewFetched>(
      _onWidgetViewFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<WidgetViewNavigator>(_onWidgetViewNavigator);
  }

  late Emitter<WidgetViewState> umit;

  Future<void> _onWidgetViewFetched(
    WidgetViewFetched event,
    Emitter<WidgetViewState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == BlocStatus.initial) {
        await _widgetViewInit(emit);
      } else {
        await _widgetViewReInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  Future<void> _widgetViewInit(Emitter<WidgetViewState> emit) async {
    return emit(state.copyWith(
      status: BlocStatus.success,
      hasReachedMax: false,
    ));
  }

  Future<void> _widgetViewReInit(Emitter<WidgetViewState> emit) async {
    state.view = null;
    return emit(state.copyWith(
      status: BlocStatus.success,
      hasReachedMax: false,
    ));
  }

  _onWidgetViewNavigator(
    WidgetViewNavigator event,
    Emitter<WidgetViewState> emit,
  ) {
    // Navigator.of(event.context).push(
    //     AppWebView.route(event.title, event.url, event.isCheck));
  }
}
