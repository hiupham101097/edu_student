import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';

enum StatusTypeNews {
  thongBao, // 0
  tuyenTruyen, // 1
  baoTri, // 2
  canhBao, // 3
  canhBaoKyThuat, // 4
  yeuCauCuDan, // 5
  noiBo, // 6
  taiChinh, // 7
  suKien, // 8
}

extension StatusTypeNewColor on StatusTypeNews {
  Color get color {
    switch (this) {
      case StatusTypeNews.thongBao:
        return AppStyle.colors[1][5];
      case StatusTypeNews.tuyenTruyen:
        return AppStyle.colors[2][4];
      case StatusTypeNews.baoTri:
        return AppStyle.colors[2][13];
      case StatusTypeNews.canhBao:
        return AppStyle.colors[3][5];
      case StatusTypeNews.canhBaoKyThuat:
        return AppStyle.colors[2][7];
      case StatusTypeNews.yeuCauCuDan:
        return AppStyle.colors[4][7];
      case StatusTypeNews.noiBo:
        return AppStyle.colors[0][6];
      case StatusTypeNews.taiChinh:
        return AppStyle.colors[5][3];
      case StatusTypeNews.suKien:
        return AppStyle.colors[6][5];
    }
  }

  Color getStatusColor(StatusTypeNews status) {
    switch (status) {
      case StatusTypeNews.canhBao:
        return Colors.red.shade100;
      case StatusTypeNews.baoTri:
        return Colors.orange.shade100;
      case StatusTypeNews.tuyenTruyen:
        return Colors.blue.shade100;
      case StatusTypeNews.yeuCauCuDan:
        return Colors.teal.shade100;
      case StatusTypeNews.noiBo:
        return Colors.grey.shade300;
      case StatusTypeNews.taiChinh:
        return Colors.purple.shade100;
      case StatusTypeNews.suKien:
        return Colors.indigo.shade100;
      case StatusTypeNews.thongBao:
        return Colors.yellow.shade100;
      case StatusTypeNews.canhBaoKyThuat:
        return Colors.red.shade200;
    }
  }

  Color getStatusTextColor(StatusTypeNews status) {
    switch (status) {
      case StatusTypeNews.canhBao:
        return Colors.red.shade800;
      case StatusTypeNews.baoTri:
        return Colors.orange.shade800;
      case StatusTypeNews.tuyenTruyen:
        return Colors.blue.shade800;
      case StatusTypeNews.yeuCauCuDan:
        return Colors.teal.shade800;
      case StatusTypeNews.noiBo:
        return Colors.grey.shade800;
      case StatusTypeNews.taiChinh:
        return Colors.purple.shade800;
      case StatusTypeNews.suKien:
        return Colors.indigo.shade800;
      case StatusTypeNews.thongBao:
        return Colors.yellow.shade800;
      case StatusTypeNews.canhBaoKyThuat:
        return Colors.red.shade900;
    }
  }
}

extension StatusTypeNewsExtension on StatusTypeNews {
  String get name {
    switch (this) {
      case StatusTypeNews.thongBao:
        return 'Thông Báo';
      case StatusTypeNews.tuyenTruyen:
        return 'Tuyên Truyền';
      case StatusTypeNews.baoTri:
        return 'Bảo trì';
      case StatusTypeNews.canhBao:
        return 'Cảnh báo';
      case StatusTypeNews.canhBaoKyThuat:
        return 'Cảnh báo kỹ thuật';
      case StatusTypeNews.yeuCauCuDan:
        return 'Yêu cầu cư dân';
      case StatusTypeNews.noiBo:
        return 'Nội bộ';
      case StatusTypeNews.taiChinh:
        return 'Tài chính';
      case StatusTypeNews.suKien:
        return 'Sự kiện';
    }
  }

  static StatusTypeNews? fromCode(String code) {
    switch (code) {
      case 'thongBao':
        return StatusTypeNews.thongBao;
      case 'tuyenTruyen':
        return StatusTypeNews.tuyenTruyen;
      case 'baoTri':
        return StatusTypeNews.baoTri;
      case 'canhBao':
        return StatusTypeNews.canhBao;
      case 'canhBaoKyThuat':
        return StatusTypeNews.canhBaoKyThuat;
      case 'yeuCauCuDan':
        return StatusTypeNews.yeuCauCuDan;
      case 'noiBo':
        return StatusTypeNews.noiBo;
      case 'taiChinh':
        return StatusTypeNews.taiChinh;
      case 'suKien':
        return StatusTypeNews.suKien;
      default:
        return null;
    }
  }

  // ignore: unnecessary_this
  int get value => this.index;

  static StatusTypeNews? fromInt(int value) {
    if (value < 0 || value >= StatusTypeNews.values.length) return null;
    return StatusTypeNews.values[value];
  }
}
