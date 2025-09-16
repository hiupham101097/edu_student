import 'package:flutter/material.dart';

enum InvoiceStatus {
  created, // 0
  approved, // 1
  processing, // 2
  paid, // 3
  cancelled, // 4
}

extension InvoiceStatusExtension on InvoiceStatus {
  String get label {
    switch (this) {
      case InvoiceStatus.created:
        return 'Mới';
      case InvoiceStatus.approved:
        return 'Đã duyệt';
      case InvoiceStatus.processing:
        return 'Đang xử lý';
      case InvoiceStatus.paid:
        return 'Đã thanh toán';
      case InvoiceStatus.cancelled:
        return 'Đã huỷ';
    }
  }

  Color get color {
    switch (this) {
      case InvoiceStatus.created:
        return Colors.blue.shade300; // Mới - xanh dương tươi
      case InvoiceStatus.approved:
        return Colors.green.shade300; // Đã duyệt - xanh lá tươi
      case InvoiceStatus.processing:
        return Colors.orange.shade300; // Đang xử lý - cam tươi
      case InvoiceStatus.paid:
        return Colors.teal.shade300; // Đã thanh toán - xanh ngọc
      case InvoiceStatus.cancelled:
        return Colors.red.shade300; // Đã huỷ - đỏ tươi
    }
  }

  Color get bgColor {
    switch (this) {
      case InvoiceStatus.created:
        return Colors.blue.shade100; // Mới - nền xanh dương nhạt
      case InvoiceStatus.approved:
        return Colors.green.shade100; // Đã duyệt - nền xanh lá nhạt
      case InvoiceStatus.processing:
        return Colors.orange.shade100; // Đang xử lý - nền cam nhạt
      case InvoiceStatus.paid:
        return Colors.teal.shade100; // Đã thanh toán - nền xanh ngọc nhạt
      case InvoiceStatus.cancelled:
        return Colors.red.shade100; // Đã huỷ - nền đỏ nhạt
    }
  }

  int get value => this.index;

  static InvoiceStatus? fromValue(int value) {
    if (value < 0 || value >= InvoiceStatus.values.length) return null;
    return InvoiceStatus.values[value];
  }
}
