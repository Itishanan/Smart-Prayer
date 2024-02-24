
import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final double strokeWidth;

  LinePainter({
    required this.startPoint,
    required this.endPoint,
    this.color = Colors.blue,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}