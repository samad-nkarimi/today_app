import 'package:equatable/equatable.dart';

class DateDetails extends Equatable {
  int year; //will change by scrolling
  int month; //this change by scrolling calendar
  final int day; //today in real life
  int currentStartDay;
  int esfandLength;
  int monthInYear; //this is fix, and its the real current month in real life
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
    return "$year/$month/$day - $currentStartDay/$esfandLength/$monthInYear - $isFullYear/$holidayDates/$startDayPreviousMonth/$startDayNextMonth";
  }
}
