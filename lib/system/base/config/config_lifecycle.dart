import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  bool _isDisposed = false;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          resumeCallBack!().catchError((e) {
            debugPrint('resumeCallBack error: $e');
          });
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          suspendingCallBack!().catchError((e) {
            debugPrint('suspendingCallBack error: $e');
          });
        }
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void dispose() {
    _isDisposed = true;
  }
}
