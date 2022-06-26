import 'package:flutter/material.dart';
import 'package:today/size/short_methods.dart';
import 'package:today/utils/helper_methods.dart';

class RemaningPercentWisget extends StatefulWidget {
  const RemaningPercentWisget({Key? key}) : super(key: key);

  @override
  State<RemaningPercentWisget> createState() => _RemaningPercentWisgetState();
}

class _RemaningPercentWisgetState extends State<RemaningPercentWisget> {
  final double diameter = rw(70, 90);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20.0),
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(width: 4, color: Colors.white),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getHourPercent() * diameter,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              "${(getHourPercent() * 100).toStringAsFixed(0)}%",
              style: const TextStyle(fontFamily: "ANegar", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
