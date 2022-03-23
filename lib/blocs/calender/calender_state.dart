import 'package:equatable/equatable.dart';
import 'package:today/models/date_details.dart';
import 'package:today/models/models.dart';

abstract class CalenderState extends Equatable {
  final DateDetails dateDetails;
  CalenderState(this.dateDetails);
  List<Object?> get props => [dateDetails];
}

class InitialCalenderState extends CalenderState {
  final DateDetails dateDetails;

  InitialCalenderState(this.dateDetails) : super(dateDetails);
  @override
  List<Object?> get props => [dateDetails];
}

class MonthAdequaciesCalenderState extends CalenderState {
  final List<Adequacy> adequacies;
  final DateDetails dateDetails;

  MonthAdequaciesCalenderState(this.adequacies, this.dateDetails)
      : super(dateDetails);
  @override
  List<Object?> get props => [adequacies];
}

class MonthUpdatedCalenderState extends CalenderState {
  final DateDetails dateDetails;

  MonthUpdatedCalenderState(this.dateDetails) : super(dateDetails);
  @override
  List<Object?> get props => [dateDetails];
}

//after selecting a day
class ContentRefreshedCalenderState extends CalenderState {
  final DateDetails dateDetails;
  final String selectedDay;

  ContentRefreshedCalenderState(this.dateDetails, this.selectedDay)
      : super(dateDetails);
  @override
  List<Object?> get props => [selectedDay];
}

// class DateDetailsCalenderState extends CalenderState {
//   final int year;
//   final int month;
//   final int day;
//   final int startDay;

//   final int esfandLength;
//   final bool isFullYear;
//   final List<int> holidayDates;

//   DateDetailsCalenderState(this.year, this.month, this.day, this.esfandLength,
//       this.isFullYear, this.holidayDates, this.startDay);
//   @override
//   List<Object?> get props => [year, month, day];
// }
