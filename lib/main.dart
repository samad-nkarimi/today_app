import 'package:flutter/material.dart';
import 'package:today_app/calender_page.dart';
import 'package:today_app/mood_page.dart';
import './home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Today',
      theme: ThemeData(
        fontFamily: "ANegar",
        primarySwatch: Colors.blue,
        // canvasColor: Colors.transparent,
      ),
      // home: const HomePage(),
      initialRoute: "/",
      routes: {
        "/": (context) => const MoodPage(),
        CalendarPage.routeName: (context) => const CalendarPage(),
        MoodPage.routeName:(context)=> const MoodPage(),
      },
    );
  }
}
