import 'package:bloc/bloc.dart';
import 'package:today/blocs/blocs.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  CalenderBloc() : super(InitialCalenderState()) {
    on<MonthAdequaciesSentCalenderEvent>((event, emit) {
      emit(MonthAdequaciesCalenderState(event.adequacies));
    });
  }
}
