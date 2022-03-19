import 'package:equatable/equatable.dart';
import './models.dart';

class Notes extends Equatable {
  List<Note> notesList = [];

  int get getNotesCount {
    return notesList.length;
  }

  void setAllNotes(List<Note> notes) {
    notesList = notes;
  }

  void addToNotes(Note newNote) {
    notesList.add(newNote);
  }

  void updateSingleNote(Note updatedNote) {
    int index = notesList.indexWhere((note) => note.getId == updatedNote.getId);
    notesList.removeAt(index);
    notesList.insert(index, updatedNote);
  }

  List<Note> get getTodayNotes =>
      notesList.where((element) => !element.isTodayNote).toList();
  List<Note> get getCalenderNotes =>
      notesList.where((element) => element.isTodayNote).toList();

  void removeFromNotes(Note newNote) {
    notesList.remove(newNote);
  }

  @override
  List<Object?> get props => [notesList, getNotesCount];

  @override
  String toString() {
    return notesList.toString();
  }
}
