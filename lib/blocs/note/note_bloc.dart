// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/models/models.dart';

import './note_event.dart';
import './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoNote(Note("", ""))) {
    // @override
    // Stream<NoteState> mapEventToState(NoteEvent event) async* {
    //   super.onEvent(event);
    //   if(event is NewNoteWasSent){
    //     print("title: ${event.note.title}");
    //     yield NewNoteIsAdded(event.note);
    //   }
    // }
    on<NewNoteWasSent>((event, emit) {
      print(event.note.title);
    });
  }

// @override
//   void onEvent(NoteEvent event) {
//   if(event is NewNoteWasSent){
//     print("title: ${event.note.title}");
//     emit( NewNoteIsAdded(event.note));
//   }
//     super.onEvent(event);
//   }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
