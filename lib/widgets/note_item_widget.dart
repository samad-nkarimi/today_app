import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:today/widgets/form_widget.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';

class NoteItem extends StatefulWidget {
  final Note note;

  const NoteItem(this.note, {Key? key}) : super(key: key);

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  double cornerSize = 25;
  Color backColor = Colors.red;
  // bool isColorSet = false;
  var oldDirection = DismissDirection.down;
  double crossOffset = 0;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // print(labelColor.toString());

    return Container(
      height: 80,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerSize),
        // border: Border.all(width: 1, color: Colors.black),
        color: backColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 1.0),

      // padding: const EdgeInsets.only(right: 8.0, left: 14.0),
      child: Dismissible(
        key: Key(widget.note.getId.toString()),
        confirmDismiss: (direction) async {
          print("confirm");

          if (direction == DismissDirection.endToStart) {
            // remove the note
            BlocProvider.of<NoteBloc>(context)
                .add(NoteWasRemovedEvent(widget.note));
            return true; //true -> will remove the item!
          } else if (direction == DismissDirection.startToEnd) {
            // confirm doing the note
            BlocProvider.of<NoteBloc>(context)
                .add(NoteWasDoneEvent(widget.note));
          } else {
            return false;
          }
        },
        crossAxisEndOffset: crossOffset,
        onUpdate: (d) {
          print(oldDirection);
          if (oldDirection == null || oldDirection != d.direction) {
            print("into iffff");
            if (d.direction == DismissDirection.endToStart) {
              setState(() {
                backColor = Colors.red;
                // crossOffset = -0.2;
              });
            } else {
              setState(() {
                backColor =
                    widget.note.isDone ? Colors.greenAccent : Colors.green;
                // crossOffset = 0.2;
              });
            }
            oldDirection = d.direction;
          }
        },
        onDismissed: (d) {
          print(d.index);
        },
        secondaryBackground: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(""),
                Text("delete", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerSize),
            color: Colors.red,
          ),
        ),
        background: FutureBuilder<bool>(
            future: Future.delayed(const Duration(seconds: 1))
                .then((value) => widget.note.isDone),
            initialData: widget.note.isDone,
            builder: (context, snapshot) {
              return Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(snapshot.data! ? "undo" : "done",
                          style: const TextStyle(color: Colors.white)),
                      const Text(""),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cornerSize),
                  color: snapshot.data! ? Colors.greenAccent : Colors.green,
                ),
              );
            }),
        child: _noteContentWidget(),
      ),
    );
  }

  Widget _noteContentWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) {
              return FormWidget(
                initialData: widget.note,
              );
            },
          ),
        );
        // // copied from home page
        // showModalBottomSheet(
        //   isScrollControlled: true,
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(30.0),
        //       topRight: Radius.circular(30.0),
        //     ),
        //   ),
        //   context: context,
        //   builder: (context) {
        //     return Container(
        //       // height: 300,
        //       color: Colors.transparent,
        //       child: FormWidget(
        //         initialTitle: widget.note.title,
        //         initialSubtitle: widget.note.subTitle,
        //       ),
        //     );
        //   },
        // );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        // margin: const EdgeInsets.symmetric(vertical: 1.0),
        padding: const EdgeInsets.only(right: 16.0, left: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerSize),
          border: Border.all(width: 1, color: Colors.white38),
          gradient: RadialGradient(
            colors: [
              widget.note.isDone
                  ? Colors.green.shade700
                  : const Color(0xFFBC00AA),
              widget.note.isDone ? Colors.white : const Color(0xFF00C8CF),
            ],
            center: Alignment.topRight,
            radius: 3.5, focalRadius: 3,
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft,
          ),
          // boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.35), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 3))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 135,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // if (!widget.note.isDone)
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.note.isDone
                            ? SvgPicture.asset(
                                "assets/images/tick.svg",
                                color: Colors.purple,
                              )
                            : SvgPicture.asset("assets/images/arrow.svg"),
                        Text(widget.note.dayName,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  // if (widget.note.isDone)
                  // SvgPicture.asset(
                  //   "assets/images/tick.svg",
                  //   color: Colors.purple,
                  // ),
                  // const Text("15:25"),
                  // const Spacer(),
                  Flexible(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerRight,
                      // width: 170,
                      // color: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              widget.note.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.white),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            widget.note.subTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/images/label_red.svg",
                color: widget.note.getColorFromIndex((widget.note.labelColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
