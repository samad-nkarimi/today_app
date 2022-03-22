import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/models/adequacy.dart';
import 'package:today/models/date_details.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  int thisYear = 1400;
  int currentMonth = 0;
  int currentStartDay = 0;
  int startDayPreviousMonth = 0;
  int startDayNextMonth = 0;
  bool isFullYear = false; // kabise
  bool isPreviousYearFullYear = false; // kabise
  int esfandLength = 29;
  int esfandLengthInPreviousYear = 29;
  List<String> holidayTitles = [];
  List<String> holidayDates = [];
  List<int> holidayCountPerMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  //shamsi adequacy
  List<String> shamsiAdequacyTitles = [];
  List<String> shamsiAdequacyDates = [];
  List<Adequacy> shamsiAdequacies = [];
  List<int> shamsiAdequacyCountPerMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  DateDetails dateDetails =
      const DateDetails(1401, 1, 2, 4, 1, 29, false, [""]);

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
            const DateDetails(1401, 1, 2, 3, 1, 29, false, [""]))) {
    on<InitialCalenderEvent>((event, emit) {
      initialization();
      emit(InitialCalenderState(dateDetails));
    });
    on<MonthAdequaciesSentCalenderEvent>((event, emit) {
      emit(MonthAdequaciesCalenderState(event.adequacies, dateDetails));
    });

    on<CalendarScrolledCalenderEvent>((event, emit) {
      print("month id: ${event.monthId}");
      // updateContent(event.monthId);
      // print(dateDetails);
      emit(MonthUpdatedCalenderState(updateContent(event.monthId)));
    });
  }

  void initialization() {
    int initialPage = _getTodayInShamsi()[1] - 1;
    print("initialPage $initialPage");

    currentMonth = initialPage;
    currentStartDay = getFirstDayInMonth();
    // thisYear = getThisYear();

    getStartDay();
    getEndDay();
    getFirstDayInMonth();
    loadJson().then((value) {});

    //shamsi adequacy
    loadShamsiAdequacyJson().then((value) {});

    //initialize datedetails
    dateDetails = DateDetails(
      getThisYear(),
      _getTodayInShamsi()[1] - 1,
      _getTodayInShamsi()[0],
      currentStartDay,
      esfandLength,
      _getTodayInShamsi()[1] - 1,
      isFullYear,
      holidayDates,
    );
  }

  DateDetails updateContent(int index) {
    // setState(() {
    getStartDay();
    getEndDay();
    // print("$currentStartDay**");

    if (currentMonth > index) {
      currentStartDay = startDayPreviousMonth;
    } else if (currentMonth < index) {
      currentStartDay = startDayNextMonth;
    }
    // for start new year
    if (currentMonth == 11 && index == 0) {
      thisYear++;
      currentStartDay = startDayNextMonth;
    }
    // for comeback to previous year
    if (currentMonth == 0 && index == 11) {
      thisYear--;
      currentStartDay = startDayPreviousMonth;
    }
    // after updating thisYear
    isFullYear = (thisYear - 1399).abs().remainder(4) == 0 ? true : false;
    isPreviousYearFullYear =
        (thisYear - 1 - 1399).abs().remainder(4) == 0 ? true : false;
    esfandLength = isFullYear ? 30 : 29;
    esfandLengthInPreviousYear = isPreviousYearFullYear ? 30 : 29;

    // print("$currentStartDay**");
    print(thisYear);
    print(
        "currentMonth $currentMonth , index=$index , isFullYear: $isFullYear");
    currentMonth = index;
    return DateDetails(
      thisYear,
      currentMonth,
      _getTodayInShamsi()[0],
      currentStartDay,
      esfandLength,
      _getTodayInShamsi()[1] - 1,
      isFullYear,
      holidayDates,
    );

    // currentStartDay++;
    // });
  }

  int getThisYear() {
    int daysCount =
        (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;
    thisYear = (daysCount / 364).floor() + 1400;
    print("this year= $thisYear");
    return thisYear;
  }

  int getEndDay() {
    int todayNumber = currentStartDay;
    int monthNumber = currentMonth;
    int monthLength =
        monthNumber == 11 ? esfandLength : (monthNumber > 5 ? 30 : 31);
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
    return 1;
  }

  int getStartDay() {
    int todayNumber = currentStartDay;
    int previousMonthNumber = currentMonth - 1;
    if (previousMonthNumber < 0) previousMonthNumber = 11;
    int monthLength = previousMonthNumber == 11
        ? esfandLengthInPreviousYear
        : (previousMonthNumber > 5 ? 30 : 31);
    // int currentMonthLength = currentMonth == 11 ? 29 : (currentMonth > 5 ? 30 : 31);
    // int currentEndDay = todayNumber + (currentMonthLength - (currentMonthLength / 7).round() * 7 - 1);
    // currentEndDay = currentEndDay > 6 ? currentEndDay - 7 : currentEndDay;
    int previousMontEndDay = currentStartDay - 1;
    previousMontEndDay =
        previousMontEndDay < 0 ? previousMontEndDay + 7 : previousMontEndDay;
    previousMontEndDay =
        previousMontEndDay > 6 ? previousMontEndDay - 7 : previousMontEndDay;
    // print("previousMontEndDay $previousMontEndDay");
    startDayPreviousMonth =
        previousMontEndDay - (monthLength - (monthLength / 7).floor() * 7 - 1);
    startDayPreviousMonth = startDayPreviousMonth < 0
        ? startDayPreviousMonth + 7
        : startDayPreviousMonth;
    startDayPreviousMonth = startDayPreviousMonth > 6
        ? startDayPreviousMonth - 7
        : startDayPreviousMonth;
    print("monthLength $monthLength");
    print("startDayPreviousMonth $startDayPreviousMonth");
    return 1;
  }

  List<int> _getTodayInShamsi() {
    List<int> todayDate =
        []; //day number nth in month ,month number nth in year
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
        monthAdd = esfandLength;
      }
    }

    todayDate.add(dayInMonth);
    todayDate.add(monthInYear);
    // currentMonth = month;
    print(
        "dayCount: $dayCount , month: $monthInYear , day: $dayInMonth , hour: ${DateTime.now().hour}");
    return todayDate;
  }

  int getFirstDayInMonth() {
    List<int> todayDate = _getTodayInShamsi();
    int dayInMonth = todayDate[0];
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
    int firstDay = dayInSeven - dayInMonth.remainder(7).toInt();
    // print("firstDay $firstDay");
    // print("todayNumber $todayNumber");
    // print("dayInSeven $dayInSeven");
    firstDay = firstDay > 6 ? firstDay - 7 : firstDay;
    firstDay = firstDay < 0 ? firstDay + 7 : firstDay;
    return firstDay;
  }

  Future<void> loadShamsiAdequacyJson() async {
    var data = await rootBundle.loadString('assets/json/shamsi_adequacy.json');
    List<dynamic> jsonResult = jsonDecode(data);

    for (var i = 0; i < jsonResult.length; i++) {
      String date = (jsonResult.elementAt(i) as Map<String, dynamic>)
          .keys
          .toList()[0]
          .toString(); //sample:"0101"
      String title = (jsonResult.elementAt(i) as Map<String, dynamic>)
          .values
          .toList()[0]
          .toString();

      shamsiAdequacyCountPerMonth[int.parse(date.substring(0, 2)) - 1]++;

      shamsiAdequacies.add(Adequacy(
        title: title,
        dayTitle: numberToDayTitle(date.substring(2)),
        dayNumber: date.substring(2),
        month: numberToMonthTitle(date.substring(0, 2)),
      ));
      shamsiAdequacyDates.add(date);
      title = title.trim();
      shamsiAdequacyTitles.add(title);
      // print(shamsiAdequacyCountPerMonth);
    }

    // print(shamsiAdequacyTitles);
    // print(shamsiAdequacyDates);
  }

  String numberToDayTitle(String number) {
    return "شنبه";
  }

  String numberToMonthTitle(String number) {
    int num = int.parse(number) - 1;

    return months[num];
  }

  //shamsi adequacy
  Future<List<Adequacy>> getAdequaciesList(int currentMonth) async {
    List<Adequacy> adequacies = [];
    // for (var i = 0; i < holidayCountPerMonth[currentMonth]; i++) {
    int startIndex = 0;
    for (var i = 0; i < currentMonth; i++) {
      startIndex = startIndex + shamsiAdequacyCountPerMonth[i];
    }

    int endIndex = shamsiAdequacyCountPerMonth[currentMonth] + startIndex;
    print(currentMonth);
    print(startIndex);
    print(endIndex);
    // if (startIndex == endIndex)
    //   print(endIndex);
    // else
    print(shamsiAdequacies.length);
    adequacies = shamsiAdequacies.sublist(startIndex, endIndex);
    // }

    return adequacies;
  }

  Future<void> loadJson() async {
    var data = await rootBundle.loadString('assets/json/shamsi_holiday.json');
    List<dynamic> jsonResult = jsonDecode(data);

    for (var i = 0; i < jsonResult.length; i++) {
      String title =
          jsonResult.elementAt(i)["title"] ?? "oooooooooooooooooooooooooo";
      String date =
          jsonResult.elementAt(i)["date"] ?? "1111111111111111"; //sample:"0101"

      holidayCountPerMonth[int.parse(date.substring(0, 2)) - 1]++;

      holidayDates.add(date);
      title = title.trim();
      holidayTitles.add(title);
      // print(holidayCountPerMonth);
    }

    // print(holidayTitles);
    // print(holidayDates);
  }
}
