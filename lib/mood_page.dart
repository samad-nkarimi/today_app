import 'package:flutter/material.dart';
import 'package:today_app/custom_calendar.dart';

class MoodPage extends StatelessWidget {
  static const  routeName = "/mood_page";
  const MoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  CustomCalendar(),
      ),
    );
  }
}
