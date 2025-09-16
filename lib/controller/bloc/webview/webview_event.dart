import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WebviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WebviewFetched extends WebviewEvent {}

// ignore: must_be_immutable
class WebviewModelChange extends WebviewEvent {
  WebviewModelChange(this.view);

  String view;
  @override
  List<Object> get props => [view];
}

// ignore: must_be_immutable
class ChangeClass extends WebviewEvent {
  ChangeClass(this.title, this.url, this.context, this.checkChat, this.view);

  late String title;
  late String url;
  late BuildContext context;
  late String checkChat;
  late String view;


  @override
  List<Object> get props => [title, url, context, checkChat, view];
}

// ignore: must_be_immutable
class ChangeToChat extends WebviewEvent {
  ChangeToChat(this.title, this.url, this.context, this.checkChat, this.view);

  late String title;
  late String url;
  late BuildContext context;
  late String checkChat;
  late String view;


  @override
  List<Object> get props => [title, url, context, checkChat, view];
}


 