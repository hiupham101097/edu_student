import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WidgetViewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WidgetViewFetched extends WidgetViewEvent {}

// ignore: must_be_immutable
class WidgetViewNavigator extends WidgetViewEvent {
  WidgetViewNavigator(this.context, this.title, this.url, this.isCheck);

  late BuildContext context;
  late String title;
  late String url;
  late String isCheck;

  @override
  List<Object> get props => [context, title, url, isCheck];
}
