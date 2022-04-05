import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  String id;
  String title;
  String subTitle;
  int labelColor;
  bool isTodayNote;
  bool isDone;
  int hour; //12
  int day; //1,2,3,...
  String dayName; //sunday,...
  int month; //0,1,2,3
  int year;

  int repeat;

  // int isTodayNote_intFormat = 0;

  Note(
    this.title,
    this.subTitle, {
    this.id = "0",
    this.labelColor = 0,
    this.isTodayNote = false,
    this.isDone = false,
    this.hour = 0,
    this.day = 0,
    this.dayName = "",
    this.month = 0,
    this.year = 0,
    this.repeat = 0,
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

  final List<Color> colors = [
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.green,
  ];

  Color getColorFromIndex(int colorIndex) {
    return colors[colorIndex];

    // switch (colorIndex) {
    //   case 0:
    //     labelColor = colors[colorIndex];
    //     break;
    //   case 1:
    //     labelColor = Colors.blueGrey;
    //     break;
    //   case 2:
    //     labelColor = Colors.green;
    //     break;
    //   default:
    //     labelColor = Colors.orange;
    // }
    // labelColor = color;
  }

  String get getId {
    return id;
  }

  //to convert a calendar note to today note by changing some properties
  void convertToTodayNote() {
    dayName = "";
    hour = 0;
    day = 0;
    month = 0;
    isTodayNote = false;
  }

  // Convert a Note into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subTitle,
      'color': labelColor,
      'istoday': isTodayNote ? 1 : 0,
      'isdone': isDone ? 1 : 0,
      'hour': hour,
      'day': day,
      'month': month,
      'year': year,
      'dayname': dayName,
    };
  }

  Map<String, dynamic> toMapForHistory() {
    return {
      'id': id,
      'repeat': repeat,
      'title': title,
      'subtitle': subTitle,
      'color': labelColor,
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
    return "{ Note id:$id , sub:$subTitle }";
  }
}
