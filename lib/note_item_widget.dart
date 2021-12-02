import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteItem extends StatelessWidget {
  final Color? labelColor;
  final String? title;
  final String? subTitle;

  const NoteItem(
    this.title,
    this.subTitle, {
    Key? key,
    @required this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // print(labelColor.toString());
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          padding: const EdgeInsets.only(right: 34.0, top: 8.0, bottom: 8.0, left: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF68E0F3), Color(0xFFD1F6FC)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.35), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              SvgPicture.asset("assets/images/arrow.svg"),
              // SvgPicture.asset("assets/images/tick.svg"),
              // const Text("15:25"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        title!,
                        style: const TextStyle(fontFamily: "Negar"),
                      ),
                    ),
                    Text(
                      subTitle!,
                      style: const TextStyle(fontFamily: "Negar"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 40 + 10,
          child: SvgPicture.asset(
            "assets/images/label_red.svg",
            color: labelColor,
          ),
        ),
      ]),
    );
  }
}
