import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        dashPattern: const [10, 5],
        color: Colors.grey,
        strokeWidth: 1.5,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("افزودن یادداشت", style: Theme.of(context).textTheme.button),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.add_circle_outline, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
    // Container(
    //   // constraints: BoxConstraints(maxWidth: 100),
    //   padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
    //   decoration: BoxDecoration(boxShadow: [
    //     BoxShadow(
    //       color: Colors.white.withOpacity(0.35),
    //       spreadRadius: 1,
    //       blurRadius: 2,
    //       offset: const Offset(0, 2),
    //     ),
    //   ], color: Colors.blue, borderRadius: BorderRadius.circular(25.0)),

    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text("افزودن یادداشت", style: Theme.of(context).textTheme.button),
    //     const Padding(
    //       padding: EdgeInsets.only(left: 5.0),
    //       child: Icon(Icons.add_circle_outline, color: Colors.white),
    //     ),
    //   ],
    // ),
    // );
  }
}
