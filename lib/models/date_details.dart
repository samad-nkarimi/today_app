import 'package:equatable/equatable.dart';

class DateDetails extends Equatable {
  final int year;
  final int month;
  final int day;
  final int startDay;
  final int esfandLength;
  final int monthInYear;
  final bool isFullYear;
  final List<String> holidayDates;

  const DateDetails(
    this.year,
    this.month,
    this.day,
    this.startDay,
    this.esfandLength,
    this.monthInYear,
    this.isFullYear,
    this.holidayDates,
  );

  @override
  List<Object?> get props => [
        year,
        month,
        day,
        startDay,
        esfandLength,
        monthInYear,
        isFullYear,
        holidayDates
      ];

  @override
  String toString() {
    return "$year/$month/$day - $startDay";
  }
}
