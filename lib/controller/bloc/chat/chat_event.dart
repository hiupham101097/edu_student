import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatFetched extends ChatEvent {}

// ignore: must_be_immutable
class ChatNavigator extends ChatEvent {
  ChatNavigator(this.context, this.title, this.url, this.isCheck);

  late BuildContext context;
  late String title;
  late String url;
  late String isCheck;

  @override
  List<Object> get props => [context, title, url, isCheck];
}
