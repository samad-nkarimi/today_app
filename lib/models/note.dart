

import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable{

   String? title;
   String? subTitle;
   Color? labelColor;

   Note(this.title,this.subTitle,{this.labelColor=Colors.orange});

  void setTitle(String? title){
    this.title=title;
  }
   void setSubTitle(String? subTitle){
     this.subTitle=subTitle;
   }
   void setLabelColor(Color? color){
    labelColor=color;
   }
  @override
  // TODO: implement props
  List<Object?> get props => [title,subTitle,labelColor];

  @override
  String toString() {
    // TODO: implement toString
    return "Note title: $title , subTitle: $subTitle";
  }

}