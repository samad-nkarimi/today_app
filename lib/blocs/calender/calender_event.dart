import 'package:equatable/equatable.dart';

abstract class CalenderEvent extends Equatable {}

class MonthAdequaciesSentCalenderEvent extends CalenderEvent {
  final List<String> adequacies;

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
