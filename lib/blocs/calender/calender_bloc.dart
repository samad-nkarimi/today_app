import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/models/adequacy.dart';
import 'package:today/models/date_details.dart';
import 'package:today/models/today.dart';
import 'package:today/services/date_provider.dart';
import 'package:today/utils/date_converter.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  DateProvider dateProvider;
  DateDetails dt;

  List<String> months = [
    "فروردین",
    "اردیبهشت",
    "خرداد",
    "تیر",
    "مرداد",
    "شهریور",
    "مهر",
    "آبان",
    "آذر",
    "دی",
    "بهمن",
    "اسفند"
  ];

  CalenderBloc(this.dateProvider, this.dt) : super(InitialCalenderState(dt)) {
    on<InitialCalenderEvent>((event, emit) async {
      await dateProvider.initialization();
      emit(InitialCalenderState(dt));
      await Future.delayed(Duration.zero); //why we need this line?
      emit(MonthAdequaciesCalenderState(
          await dateProvider
              .loadShamsiAdequacyJson(dateProvider.dateDetails.month),
          dateProvider.dateDetails));
    });
    on<MonthAdequaciesSentCalenderEvent>((event, emit) {
      emit(MonthAdequaciesCalenderState(
          event.adequacies, dateProvider.dateDetails));
    });

    on<CalendarScrolledCalenderEvent>((event, emit) async {
      print("month id: ${event.monthId}");
      // updateContent(event.monthId);
      // print(dateDetails);
      emit(MonthUpdatedCalenderState(
          await dateProvider.updateContent(event.monthId)));
      await Future.delayed(Duration.zero);
      emit(MonthAdequaciesCalenderState(
          await dateProvider.loadShamsiAdequacyJson(event.monthId),
          dateProvider.dateDetails));
    });

    //when we select a day box to be colorized
    on<DaySelectedCalenderEvent>((event, emit) async {
      //to not pick date from the past
      // print("${event.day} vs ${dateDetails.day}");
      // print("${event.month} vs ${dateDetails.monthInYear}");
      // print("${event.year} vs ${getThisYear()}");

      bool isAfterToday = DateTime(event.year, event.month, event.day).isAfter(
          DateTime(
              dateProvider.getThisYear(),
              dateProvider.dateDetails.monthInYear,
              dateProvider.dateDetails.day));
      if (isAfterToday || !event.isDatePicker) {
        emit(ContentRefreshedCalenderState(
            dateProvider.dateDetails, event.day, event.month, event.year));
      } else {
        emit(ContentRefreshedCalenderState(dateProvider.dateDetails, 0, 0, 0));
        print("you chose from past!!!");
      }
    });
  }
}
