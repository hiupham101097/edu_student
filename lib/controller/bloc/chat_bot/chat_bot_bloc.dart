
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../system/base/model/category/status_bloc.dart';
import '../../database/connect/db_connect.dart';
import 'chat_bot_event.dart';
import 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc(BuildContext? context) : super(ChatBotState()) {
    on<ChatBotFetched>(_onChatFetched);
    on<ChatBotModelChange>(_onGroupModalValues);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onChatFetched(
    ChatBotFetched event,
    Emitter<ChatBotState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == BlocStatus.initial) {
        await _chatInit(emit);
      } else {
        await _chatReInit(emit);
      }
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> _chatInit(Emitter<ChatBotState> emit) async {
    var message = await DatabaseHelper().getAllMessages();

    return emit(
      state.copyWith(
        status: BlocStatus.success,
        messageChatBots: message,
        isHistory: message.isNotEmpty ? true : false,
        isShowHistory: false,
        hasReachedMax: false,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _chatReInit(Emitter<ChatBotState> emit) async {
    var message = await DatabaseHelper().getAllMessages();
    return emit(
      state.copyWith(
        status: BlocStatus.success,
        messageChatBots: message,
        hasReachedMax: false,
      ),
    );
  }

  Future<void> _onGroupModalValues(
    ChatBotModelChange event,
    Emitter<ChatBotState> emit,
  ) async {
    state.view = null;
    state.isHistory = event.isHistory;
    state.isShowHistory = event.isShowHistory;

    emit(
      state.copyWith(
        view: event.view,
        isHistory: event.isHistory,
        isShowHistory: event.isShowHistory,
      ),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatBotState> emit,
  ) async {
    state.view = null;

    var connect = await DatabaseHelper().insertListWithAutoId(
      event.messageChatBot!,
    );
    // ignore: unused_local_variable
    var connectDB = connect;

    emit(state.copyWith(view: event.view));
  }
}
