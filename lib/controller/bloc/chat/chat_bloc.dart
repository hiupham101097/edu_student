

import 'package:edu_student/controller/bloc/chat/chat_event.dart' show ChatEvent, ChatFetched, ChatNavigator;
import 'package:edu_student/controller/bloc/chat/chat_state.dart';
import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(BuildContext? context)
      : super(const ChatState()) {
    on<ChatFetched>(
      _onChatFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ChatNavigator>(_onChatNavigator);
  }

  late Emitter<ChatState> umit;

  Future<void> _onChatFetched(
    ChatFetched event,
    Emitter<ChatState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == BlocStatus.initial) {
        await _chatInit(emit);
      } else {
        await _chatInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  Future<void> _chatInit(Emitter<ChatState> emit) async {
    return emit(state.copyWith(
      status: BlocStatus.success,
      hasReachedMax: false,
    ));
  }

  _onChatNavigator(
    ChatNavigator event,
    Emitter<ChatState> emit,
  ) {
    // Navigator.of(event.context).push(
    //     AppWebView.route(event.title, event.url, event.isCheck));
  }
}
