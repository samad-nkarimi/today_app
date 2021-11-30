

import 'package:equatable/equatable.dart';

class Note extends Equatable{

   String? title;
   String? subTitle;

   Note(this.title,this.subTitle);

  void setTitle(String? title){
    this.title=title;
  }
   void setSubTitle(String? subTitle){
     this.subTitle=subTitle;
   }
  @override
  // TODO: implement props
  List<Object?> get props => [title,subTitle];

  @override
  String toString() {
    // TODO: implement toString
    return "Note title: $title , subTitle: $subTitle";
  }

}