import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';

abstract class NoteEvent extends Equatable {
  final Note note;
   const NoteEvent(this.note);
  @override
  List<Object> get props => [note];
}
class NoNote extends NoteEvent {
  const NoNote(Note note) : super(note);



  @override
  List<Object> get props => [note];
}

class NewNoteWasSent extends NoteEvent {
  const NewNoteWasSent(Note note) : super(note);



  @override
  List<Object> get props => [note];
}

class NoteWasDone extends NoteEvent {
  const NoteWasDone(Note note) : super(note);



  @override
  List<Object> get props => [note];
}
class NoteWasRemoved extends NoteEvent {
  const NoteWasRemoved(Note note) : super(note);



  @override
  List<Object> get props => [note];
}