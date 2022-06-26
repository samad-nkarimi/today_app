import 'dart:async';

import 'package:flutter/material.dart';
import 'package:today/size/short_methods.dart';
import 'package:today/utils/draw_arc.dart';

class HourWidget extends StatefulWidget {
  const HourWidget({Key? key}) : super(key: key);

  @override
  State<HourWidget> createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  final double height = rw(70, 90);
  @override
  void initState() {
    super.initState();
    setState(() {
      Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(width: 4, color: Colors.white),
      ),
      // alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "${DateTime.now().hour.toString()}\n${DateTime.now().minute}",
            style: const TextStyle(color: Colors.white),
          ),
          ForPainting(
            key: Key(DateTime.now().second.toString()),
            offset: height / 2 - 4, //half of width minus  stroke width
            radius: height / 2 - 4 / 2,
            stroke: 4,
            fillPercent: (59 - DateTime.now().second) / 59.0,
          ),
        ],
      ),
    );
  }
}
