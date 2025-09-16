
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../model/chatbot/message.dart';

abstract class ChatBotEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatBotFetched extends ChatBotEvent {}

// ignore: must_be_immutable
class ChatBotModelChange extends ChatBotEvent {
  ChatBotModelChange({
    this.view = '',
    this.isHistory = false,
    this.isShowHistory = false,
  });

  String view;
  bool isHistory = false;
  bool isShowHistory = false;
  @override
  List<Object> get props => [view, isHistory, isShowHistory];
}

// ignore: must_be_immutable
class SendMessage extends ChatBotEvent {
  SendMessage({this.context, this.messageChatBot, this.view});

  List<MessageChatBot>? messageChatBot;
  BuildContext? context;

  String? view;
  @override
  List<Object> get props => [view!];
}
