// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/database_provider.dart';
import '../../models/models.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseProvider _databaseProvider;
  Notes _notes;

  NoteBloc(this._databaseProvider, this._notes)
      : super(StateInitialized(Note("", ""), _notes)) {
    on<NewNoteWasSent>(
      (event, emit) async {
        // print(event.note.title);

        _notes = state.notes;
        _notes.addToNotes(event.note);
        // print("isToday: ${event.note.isTodayNote}");
        await _databaseProvider.insertNote(event.note);
        print("before: ${event.note.isTodayNote}");
        emit(NewNoteIsAdded(event.note, _notes));
      },
    );

    on<NoteWasEdittedEvent>(
      (event, emit) async {
        _notes = state.notes;
        _notes.updateSingleNote(event.note);
        await _databaseProvider.insertNote(event.note); //will replace it
        emit(NotesUpdatedState(event.note, _notes, event.note.isDone));
      },
    );

    on<NoteWasRemovedEvent>(
      (event, emit) async {
        _notes = state.notes;
        _notes.removeFromNotes(event.note);
        print("${event.note.getId} was removed");
        await _databaseProvider.deleteNote(event.note);
        emit(NotesUpdatedState(event.note, _notes, event.note.isDone));
      },
    );

    on<NoteWasDoneEvent>(
      (event, emit) async {
        _notes = state.notes;
        _notes.updateSingleNote(event.note);
        print("is done: ${!event.note.isDone}");
        event.note.isDone = !event.note.isDone;
        print("note id: ${event.note.getId}");
        print(_notes);
        // await _databaseProvider.deleteNote(event.note);
        emit(NotesUpdatedState(event.note, _notes, event.note.isDone));
      },
    );
  }
  @override
  void onTransition(Transition<NoteEvent, NoteState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<NoteState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  @override
  void onEvent(NoteEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
