import 'package:equatable/equatable.dart';

abstract class CalenderState extends Equatable {}

class InitialCalenderState extends CalenderState {
  @override
  List<Object?> get props => [];
}

class MonthAdequaciesCalenderState extends CalenderState {
  final List<String> adequacies;

  MonthAdequaciesCalenderState(this.adequacies);
  @override
  List<Object?> get props => [adequacies];
}

class MonthUpdatedCalenderState extends CalenderState {
  final int monthId;

  MonthUpdatedCalenderState(this.monthId);
  @override
  List<Object?> get props => [monthId];
}
