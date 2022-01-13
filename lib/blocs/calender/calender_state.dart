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
