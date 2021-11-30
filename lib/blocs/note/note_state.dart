import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';

abstract class NoteState extends Equatable {
  final Note note;
  const NoteState(this.note);

  @override
  List<Object> get props => [note];
}

class NewNoteIsAdded extends NoteState {
  const NewNoteIsAdded(Note note) : super(note);

  @override
  List<Object> get props =>[note];
}
class NoNote extends NoteState {
  const NoNote(Note note) : super(note);



  @override
  List<Object> get props => [note];
}
