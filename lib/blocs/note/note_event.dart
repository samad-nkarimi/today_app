import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class NoteEvent extends Equatable {
  final Note note;

  const NoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class NewNoteWasSent extends NoteEvent {
  const NewNoteWasSent(Note note) : super(note);

  @override
  List<Object> get props =>
      [note, note.id, note.title, note.subTitle, note.isDone, note.labelColor];
}

class NoteWasDoneEvent extends NoteEvent {
  const NoteWasDoneEvent(Note note) : super(note);

  @override
  List<Object> get props =>
      [note, note.id, note.title, note.subTitle, note.isDone, note.labelColor];
}

class NoteWasRemovedEvent extends NoteEvent {
  final Note note;
  const NoteWasRemovedEvent(this.note) : super(note);

  @override
  List<Object> get props =>
      [note, note.id, note.title, note.subTitle, note.isDone, note.labelColor];
}
