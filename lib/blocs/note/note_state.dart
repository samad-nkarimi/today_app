import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';

abstract class NoteState extends Equatable {
  final Note note;
  final Notes notes;
  const NoteState(this.note,this.notes);

  @override
  List<Object> get props => [note];
}

class NewNoteIsAdded extends NoteState {
  const NewNoteIsAdded(Note note,Notes notes) : super(note,notes);

  @override
  List<Object> get props =>[note];
}
class NoNote extends NoteState {
  const NoNote(Note note,Notes notes) : super(note,notes);



  @override
  List<Object> get props => [note];
}

class NotesUpdated extends NoteState {

   const NotesUpdated(Note note, notes) : super(note,notes);

  @override
  List<Object> get props =>[note,notes];
}
