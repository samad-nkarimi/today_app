// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoNote(Note("", ""),Notes())) {

    on<NewNoteWasSent>(
      (event, emit) {
        print(event.note.title);

          Notes notes = state.notes;
          notes.addToNotes(event.note);
          print(notes);

        emit(NewNoteIsAdded(event.note,notes));
      },
    );
  }


  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
