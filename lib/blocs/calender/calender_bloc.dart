import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/models/adequacy.dart';
import 'package:today/models/date_details.dart';
import 'package:today/models/today.dart';
import 'package:today/utils/date_converter.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  bool isPreviousYearFullYear = false; // kabise

  int esfandLengthInPreviousYear = 29;
  List<String> holidayTitles = [];
  List<Adequacy> shamsiAdequacies = [];
  DateDetails dateDetails =
      DateDetails(1401, 1, 2, 4, 1, 29, false, [""], 1, 1);

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

  CalenderBloc()
      : super(InitialCalenderState(
            DateDetails(1401, 1, 2, 3, 1, 29, false, [""], 1, 1))) {
    on<InitialCalenderEvent>((event, emit) async {
      await initialization();
      emit(InitialCalenderState(dateDetails));
      await Future.delayed(Duration.zero); //why we need this line?
      emit(MonthAdequaciesCalenderState(
          await loadShamsiAdequacyJson(dateDetails.month), dateDetails));
    });
    on<MonthAdequaciesSentCalenderEvent>((event, emit) {
      emit(MonthAdequaciesCalenderState(event.adequacies, dateDetails));
    });

    on<CalendarScrolledCalenderEvent>((event, emit) async {
      print("month id: ${event.monthId}");
      // updateContent(event.monthId);
      // print(dateDetails);
      emit(MonthUpdatedCalenderState(await updateContent(event.monthId)));
      await Future.delayed(Duration.zero);
      emit(MonthAdequaciesCalenderState(
          await loadShamsiAdequacyJson(event.monthId), dateDetails));
    });

    //when we select a day box to be colorized
    on<DaySelectedCalenderEvent>((event, emit) async {
      //to not pick date from the past
      print("${event.day} vs ${dateDetails.day}");
      print("${event.month} vs ${dateDetails.monthInYear}");
      print("${event.year} vs ${getThisYear()}");

      bool isAfterToday = DateTime(event.year, event.month, event.day).isAfter(
          DateTime(getThisYear(), dateDetails.monthInYear, dateDetails.day));
      if (isAfterToday || !event.isDatePicker) {
        emit(ContentRefreshedCalenderState(
            dateDetails, event.day, event.month, event.year));
      } else {
        emit(ContentRefreshedCalenderState(dateDetails, 0, 0, 0));
        print("you chose from past!!!");
      }
    });
  }

  Future<void> initialization() async {
    print("initialization calendar bloc");
    print("esfandlepr: $esfandLengthInPreviousYear");
    // int initialPage = _getTodayInShamsi().monthInYear - 1;
    // print("initialPage $initialPage");

    // currentMonth = initialPage;
    // currentStartDay = getFirstDayInMonth();
    // thisYear = getThisYear();

    // getStartDay();
    // getEndDay();
    // getFirstDayInMonth();
    // loadJson().then((value) {});

    //shamsi adequacy

    dateDetails.month = _getTodayInShamsi().monthInYear - 1;
    dateDetails.currentStartDay = getFirstDayInMonth();
    dateDetails.esfandLength =
        (getThisYear() - 1399).abs().remainder(4) == 0 ? 30 : 29;
    isPreviousYearFullYear =
        (getThisYear() - 1 - 1399).abs().remainder(4) == 0 ? true : false;

    esfandLengthInPreviousYear = isPreviousYearFullYear ? 30 : 29;
    //initialize datedetails
    dateDetails = DateDetails(
      getThisYear(), //for start
      _getTodayInShamsi().monthInYear - 1, //just for start
      _getTodayInShamsi().dayInMonth,
      getFirstDayInMonth(), //just for start , for initialization
      (getThisYear() - 1399).abs().remainder(4) == 0 ? 30 : 29,
      _getTodayInShamsi().monthInYear - 1,
      (getThisYear() - 1399).abs().remainder(4) == 0 ? true : false,
      await getHolidayDates(),
      getStartDayPreviousMonth(),
      getStartNextMonth(),
    );
    // loadShamsiAdequacyJson(dateDetails.month).then((value) {});
  }

  Future<DateDetails> updateContent(int index) async {
    // setState(() {
    // getStartDay();
    // getEndDay();
    // print("$currentStartDay**");

    if (dateDetails.month > index) {
      dateDetails.currentStartDay = dateDetails.startDayPreviousMonth;
    } else if (dateDetails.month < index) {
      dateDetails.currentStartDay = dateDetails.startDayNextMonth;
    }
    // for start new year
    if (dateDetails.month == 11 && index == 0) {
      dateDetails.year++;
      dateDetails.currentStartDay = dateDetails.startDayNextMonth;
    }
    // for go back to previous year
    if (dateDetails.month == 0 && index == 11) {
      dateDetails.year--;
      dateDetails.currentStartDay = dateDetails.startDayPreviousMonth;
    }
    // after updating thisYear
    dateDetails.isFullYear =
        (dateDetails.year - 1399).abs().remainder(4) == 0 ? true : false;
    isPreviousYearFullYear =
        (dateDetails.year - 1 - 1399).abs().remainder(4) == 0 ? true : false;
    dateDetails.esfandLength = dateDetails.isFullYear ? 30 : 29;
    esfandLengthInPreviousYear = isPreviousYearFullYear ? 30 : 29;

    // print("$currentStartDay**");
    print(dateDetails.year);
    print(" index=$index , isFullYear: ${dateDetails.isFullYear}");
    dateDetails.month = index;

    dateDetails = DateDetails(
      dateDetails.year,
      dateDetails.month,
      _getTodayInShamsi().dayInMonth,
      dateDetails.currentStartDay,
      dateDetails.esfandLength,
      _getTodayInShamsi().monthInYear - 1,
      dateDetails.isFullYear,
      await getHolidayDates(),
      getStartDayPreviousMonth(),
      getStartNextMonth(),
    );
    return dateDetails;

    // currentStartDay++;
    // });
  }

  int getThisYear() {
    int thisYear = 1400;
    int daysCount =
        (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;
    thisYear = (daysCount / 364).floor() + 1400;
    print("this year= $thisYear");
    return thisYear;
  }

  int getStartNextMonth() {
    int startDayNextMonth;
    int todayNumber = dateDetails.currentStartDay;
    int monthNumber = dateDetails.month;
    int monthLength = monthNumber == 11
        ? dateDetails.esfandLength
        : (monthNumber > 5 ? 30 : 31);
    int currentEndDay =
        todayNumber + (monthLength - (monthLength / 7).floor() * 7 - 1);
    startDayNextMonth = currentEndDay + 1;
    currentEndDay = currentEndDay > 6 ? currentEndDay - 7 : currentEndDay;
    currentEndDay = currentEndDay < 0 ? currentEndDay + 7 : currentEndDay;
    // print("currentEndDay $currentEndDay");
    startDayNextMonth =
        startDayNextMonth > 6 ? startDayNextMonth - 7 : startDayNextMonth;
    startDayNextMonth =
        startDayNextMonth < 0 ? startDayNextMonth + 7 : startDayNextMonth;
    // print("startDayNextMonth $startDayNextMonth");
    // print("startDay $currentStartDay");
    print("-------------------------------");
    return startDayNextMonth;
  }

  int getStartDayPreviousMonth() {
    int startDayPreviousMonth;
    int previousMonthNumber = dateDetails.month - 1;
    if (previousMonthNumber < 0) previousMonthNumber = 11;
    int previousMonthLength = previousMonthNumber == 11
        ? esfandLengthInPreviousYear
        : (previousMonthNumber > 5 ? 30 : 31);
    // int currentMonthLength = currentMonth == 11 ? 29 : (currentMonth > 5 ? 30 : 31);
    // int currentEndDay = todayNumber + (currentMonthLength - (currentMonthLength / 7).round() * 7 - 1);
    // currentEndDay = currentEndDay > 6 ? currentEndDay - 7 : currentEndDay;
    int previousMontEndDay = dateDetails.currentStartDay - 1;
    previousMontEndDay =
        previousMontEndDay < 0 ? previousMontEndDay + 7 : previousMontEndDay;
    previousMontEndDay =
        previousMontEndDay > 6 ? previousMontEndDay - 7 : previousMontEndDay;
    // print("previousMontEndDay $previousMontEndDay");
    startDayPreviousMonth = previousMontEndDay -
        (previousMonthLength - (previousMonthLength / 7).floor() * 7 - 1);
    startDayPreviousMonth = startDayPreviousMonth < 0
        ? startDayPreviousMonth + 7
        : startDayPreviousMonth;
    startDayPreviousMonth = startDayPreviousMonth > 6
        ? startDayPreviousMonth - 7
        : startDayPreviousMonth;
    print("previousMonthLength $previousMonthLength");
    print("startDayPreviousMonth $startDayPreviousMonth");
    return startDayPreviousMonth;
  }

  Today _getTodayInShamsi() {
    int dayCount =
        ((DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1) % 365;

    int monthInYear = 1;
    int dayInMonth = dayCount;
    int sumMonth = 31;
    int monthAdd = 31;
    while (dayCount > sumMonth) {
      dayInMonth = dayCount - sumMonth;
      sumMonth += monthAdd;
      monthInYear++;
      if (monthInYear >= 6) {
        monthAdd = 30;
      } else if (monthInYear == 12) {
        monthAdd = dateDetails.esfandLength;
      }
    }

    final today = Today(dayInMonth, monthInYear);
    // currentMonth = month;
    // print(
    //     "dayCount: $dayCount , month: $monthInYear , day: $dayInMonth , hour: ${DateTime.now().hour}");
    return today;
  }

  int getFirstDayInMonth() {
    final today = _getTodayInShamsi();

    // print("dayInMonth $dayInMonth");

    // int dayInSeven = dayInMonth - (dayInMonth / 7).floor();
    // print("dayInSeven: $dayInSeven");
    // int month = todayDate[1];

    // 1:sat 2:sun 3:mon 4:...
    int dayInSeven = (DateTime.now().difference(DateTime(2021, 1, 1)).inDays) -
        (DateTime.now().difference(DateTime(2021, 1, 1)).inDays / 7).floor() *
            7;
    // int diff = todayNumber - dayInSeven;
    // print("diff: $diff");
    int firstDay = dayInSeven - today.dayInMonth.remainder(7).toInt();
    // print("firstDay $firstDay");
    // print("todayNumber $todayNumber");
    // print("dayInSeven $dayInSeven");
    firstDay = firstDay > 6 ? firstDay - 7 : firstDay;
    firstDay = firstDay < 0 ? firstDay + 7 : firstDay;
    return firstDay;
  }

  Future<List<Adequacy>> loadShamsiAdequacyJson(int currentMonth) async {
    List<Adequacy> adequacies = [];
    var data = await rootBundle.loadString('assets/json/shamsi_adequacy.json');
    List<dynamic> jsonResult = jsonDecode(data);

    //try to adding miladi adequacies to shamsi ones
    data = await rootBundle.loadString('assets/json/miladi_adequacy.json');
    List<dynamic> miladiJsonResult = jsonDecode(data);
    for (int i = 0; i < miladiJsonResult.length; i++) {
      String date = (miladiJsonResult.elementAt(i) as Map<String, dynamic>)
          .keys
          .toList()[0]
          .toString(); //sample:"0101"
      String title = (miladiJsonResult.elementAt(i) as Map<String, dynamic>)
          .values
          .toList()[0]
          .toString();
      String shamsiDate = convertMiladiToShamsi(date);
      Map<String, dynamic> element = {shamsiDate: title};

      jsonResult.add(element);
    }
    //
    currentMonth++; //the first is 0
    String stringMonth = currentMonth < 10 ? "0$currentMonth" : "$currentMonth";

    //select adequacies of target month
    jsonResult = jsonResult
        .where((element) =>
            (element as Map<String, dynamic>)
                .keys
                .toList()[0]
                .toString()
                .substring(0, 2) ==
            stringMonth)
        .toList();

    jsonResult.sort((a, b) => a.keys.first.compareTo(b.keys.first));

    ////trying to have unique keys
    // List<String> keys = [];
    // List<String> values = [];
    // jsonResult.forEach((element) {
    //   if (keys.contains(element.keys.first)) {
    //     print(element.keys.first);
    //     values[keys.indexOf(element.keys.first)] =
    //         values[keys.indexOf(element.keys.first)].toString() +
    //             element.values.first;
    //     jsonResult.removeWhere((e) => e.keys.first == element.keys.first);
    //   } else {
    //     values.add(element.values.first);
    //     keys.add(element.keys.first);
    //   }
    // });

    for (var i = 0; i < jsonResult.length; i++) {
      String date = (jsonResult.elementAt(i) as Map<String, dynamic>)
          .keys
          .toList()[0]
          .toString(); //sample:"0101"
      String title = (jsonResult.elementAt(i) as Map<String, dynamic>)
          .values
          .toList()[0]
          .toString();

      // shamsiAdequacyCountPerMonth[int.parse(date.substring(0, 2)) - 1]++;

      adequacies.add(Adequacy(
        title: title,
        dayTitle: numberToDayTitle(date.substring(2)),
        dayNumber: date.substring(2),
        month: numberToMonthTitle(date.substring(0, 2)),
      ));
    }

    return adequacies;
  }

  String convertMiladiToShamsi(String miladi) {
    List<int> shamsi = gregorianToJalali(
      2021,
      int.parse(miladi.substring(0, 2)),
      int.parse(miladi.substring(2)),
    ); // sample [1400,02,10]
    String stringMonth = shamsi[1] < 10 ? "0${shamsi[1]}" : "${shamsi[1]}";
    String stringDay = shamsi[2] < 10 ? "0${shamsi[2]}" : "${shamsi[2]}";
    return stringMonth + stringDay;
  }

  String numberToDayTitle(String number) {
    return "شنبه";
  }

  String numberToMonthTitle(String number) {
    int num = int.parse(number) - 1;
    return months[num];
  }

  //shamsi adequacy (??) all adequacy in shamsi date
  // Future<List<Adequacy>> getAdequaciesList(int currentMonth) async {
  //   List<Adequacy> adequacies = [];
  //   // for (var i = 0; i < holidayCountPerMonth[currentMonth]; i++) {
  //   int startIndex = 0;
  //   for (var i = 0; i < currentMonth; i++) {
  //     startIndex = startIndex + shamsiAdequacyCountPerMonth[i];
  //   }

  //   int endIndex = shamsiAdequacyCountPerMonth[currentMonth] + startIndex;
  //   print(currentMonth);
  //   print(startIndex);
  //   print(endIndex);
  //   // if (startIndex == endIndex)
  //   //   print(endIndex);
  //   // else
  //   print(shamsiAdequacies.length);
  //   adequacies = shamsiAdequacies.sublist(startIndex, endIndex);
  //   // }

  //   return adequacies;
  // }

  Future<List<String>> getHolidayDates() async {
    List<String> holidayDates = [];
    var data = await rootBundle.loadString('assets/json/shamsi_holiday.json');
    List<dynamic> jsonResult = jsonDecode(data);

    for (var i = 0; i < jsonResult.length; i++) {
      String date =
          jsonResult.elementAt(i)["date"] ?? "1111111111111111"; //sample:"0101"

      holidayDates.add(date);
    }

    return holidayDates;
  }
}
