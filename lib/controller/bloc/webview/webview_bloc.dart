import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/webview/webview_view.dart';
import 'webview_event.dart';
import 'webview_state.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc(BuildContext? context) : super(WebviewState()) {
    on<WebviewFetched>(
      _onWebviewFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<WebviewModelChange>(_onGroupModalValues);
    on<ChangeClass>(_onChangeClass);
    on<ChangeToChat>(_onChangeToChat);
  }

  late Emitter<WebviewState> umit;

  Future<void> _onWebviewFetched(
    WebviewFetched event,
    Emitter<WebviewState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == BlocStatus.initial) {
        await _WebviewInit(emit);
      } else {
        await _WebviewReInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _WebviewInit(Emitter<WebviewState> emit) async {
    state.view = null;
    return emit(
      state.copyWith(
        view: "view",
        status: BlocStatus.success,
        hasReachedMax: false,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _WebviewReInit(Emitter<WebviewState> emit) async {
    state.view = null;
    return emit(
      state.copyWith(
        view: "view",
        status: BlocStatus.success,
        hasReachedMax: false,
      ),
    );
  }

  Future<void> _onChangeClass(
    ChangeClass event,
    Emitter<WebviewState> emit,
  ) async {
    state.view = null;

    // await Navigator.of(event.context).push(
    //   ClassView.route(
    //       title: event.title, url: event.url, checkChat: event.checkChat),
    // );

    emit(state.copyWith(view: event.view));
  }

  Future<void> _onChangeToChat(
    ChangeToChat event,
    Emitter<WebviewState> emit,
  ) async {
    state.view = null;

    Navigator.push(
      event.context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => WebviewView(
          title: event.title,
          url: event.url,
          checkChat: event.checkChat,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // 👈 Phải ➝ trái
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );

    emit(state.copyWith(view: event.view));
  }

  Future<void> _onGroupModalValues(
    WebviewModelChange event,
    Emitter<WebviewState> emit,
  ) async {
    state.view = null;

    emit(state.copyWith(view: event.view));
  }
}
