import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  String id;
  String title;
  String subTitle;
  Color labelColor;
  bool isTodayNote;
  bool isDone;

  // int isTodayNote_intFormat = 0;

  Note(
    this.title,
    this.subTitle, {
    this.id = "0",
    this.labelColor = Colors.orange,
    this.isTodayNote = false,
    this.isDone = false,
  });
  // {
  //   // id = getRandomString();
  //   // isTodayNote_intFormat = isTodayNote ? 1 : 0;
  // }

  void setTitle(String title) {
    this.title = title;
  }

  void setId(String id) {
    this.id = id;
  }

  void setSubTitle(String subTitle) {
    this.subTitle = subTitle;
  }

  void setLabelColor(int colorIndex) {
    switch (colorIndex) {
      case 0:
        labelColor = Colors.red;
        break;
      case 1:
        labelColor = Colors.blueGrey;
        break;
      case 2:
        labelColor = Colors.green;
        break;
      default:
        labelColor = Colors.orange;
    }
    // labelColor = color;
  }

  String get getId {
    return id;
  }

  // Convert a Note into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subTitle,
      'istoday': isTodayNote ? 1 : 0,
      'isdone': isDone ? 1 : 0,
    };
  }

  final _chars = 'AaBbCcDdFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String getRandomString() {
    return String.fromCharCodes(
      Iterable.generate(
        15,
        (_) => _chars.codeUnitAt(Random().nextInt(_chars.length)),
      ),
    );
  }

  @override
  List<Object?> get props => [title, subTitle, labelColor, isTodayNote, isDone];

  // @override
  // String toString() {
  //   return "Note title: $title , subTitle: $subTitle , isToday: $isTodayNote";
  // }

  @override
  String toString() {
    return "{ Note id:$id , isDone:$isDone }";
  }
}
