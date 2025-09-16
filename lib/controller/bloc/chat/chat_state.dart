import 'package:edu_student/system/base/model/category/status_bloc.dart';
import 'package:equatable/equatable.dart';


// ignore: must_be_immutable
class ChatState extends Equatable {
  const ChatState(
      {this.status = BlocStatus.initial,
      this.hasReachedMax = false,
      this.view = ""});

  final BlocStatus? status;
  final bool hasReachedMax;
  final String? view;

  ChatState copyWith(
      {BlocStatus? status, bool? hasReachedMax, String view = ""}) {
    return ChatState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
