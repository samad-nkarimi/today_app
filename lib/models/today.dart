import 'package:equatable/equatable.dart';

class Today extends Equatable {
  final int dayInMonth;
  final int monthInYear;

  const Today(this.dayInMonth, this.monthInYear);

  @override
  List<Object?> get props => [];
}
