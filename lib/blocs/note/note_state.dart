import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class NoteState extends Equatable {
  final Note note;
  final Notes notes;

  const NoteState(this.note, this.notes);

  @override
  List<Object> get props => [note, notes, note.isDone, note.title];
}

class NewNoteIsAdded extends NoteState {
  const NewNoteIsAdded(Note note, Notes notes) : super(note, notes);

  @override
  List<Object> get props => [note, notes];
}

//when app is started
class StateInitialized extends NoteState {
  const StateInitialized(Note note, Notes notes) : super(note, notes);

  @override
  List<Object> get props => [note, notes];
}

class NoNote extends NoteState {
  const NoNote(Note note, Notes notes) : super(note, notes);

  @override
  List<Object> get props => [note];
}

class NotesUpdatedState extends NoteState {
  final Note note;
  final Notes notes;
  final bool isDone;
  const NotesUpdatedState(this.note, this.notes, this.isDone)
      : super(note, notes);

  @override
  List<Object> get props => [note, notes, notes.notesList.length, isDone];
}
