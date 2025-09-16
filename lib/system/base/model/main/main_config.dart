import 'package:equatable/equatable.dart';
import 'package:edu_student/system/base/model/main/status.dart';

class MainState extends Equatable {
  const MainState._({
    required this.status,
  });
  const MainState.unknown() : this._(status: MainStatus.unknown);
  const MainState.authenticated() : this._(status: MainStatus.authenticated);
  const MainState.unauthenticated()
      : this._(status: MainStatus.unauthenticated);

  final MainStatus status;

  @override
  List<Object> get props => [status];
}
