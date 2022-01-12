import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // print(labelColor.toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 1.0),
      // padding: const EdgeInsets.only(right: 8.0, left: 14.0),
      child: Dismissible(
        key: Key(note.getId.toString()),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            BlocProvider.of<NoteBloc>(context).add(NoteWasRemoved(note));
            return true;
          } else {
            return false;
          }
        },
        onDismissed: (d) {
          print(d.index);
        },
        secondaryBackground: Container(
          color: Colors.red,
          child: const Center(
            child: Text("delete"),
          ),
        ),
        background: Container(color: Colors.grey),
        child: Container(
          // margin: const EdgeInsets.symmetric(vertical: 1.0),
          padding: const EdgeInsets.only(right: 8.0, left: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF68E0F3), Color(0xFFD1F6FC)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
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
                    Flexible(
                      flex: 1,
                      child: SvgPicture.asset("assets/images/arrow.svg"),
                    ),
                    // SvgPicture.asset("assets/images/tick.svg"),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                note.title,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Text(
                              note.subTitle,
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
                  color: note.labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
