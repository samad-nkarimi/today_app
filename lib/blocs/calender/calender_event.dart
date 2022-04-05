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
  final bool isDatePicker;
  final int day;
  final int month;
  final int year;
  DaySelectedCalenderEvent(this.isDatePicker, this.day, this.month, this.year);
  @override
  List<Object?> get props => [isDatePicker, day, month, year];
}
