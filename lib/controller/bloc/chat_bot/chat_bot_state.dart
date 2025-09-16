
import 'package:equatable/equatable.dart';

import '../../../model/chatbot/message.dart';
import '../../../system/base/model/category/status_bloc.dart';

// ignore: must_be_immutable
class ChatBotState extends Equatable {
  ChatBotState({
    this.status = BlocStatus.initial,
    this.hasReachedMax = false,
    this.messageChatBots,
    this.isHistory = false,
    this.isShowHistory = false,
    this.view,
  });

  final BlocStatus? status;
  final bool hasReachedMax;
  final List<MessageChatBot>? messageChatBots;
  bool? isHistory;
  bool? isShowHistory;
  String? view;

  ChatBotState copyWith({
    BlocStatus? status,
    bool? hasReachedMax,
    String? view,
    List<MessageChatBot>? messageChatBots,
    bool? isHistory,
    bool? isShowHistory,
  }) {
    return ChatBotState(
      status: status ?? this.status,
      view: view ?? this.view,
      messageChatBots: messageChatBots ?? this.messageChatBots,
      isHistory: isHistory ?? this.isHistory,
      isShowHistory: isShowHistory ?? this.isShowHistory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view, messageChatBots];
}
