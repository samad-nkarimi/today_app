import 'dart:convert';
import 'dart:ui';

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

  PageController? _pageController;

  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // isLoading = true;
    _pageController = PageController(
      // initialPage: initialPage + 600,
      initialPage: 600,
      keepPage: false,
      viewportFraction: 1,
    );
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
    return
        // ClipRRect(
        //   clipBehavior: Clip.antiAlias,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        //     child:
        Container(
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
      //   ),
      // ),
    );
  }

  Widget buildCalendar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:
          BlocBuilder<CalenderBloc, CalenderState>(builder: (context, state) {
        return Container(
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
                              //to previous month
                              int targetMonth;
                              targetMonth = state.dateDetails.month - 1 < 0
                                  ? 11
                                  : state.dateDetails.month - 1;
                              // BlocProvider.of<CalenderBloc>(context).add(
                              //     CalendarScrolledCalenderEvent(targetMonth));
                              _pageController?.animateToPage(
                                targetMonth,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            },
                            icon: const Icon(Icons.chevron_left,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () {
                              //to next month
                              int targetMonth;
                              targetMonth = state.dateDetails.month + 1 > 11
                                  ? 0
                                  : state.dateDetails.month + 1;
                              // BlocProvider.of<CalenderBloc>(context).add(
                              //     CalendarScrolledCalenderEvent(targetMonth));
                              _pageController?.animateToPage(
                                targetMonth,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: const Icon(Icons.navigate_next,
                                color: Colors.white)),
                        Expanded(
                            child: Center(
                                child: Text(months[state.dateDetails.month]))),
                        Text("${state.dateDetails.year}"),
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
                    print(i);

                    //the month we are scrolling to go to it
                    int modifiedId = i - (i / 12).floor() * 12;
                    // print(
                    //     "*******${state.dateDetails.month}*****$modifiedId******");
                    // int targetMonth;
                    // if (state.dateDetails.month > modifiedId) {
                    //   targetMonth = modifiedId;
                    // } else {
                    //   targetMonth = modifiedId - 1 < 0 ? 11 : modifiedId - 1;
                    // }
                    BlocProvider.of<CalenderBloc>(context)
                        .add(CalendarScrolledCalenderEvent(modifiedId));

                    // print("target: $targetMonth");
                    // BlocProvider.of<CalenderBloc>(context)
                    //     .add(CalendarScrolledCalenderEvent(targetMonth));
                  },
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    // _pageController?.animateToPage(_getTodayInShamsi()[1]-1,duration: const Duration(milliseconds: 500),curve: Curves.bounceIn,);
                    //why itemIndex change irregularly ????? -> cause of keepPage=true ???
                    // index is the target month
                    // currentMonth is the month we are scrolling from
                    // int index = (600 - itemIndex).abs() % 12;
                    // int index = (600 - itemIndex) > 0
                    //     ? 12 - ((600 - itemIndex).abs() % 12)
                    //     : (600 - itemIndex).abs() % 12;
                    // print("item index: $itemIndex");
                    // print("index: $index");

                    // getAdequaciesList(index).then((value) {
                    //   BlocProvider.of<CalenderBloc>(context)
                    //       .add(MonthAdequaciesSentCalenderEvent(value));
                    // });

                    return contentTable(state);
                  },
                ),
              ),
              // Text(_getTodayInShamsi())
            ],
          ),
        );
      }),
    );
  }

  Widget contentTable(CalenderState state) {
    print(state);
    print(state.dateDetails);
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
          ..._tableRows(
            _tableContentRows(
              state.dateDetails.startDay,
              state.dateDetails.month,
              state.dateDetails.day,
              state.dateDetails.monthInYear,
              state.dateDetails.esfandLength,
              state.dateDetails.isFullYear,
              state.dateDetails.holidayDates,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.now());
    // getThisYear();

    return Container(
      // color: Colors.white,

      padding: const EdgeInsets.all(20.0),
      child:
          // isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          buildCalendar(),
    );
  }

  List<Widget> _tableContentRows(
    int startDay,
    int month,
    int dayInMonth,
    int monthInYear,
    int esfandLength,
    bool isFullYear,
    List<String> holidayDates,
  ) {
    //month is the month index we are in it now
    //monthInYear is the month that contains today date

    // List<int> todayDate = _getTodayInShamsi();
    // int dayInMonth = todayDate[0];
    // int monthInYear = todayDate[1];
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
        print("day:$month ,dayInMonth:$monthInYear");
        // do not forget to apply year too!!
        (day == dayInMonth && month == monthInYear)
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

}
