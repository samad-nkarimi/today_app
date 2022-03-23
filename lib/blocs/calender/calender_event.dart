import 'package:equatable/equatable.dart';
import 'package:today/models/models.dart';

abstract class CalenderEvent extends Equatable {}

class MonthAdequaciesSentCalenderEvent extends CalenderEvent {
  final List<Adequacy> adequacies;

  MonthAdequaciesSentCalenderEvent(this.adequacies);
  @override
  List<Object?> get props => [adequacies];
}

class CalendarScrolledCalenderEvent extends CalenderEvent {
  final int monthId;

  CalendarScrolledCalenderEvent(this.monthId);
  @override
  List<Object?> get props => [monthId];
}

class InitialCalenderEvent extends CalenderEvent {
  InitialCalenderEvent();
  @override
  List<Object?> get props => [];
}

class DaySelectedCalenderEvent extends CalenderEvent {
  final String day;
  DaySelectedCalenderEvent(this.day);
  @override
  List<Object?> get props => [day];
}
