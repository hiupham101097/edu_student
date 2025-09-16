import 'package:flutter/material.dart';
import 'dart:math';

enum PipShape {
  square,
  circle,
  roundedSquare,
  triangle,
  hexagon;

  Path getPath(Offset center, double width, double height) {
    switch (this) {
      case PipShape.square:
        return Path()
          ..addRect(Rect.fromCenter(
            center: center,
            width: min(width, height),
            height: min(width, height),
          ));
      case PipShape.circle:
        return Path()
          ..addOval(Rect.fromCenter(
            center: center,
            width: min(width, height),
            height: min(width, height),
          ));
      case PipShape.triangle:
        return Path()
          ..moveTo(center.dx, center.dy - min(width, height) / 2)
          ..lineTo(center.dx + min(width, height) / 2,
              center.dy + min(width, height) / 2)
          ..lineTo(center.dx - min(width, height) / 2,
              center.dy + min(width, height) / 2)
          ..close();
      case PipShape.roundedSquare:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: center,
              width: min(width, height),
              height: min(width, height),
            ),
            const Radius.circular(20.0),
          ));
      case PipShape.hexagon:
        return Path()
          ..moveTo(center.dx, center.dy - min(width, height) / 2)
          ..lineTo(center.dx + min(width, height) / 2,
              center.dy - min(width, height) / 4)
          ..lineTo(center.dx + min(width, height) / 2,
              center.dy + min(width, height) / 4)
          ..lineTo(center.dx, center.dy + min(width, height) / 2)
          ..lineTo(center.dx - min(width, height) / 2,
              center.dy + min(width, height) / 4)
          ..lineTo(center.dx - min(width, height) / 2,
              center.dy - min(width, height) / 4)
          ..close();
    }
  }
}
