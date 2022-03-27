// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/database_provider.dart';
import '../../models/models.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseProvider databaseProvider;
  Notes notes;

  NoteBloc(this.databaseProvider, this.notes)
      : super(StateInitialized(Note("", ""), notes)) {
    on<NewNoteWasSent>(
      (event, emit) async {
        // print(event.note.title);

        notes = state.notes;
        notes.addToNotes(event.note);
        // print("isToday: ${event.note.isTodayNote}");
        await databaseProvider.insertNote(event.note);
        print("before: ${event.note.isTodayNote}");
        emit(NewNoteIsAdded(event.note, notes));
      },
    );

    on<NoteWasEdittedEvent>(
      (event, emit) async {
        notes = state.notes;
        notes.updateSingleNote(event.note);
        await databaseProvider.insertNote(event.note); //will replace it
        emit(NotesUpdatedState(event.note, notes, event.note.isDone));
      },
    );

    on<NoteWasRemovedEvent>(
      (event, emit) async {
        notes = state.notes;
        print(notes.notesList.length);
        notes.removeFromNotes(event.note);
        print("${event.note.getId} was removed");
        await databaseProvider.deleteNote(event.note);
        print(notes.notesList.length);
        emit(NotesUpdatedState(event.note, notes, event.note.isDone,
            remove: true));
      },
    );

    on<NoteWasDoneEvent>(
      (event, emit) async {
        notes = state.notes;
        event.note.isDone = !event.note.isDone;
        notes.updateSingleNote(event.note);
        // print("is done: ${!event.note.isDone}");
        await databaseProvider.insertNote(event.note); //will replace it
        emit(NotesUpdatedState(event.note, notes, event.note.isDone));
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
