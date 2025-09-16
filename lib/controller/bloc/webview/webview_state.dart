import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class WebviewState extends Equatable {
  WebviewState(
      {this.status = BlocStatus.initial,
      this.hasReachedMax = false,
      this.view});

  final BlocStatus? status;
  final bool hasReachedMax;
  String? view;

  WebviewState copyWith(
      {BlocStatus? status, bool? hasReachedMax, String? view}) {
    return WebviewState(
      status: status ?? this.status,
      view: view ?? this.view,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
