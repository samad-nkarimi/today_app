// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/models/models.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoNote(Note("", ""))) {

    on<NewNoteWasSent>(
      (event, emit) {
        print(event.note.title);
        emit(NewNoteIsAdded(event.note));
      },
    );
  }


  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
