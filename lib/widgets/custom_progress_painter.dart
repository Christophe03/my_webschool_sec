import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomProgressPainter extends CustomPainter {
  final double value;
  final double maxvalue;
  final Color color;
  CustomProgressPainter(this.value, this.maxvalue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10;
    final double radius = size.width / 2 - strokeWidth / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [color, color],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * value / maxvalue,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
