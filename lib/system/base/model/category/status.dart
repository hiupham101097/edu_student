import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';

extension RequestStatusColor on RequestStatus {
  Color get color {
    switch (this) {
      case RequestStatus.notReceived:
        return AppStyle.colors[1][5];
      case RequestStatus.received:
        return AppStyle.colors[2][4];
      case RequestStatus.processing:
        return AppStyle.colors[2][13];
      case RequestStatus.completed:
        return AppStyle.colors[3][5];
      case RequestStatus.cancelled:
        return AppStyle.colors[2][7];
    }
  }

  Color getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.completed:
        return Colors.green.shade100;
      case RequestStatus.processing:
        return Colors.orange.shade100;
      case RequestStatus.received:
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.completed:
        return Colors.green.shade800;
      case RequestStatus.processing:
        return Colors.orange.shade800;
      case RequestStatus.received:
        return Colors.blue.shade800;
      default:
        return Colors.grey.shade600;
    }
  }
}

enum RequestStatus {
  notReceived, // 0
  received, // 1
  processing, // 2
  completed, // 3
  cancelled, // 4
}

extension RequestStatusExtension on RequestStatus {
  String get name {
    switch (this) {
      case RequestStatus.notReceived:
        return 'Chưa tiếp nhận';
      case RequestStatus.received:
        return 'Đã tiếp nhận';
      case RequestStatus.processing:
        return 'Đang xử lý';
      case RequestStatus.completed:
        return 'Đã hoàn thành';
      case RequestStatus.cancelled:
        return 'Đã hủy';
    }
  }

  static RequestStatus? fromCode(String code) {
    switch (code) {
      case 'not_received':
        return RequestStatus.notReceived;
      case 'received':
        return RequestStatus.received;
      case 'processing':
        return RequestStatus.processing;
      case 'done':
        return RequestStatus.completed;
      case 'cancelled':
        return RequestStatus.cancelled;
      default:
        return null;
    }
  }

  // ignore: unnecessary_this
  int get value => this.index;

  static RequestStatus? fromInt(int value) {
    if (value < 0 || value >= RequestStatus.values.length) return null;
    return RequestStatus.values[value];
  }
}
