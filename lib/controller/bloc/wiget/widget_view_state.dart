import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class WidgetViewState extends Equatable {
  WidgetViewState({
    this.status = BlocStatus.initial,
    this.hasReachedMax = false,
    this.view,
  });

  BlocStatus? status;
  bool hasReachedMax;
  String? view;

  WidgetViewState copyWith({
    BlocStatus? status,
    bool? hasReachedMax,
    String? view,
  }) {
    return WidgetViewState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      view: view ?? this.view,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
