
import 'package:bloc/bloc.dart';
import 'package:today_app/models/models.dart';

import './note_event.dart';
import './note_state.dart';

class BmiCalcBloc extends Bloc<NoteState, NoteEvent> {

  BmiCalcBloc() : super(const NoNote(Note("no","no")));

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {

  }









}
