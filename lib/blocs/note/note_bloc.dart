// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/database/database_provider.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseProvider _databaseProvider;
  final Notes _notes;

  NoteBloc(this._databaseProvider, this._notes) : super(StateInitialized(Note("", ""), _notes)) {
    on<NewNoteWasSent>(
      (event, emit) async {
        // print(event.note.title);

        Notes notes = state.notes;
        notes.addToNotes(event.note);
        // print("isToday: ${event.note.isTodayNote}");
        await _databaseProvider.insertNote(event.note);
        print("before: ${event.note.isTodayNote}");
        emit(NewNoteIsAdded(event.note, notes));
      },
    );

    on<NoteWasRemoved> (
      (event, emit) async{
        Notes notes = state.notes;
        notes.removeFromNotes(event.note);
        print("notes id: ${event.note.getId}");
        await _databaseProvider.deleteNote(event.note);
        emit(NotesUpdated(event.note, notes));
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
