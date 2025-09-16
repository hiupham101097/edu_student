import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:equatable/equatable.dart';


// ignore: must_be_immutable
class HomeState extends Equatable {
  HomeState(
      {this.status = BlocStatus.initial,
      this.hasReachedMax = false,
      this.view = ""});

  final BlocStatus? status;
  final bool hasReachedMax;
  String? view;

  HomeState copyWith(
      {BlocStatus? status, bool? hasReachedMax, String view = ""}) {
    return HomeState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
