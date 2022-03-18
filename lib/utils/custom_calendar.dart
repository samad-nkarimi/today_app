import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today/blocs/blocs.dart';
import 'package:today/models/models.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  // final int firstDateYear = 1400;
  // final int firstDateMonth = 1;
  // final int firstDateDay = 1;
  int thisYear = 1400;
  PageController? _pageController;
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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    int initialPage = _getTodayInShamsi()[1] - 1;
    print("initialPage $initialPage");
    _pageController = PageController(
      initialPage: initialPage + 600,
      keepPage: false,
      viewportFraction: 1,
    );
    currentMonth = initialPage;
    currentStartDay = getFirstDayInMonth();
    thisYear = getThisYear();
    getStartDay();
    getEndDay();
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   await loadJson();
    // });
    loadJson().then((value) {
      setState(() {
        isLoading = false;
        print(getAdequaciesList(0));
      });
    });

    //shamsi adequacy
    loadShamsiAdequacyJson().then((value) {
      setState(() {
        isLoading = false;
        print(getAdequaciesList(0));
      });
    });
  }

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

  Widget rowText(String text,
      {bool isTitle = false, bool isToday = false, bool isHoliday = false}) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isToday
                ? Colors.green
                : isTitle
                    ? Colors.red
                    : Colors.blue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(isTitle
                ? 10
                : isToday
                    ? 20
                    : 2.0),
            border: Border.all(
              width: isToday ? 1.0 : 1.0,
              color: (isHoliday && text.isNotEmpty)
                  ? Colors.orange
                  : isToday
                      ? Colors.white
                      : Colors.transparent,
              style: BorderStyle.solid,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(0.5),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "Negar",
              color: isHoliday ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCalendar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        // color: Colors.orange,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  // alignment: Alignment.bottomCenter,
                  // color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            _pageController?.animateToPage(
                              currentMonth + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: const Icon(Icons.chevron_left)),
                      IconButton(
                          onPressed: () {
                            _pageController?.animateToPage(
                              currentMonth - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          icon: const Icon(Icons.navigate_next)),
                      BlocBuilder<CalenderBloc, CalenderState>(
                          builder: (context, state) {
                        print(state);
                        int monthId = state is MonthUpdatedCalenderState
                            ? state.monthId
                            : currentMonth;
                        return Expanded(
                            child: Center(child: Text(months[monthId])));
                      }),
                      Text("$thisYear"),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 275,
              // color: Colors.black45,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                // itemCount: 12,
                dragStartBehavior: DragStartBehavior.start,

                onPageChanged: (i) {
                  print("onChanged pageview");

                  //the month we are scrolling to go to it
                  int modifiedId = i - (i / 12).floor() * 12;
                  print("*******$currentMonth*****$modifiedId******");
                  int targetMonth;
                  if (currentMonth > modifiedId) {
                    targetMonth = modifiedId;
                  } else {
                    targetMonth = modifiedId - 1 < 0 ? 11 : modifiedId - 1;
                  }
                  print("target: $targetMonth");
                  // BlocProvider.of<CalenderBloc>(context)
                  //     .add(CalendarScrolledCalenderEvent(targetMonth));
                },
                controller: _pageController,
                itemBuilder: (BuildContext context, int itemIndex) {
                  // _pageController?.animateToPage(_getTodayInShamsi()[1]-1,duration: const Duration(milliseconds: 500),curve: Curves.bounceIn,);
                  //why itemIndex change irregularly ????? -> cause of keepPage=true ???
                  // index is the target month
                  // currentMonth is the month we are scrolling from
                  int index = (600 - itemIndex).abs() % 12;
                  print("item index: $itemIndex");
                  print("index: $index");
                  getAdequaciesList(index).then((value) {
                    BlocProvider.of<CalenderBloc>(context)
                        .add(MonthAdequaciesSentCalenderEvent(value));
                  });
                  BlocProvider.of<CalenderBloc>(context)
                      .add(CalendarScrolledCalenderEvent(index));

                  return contentTable(index);
                },
              ),
            ),
            // Text(_getTodayInShamsi())
          ],
        ),
      ),
    );
  }

  Widget contentTable(int index) {
    // setState(() {
    getStartDay();
    getEndDay();
    print("$currentStartDay**");

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
    currentMonth = index;
    print("$currentStartDay**");
    print("currentMonth $currentMonth , i=$index , isFullYear: $isFullYear");

    // currentStartDay++;
    // });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Table(
        // border: TableBorder.all(color: Colors.black.withOpacity(0.2)),
        children: [
          TableRow(children: [
            rowText('ش', isTitle: true),
            rowText('ی', isTitle: true),
            rowText('د', isTitle: true),
            rowText('س', isTitle: true),
            rowText('چ', isTitle: true),
            rowText('پ', isTitle: true),
            rowText('ج', isTitle: true),
          ]),
          // ..._tableContentRows(),
          ..._tableRows(_tableContentRows(currentStartDay, currentMonth))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.now());
    getThisYear();
    getFirstDayInMonth();
    return Container(
      // color: Colors.white,

      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildCalendar(),
    );
  }

  List<Widget> _tableContentRows(int startDay, int month) {
    List<int> todayDate = _getTodayInShamsi();
    int dayInMonth = todayDate[0];
    int monthInYear = todayDate[1];
    List<Widget> list = [];
    int rowCount = 5;
    int endDay = month == 11 ? esfandLength : (month > 5 ? 30 : 31);
    for (int i = 0; i < startDay; i++) {
      list.add(rowText(""));
    }

    if ((startDay <= 4) ||
        (startDay == 5 && month > 6) ||
        (startDay == 6 && month == 11)) {
      //35

    }
    // else if (startDay == 5 && month > 6) {
    //   //35
    //   for (int i = 0; i < startDay; i++) {
    //     list.add(rowText(""));
    //   }
    //   for (int row = 1; row <= 5; row++) {
    //     for (int cul = startDay; cul <= 7; cul++) {
    //       list.add(rowText('${cul + (7 * (row - 1))}'));
    //     }
    //   }
    // }
    // else if (startDay == 6 && month == 11) {
    //   //35
    // }
    else if ((startDay >= 5 && month < 6) || (startDay == 6 && month != 11)) {
      //42
      rowCount = 6;
    }
    if (startDay == 6 && month == 11 && isFullYear) rowCount = 6;
    print("rowCount $rowCount , endDay $endDay , isFullYear $isFullYear");
    int correction = 0;
    bool isHoliday = false;
    for (int row = 1; row <= rowCount; row++) {
      for (int cul = 1; cul <= 7; cul++) {
        int day = cul + (7 * (row - 1)) - correction;
        String myMonth = (month + 1).toString(); // in json: 1..12
        String hol =
            "${myMonth.length == 1 ? '0$myMonth' : myMonth}${day.toString().length == 1 ? '0$day' : day}";
        if (cul == 7 || holidayDates.contains(hol)) {
          isHoliday = true;
        } else {
          isHoliday = false;
        }
        if (cul <= startDay && row == 1) {
          correction++;
          continue;
        }
        // do not forget to apply year too!!
        (day == dayInMonth && month == monthInYear - 1)
            ? list.add(rowText((day <= endDay) ? '$day' : "",
                isToday: true, isHoliday: isHoliday))
            : list.add(
                rowText((day <= endDay) ? '$day' : "", isHoliday: isHoliday));
      }
    }

    return list;
  }

  List<TableRow> _tableRows(List<Widget> content) {
    List<TableRow> list = [];
    for (int row = 0; row < content.length / 7; row++) {
      list.add(
        TableRow(
          children: [...content.getRange(7 * row, row * 7 + 7)],
        ),
      );
    }

    return list;
  }

  //calculating today based on different to 2021/1/1 as Friday
  String _getToday() {
    int todayNumber = (DateTime.now().difference(DateTime(2021, 1, 1)).inDays) -
        (DateTime.now().difference(DateTime(2021, 1, 1)).inDays / 7).floor() *
            7;
    String todayString = "";
    switch (todayNumber) {
      case 1:
        todayString = "ش";
        break;
      case 2:
        todayString = "ی";
        break;
      case 3:
        todayString = "د";
        break;
      case 4:
        todayString = "س";
        break;
      case 5:
        todayString = "چ";
        break;
      case 6:
        todayString = "پ";
        break;
      default:
        todayString = "ج";
    }
    return todayString;
  }

  List<int> _getTodayInShamsi() {
    List<int> todayDate =
        []; //day number nth in month ,month number nth in year
    int dayCount =
        (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;

    int monthInYear = 1;
    int dayInMonth = 1;
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
    // print("dayCount: $dayCount , month: $month , day: $day , hour: ${DateTime.now().hour}");
    return todayDate;
  }

  int getThisYear() {
    int daysCount =
        (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;
    int thisYear = (daysCount / 364).floor() + 1400;
    print("thisYear $thisYear");
    return thisYear;
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
      print(holidayCountPerMonth);
    }

    print(holidayTitles);
    print(holidayDates);
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
      print(shamsiAdequacyCountPerMonth);
    }

    print(shamsiAdequacyTitles);
    print(shamsiAdequacyDates);
  }

  String numberToDayTitle(String number) {
    return "شنبه";
  }

  String numberToMonthTitle(String number) {
    int num = int.parse(number) - 1;

    return months[num];
  }

  // Future<List<String>> getAdequaciesList(int currentMonth) async {
  //   List<String> adequacies = [];
  //   // for (var i = 0; i < holidayCountPerMonth[currentMonth]; i++) {
  //   int startIndex = 0;
  //   for (var i = 0; i < currentMonth; i++) {
  //     startIndex = startIndex + holidayCountPerMonth[i];
  //   }

  //   int endIndex = holidayCountPerMonth[currentMonth] + startIndex;
  //   print(currentMonth);
  //   print(startIndex);
  //   print(endIndex);
  //   // if (startIndex == endIndex)
  //   //   print(endIndex);
  //   // else
  //   adequacies = holidayTitles.sublist(startIndex, endIndex);
  //   // }

  //   return adequacies;
  // }

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
}
