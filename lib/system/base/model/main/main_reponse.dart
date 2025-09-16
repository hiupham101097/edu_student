import 'dart:async';

import 'package:edu_student/system/base/model/main/status.dart';



class MainRepository {
  final _controller = StreamController<MainStatus>();

  Stream<MainStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield MainStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(MainStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(MainStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}