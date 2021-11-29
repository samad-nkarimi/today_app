

import 'package:equatable/equatable.dart';

class Note extends Equatable{

  final String title;
  final String subTitle;

  const Note(this.title,this.subTitle);


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}