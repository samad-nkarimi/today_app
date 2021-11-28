import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    int initialPage = _getTodayInShamsi()[1] - 1;
    print("initialPage $initialPage");
    _pageController = PageController(initialPage: initialPage + 600, keepPage: true, viewportFraction: 1);
    currentMonth = initialPage;
    currentStartDay = getFirstDayInMonth();
    thisYear = getThisYear();
    getStartDay();
    getEndDay();
  }

  List<String> months = ["فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"];

  Widget rowText(String text, [bool isTitle = false]) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isTitle == false ? Colors.blue.withOpacity(0.3) : Colors.red,
        borderRadius: BorderRadius.circular(2.0),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(0.5),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontFamily: "Negar",
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCalendar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                Expanded(child: Center(child: Text(months[currentMonth]))),
                Text("$thisYear"),
              ],
            ),
          ),
          Container(
            height: 300,
            child: PageView.builder(
              // itemCount: 12,
              onPageChanged: (i) {
                int modifiedI = i - (i / 12).floor() * 12;

                setState(() {
                  if (currentMonth > modifiedI) {
                    currentStartDay = startDayPreviousMonth;
                  } else {
                    currentStartDay = startDayNextMonth;
                  }
                  // for start new year
                  if (currentMonth == 11 && modifiedI == 0) {
                    thisYear++;
                    currentStartDay = startDayNextMonth;
                  }
                  // for comeback to previous year
                  if (currentMonth == 0 && modifiedI == 11) {
                    thisYear--;
                    currentStartDay = startDayPreviousMonth;
                  }
                  // after updating thisYear
                  isFullYear = (thisYear - 1399).abs().remainder(4) == 0 ? true : false;
                  isPreviousYearFullYear = (thisYear-1 - 1399).abs().remainder(4) == 0 ? true : false;
                  esfandLength = isFullYear ? 30 : 29;
                  esfandLengthInPreviousYear = isPreviousYearFullYear ? 30 : 29;
                  currentMonth = modifiedI;
                  print("currentMonth $currentMonth , i=$modifiedI , isFullYear: $isFullYear");
                  getStartDay();
                  getEndDay();
                  // currentStartDay++;
                });
              },
              controller: _pageController,
              itemBuilder: (BuildContext context, int itemIndex) {
                // _pageController?.animateToPage(_getTodayInShamsi()[1]-1,duration: const Duration(milliseconds: 500),curve: Curves.bounceIn,);
                return contentTable();
              },
            ),
          ),
          // Text(_getTodayInShamsi())
        ],
      ),
    );
  }

  Widget contentTable() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Table(
        // border: TableBorder.all(color: Colors.black.withOpacity(0.2)),
        children: [
          TableRow(children: [
            rowText('ش', true),
            rowText('ی', true),
            rowText('د', true),
            rowText('س', true),
            rowText('چ', true),
            rowText('پ', true),
            rowText('ج', true),
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
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: buildCalendar(),
    );
  }

  List<Widget> _tableContentRows(int startDay, int month) {
    List<Widget> list = [];
    int rowCount = 5;
    int endDay = month == 11 ? esfandLength : (month > 5 ? 30 : 31);
    for (int i = 0; i < startDay; i++) {
      list.add(rowText(""));
    }

    if ((startDay <= 4) || (startDay == 5 && month > 6) || (startDay == 6 && month == 11 )) {
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
    if (startDay == 6 && month == 11 && isFullYear)  rowCount = 6;
    print("rowCount $rowCount , endDay $endDay , isFullYear $isFullYear");
    int correction = 0;
    for (int row = 1; row <= rowCount; row++) {
      for (int cul = 1; cul <= 7; cul++) {
        int day = cul + (7 * (row - 1)) - correction;
        if (cul <= startDay && row == 1) {
          correction++;
          continue;
        }
        list.add(rowText((day <= endDay) ? '$day' : ""));
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
    int todayNumber =
        (DateTime.now().difference(DateTime(2021, 1, 1)).inDays) - (DateTime.now().difference(DateTime(2021, 1, 1)).inDays / 7).floor() * 7;
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
    List<int> todayDate = []; //day,month
    int dayCount = (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;

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
    int daysCount = (DateTime.now().difference(DateTime(2021, 3, 21)).inDays) + 1;
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
    int month = todayDate[1];

    // 1:sat 2:sun 3:mon 4:...
    int dayInSeven =
        (DateTime.now().difference(DateTime(2021, 1, 1)).inDays) - (DateTime.now().difference(DateTime(2021, 1, 1)).inDays / 7).floor() * 7;
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
    int monthLength = monthNumber == 11 ? esfandLength : (monthNumber > 5 ? 30 : 31);
    int currentEndDay = todayNumber + (monthLength - (monthLength / 7).floor() * 7 - 1);
    startDayNextMonth = currentEndDay + 1;
    currentEndDay = currentEndDay > 6 ? currentEndDay - 7 : currentEndDay;
    currentEndDay = currentEndDay < 0 ? currentEndDay + 7 : currentEndDay;
    // print("currentEndDay $currentEndDay");
    startDayNextMonth = startDayNextMonth > 6 ? startDayNextMonth - 7 : startDayNextMonth;
    startDayNextMonth = startDayNextMonth < 0 ? startDayNextMonth + 7 : startDayNextMonth;
    // print("startDayNextMonth $startDayNextMonth");
    // print("startDay $currentStartDay");
    print("-------------------------------");
    return 1;
  }

  int getStartDay() {
    int todayNumber = currentStartDay;
    int previousMonthNumber = currentMonth - 1;
    if (previousMonthNumber < 0) previousMonthNumber = 11;
    int monthLength = previousMonthNumber == 11 ? esfandLengthInPreviousYear : (previousMonthNumber > 5 ? 30 : 31);
    // int currentMonthLength = currentMonth == 11 ? 29 : (currentMonth > 5 ? 30 : 31);
    // int currentEndDay = todayNumber + (currentMonthLength - (currentMonthLength / 7).round() * 7 - 1);
    // currentEndDay = currentEndDay > 6 ? currentEndDay - 7 : currentEndDay;
    int previousMontEndDay = currentStartDay - 1;
    previousMontEndDay = previousMontEndDay < 0 ? previousMontEndDay + 7 : previousMontEndDay;
    previousMontEndDay = previousMontEndDay > 6 ? previousMontEndDay - 7 : previousMontEndDay;
    // print("previousMontEndDay $previousMontEndDay");
    startDayPreviousMonth = previousMontEndDay - (monthLength - (monthLength / 7).floor() * 7 - 1);
    startDayPreviousMonth = startDayPreviousMonth < 0 ? startDayPreviousMonth + 7 : startDayPreviousMonth;
    startDayPreviousMonth = startDayPreviousMonth > 6 ? startDayPreviousMonth - 7 : startDayPreviousMonth;
    print("monthLength $monthLength");
    print("startDayPreviousMonth $startDayPreviousMonth");
    return 1;
  }
}
