import 'package:flutter/material.dart';
import 'particle.dart';
import 'dart:math';
import 'dart:ui';
import 'main.dart';

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;
  MyPainterCanvas(this.rgn, this.particles, this.animValue);
  @override
  void paint(Canvas canvas, Size size) {
    this.particles.forEach((p) {
      var velocity = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;

      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }

      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    });

    // paint the object
    this.particles.forEach((p) {
      var paint = Paint();
      paint.color = Colors.blueAccent;
      canvas.drawCircle(p.position, p.radius, paint);
    });

    var dx = size.width / 2;
    var dy = size.height / 2;
    Offset c = Offset(dx, dy);

    var radius = 100.0;
    var paint = Paint();
    paint.color = Colors.red;
    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}
