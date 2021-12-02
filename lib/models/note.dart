import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  String id;
  String title;
  String subTitle;
  Color labelColor;
  bool isTodayNote;

  Note(this.title, this.subTitle, {this.id="0", this.labelColor = Colors.orange,this.isTodayNote=false}) {
    id = getRandomString();
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setSubTitle(String subTitle) {
    this.subTitle = subTitle;
  }

  void setLabelColor(Color color) {
    labelColor = color;
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subTitle,
    };
  }

  final _chars = 'AaBbCcDdFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String getRandomString() {
    return String.fromCharCodes(
      Iterable.generate(15, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, subTitle, labelColor];

  @override
  String toString() {
    // TODO: implement toString
    return "Note title: $title , subTitle: $subTitle";
  }
}
