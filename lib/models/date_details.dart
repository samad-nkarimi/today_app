import 'package:equatable/equatable.dart';

class DateDetails extends Equatable {
  int year;
  int month;
  final int day;
  int currentStartDay;
  int esfandLength;
  int monthInYear;
  bool isFullYear;
  final List<String> holidayDates;
  final int startDayPreviousMonth;
  final int startDayNextMonth;

  DateDetails(
    this.year,
    this.month,
    this.day,
    this.currentStartDay,
    this.esfandLength,
    this.monthInYear,
    this.isFullYear,
    this.holidayDates,
    this.startDayPreviousMonth,
    this.startDayNextMonth,
  );

  @override
  List<Object?> get props => [
        year,
        month,
        day,
        currentStartDay,
        esfandLength,
        monthInYear,
        isFullYear,
        holidayDates,
        startDayPreviousMonth,
        startDayNextMonth,
      ];

  @override
  String toString() {
    return "$year/$month/$day - $currentStartDay";
  }
}
