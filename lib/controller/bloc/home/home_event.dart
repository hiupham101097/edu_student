import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeFetched extends HomeEvent {}

// ignore: must_be_immutable
class HomeNavigator extends HomeEvent {
  HomeNavigator(this.context, this.title, this.url, this.isCheck);

  late BuildContext context;
  late String title;
  late String url;
  late String isCheck;

  @override
  List<Object> get props => [context, title, url, isCheck];
}
