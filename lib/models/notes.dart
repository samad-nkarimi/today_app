import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';

class Notes extends Equatable {
  List<Note> notesList = [];

  int get getNotesCount {
    return notesList.length;
  }

  void addToNotes(Note newNote) {
    notesList.add(newNote);
  }

  @override
  List<Object?> get props => [notesList, getNotesCount];

  @override
  String toString() {

    return notesList.toString();
  }
}
