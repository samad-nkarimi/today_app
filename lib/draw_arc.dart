import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';


class ForPainting extends StatefulWidget {
  const  ForPainting({Key? key}) : super(key: key);

  @override
  _ForPaintingState createState() => _ForPaintingState();
}

class _ForPaintingState extends State<ForPainting> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    Size size = const Size(100.0,100.0);
    return Container(
      // color: Colors.black12,
      // height: 50.0,
      child: CustomPaint(
        size: size,
        painter: Painter(),
      ),
    );
  }
}

class Painter extends CustomPainter {
  // Paint cloudPaint;
  // Painter(this.cloudPaint);
  @override
  void paint(Canvas canvas, Size size) {
    // double rectTop = 110.0;
    // double rectBottom = rectTop + 150.0;
    // double figureLeftEdge = size.width / 4;
    // double figureRightEdge = size.width - 90.0;
    // double figureCenter = size.width / 2;

    Rect cloudBaseRect = Rect.fromCircle(center:const  Offset(50.0, 50.0), radius: 50);
    // RRect cloudBase = RRect.fromRectAndRadius(
    //   cloudBaseRect,
    //   Radius.circular(10.0),
    // );
    // canvas.drawCircle(
    //   Offset(figureLeftEdge + 5, 100.0),
    //   50.0,
    //   cloudPaint,
    // );
    // canvas.drawCircle(
    //   Offset(figureCenter, 70.0),
    //   60.0,
    //   cloudPaint,
    // );
    Gradient gradient =  SweepGradient(
      colors: [
        Colors.red.shade500,
        Colors.yellow,
        Colors.lightGreen,
        Colors.red.shade500,
      ],
      stops: [
        0.0,
        0.3,
        0.6,
        1.0
      ],
    );
    Gradient gradient1 = RadialGradient(
      colors: [
        Colors.red.shade500,
        Colors.yellow.withOpacity(0.3),
      ],
      stops: const [
        0.7,
        1.0,
      ],
    );

    Paint _paintBrush2 = Paint()
    // ..color = Colors.red
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(cloudBaseRect);

    Paint _paintBrush1 = Paint()
    // ..color = Colors.red
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(cloudBaseRect)
      ..shader = gradient1.createShader(cloudBaseRect);
    // canvas.drawCircle(
    //   Offset(120.0, 100.0),
    //   85.0,
    //   _paintBrush1,
    // );
    // canvas.drawCircle(
    //   Offset(120.0, 100.0),
    //   80.0,
    //   _paintBrush,
    // );
    // canvas.drawColor(Colors.black, BlendMode.exclusion);
    canvas.drawArc(cloudBaseRect, 0, 1.5 * pi, false, _paintBrush2);
    canvas.drawArc(cloudBaseRect, 0, 2.0 * pi, false, _paintBrush1);
    // canvas.drawLine(const Offset(200, 200), const Offset(220, 200), _paintBrush1);
    // cloudPaint.strokeWidth = 3.0;
    // cloudPaint.color = Colors.white;
    // canvas.drawRRect(cloudBase, cloudPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}