import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:today/utils/date_converter.dart';
import 'package:today/utils/draw_arc.dart';
import 'package:today/utils/helper_methods.dart';

class TodayInfoWidget extends StatefulWidget {
  final double showBoardSize;
  const TodayInfoWidget({Key? key, required this.showBoardSize})
      : super(key: key);

  @override
  State<TodayInfoWidget> createState() => _TodayInfoWidgetState();
}

class _TodayInfoWidgetState extends State<TodayInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              height: widget.showBoardSize,
              width: widget.showBoardSize,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                // color: Colors.blue.withOpacity(.5),
                borderRadius: BorderRadius.circular(100.0),
                // border: Border.all(width: 5.0,color: Colors.blue),

                gradient: RadialGradient(
                  colors: [
                    Colors.purple.withOpacity(0.3),
                    Colors.blue.withOpacity(0.3)
                  ],
                  radius: .8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    getWeekdayInShamsi(),
                    style: const TextStyle(
                      fontFamily: "Negar",
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getTodayDateStringInShamsi(),
                    style: const TextStyle(
                      fontFamily: "Negar",
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        ForPainting(
          radius: widget.showBoardSize / 2,
          offset: 50,
          stroke: 18.0,
          fillPercent: getHourPercent(),
        ),
      ],
    );
  }
}
