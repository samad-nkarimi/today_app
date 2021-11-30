import 'package:flutter/material.dart';
import 'package:today_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/blocs/note/note.dart';
import 'package:today_app/calender_page.dart';
import 'package:today_app/mood_page.dart';
import 'package:bloc/bloc.dart';
import './home_page.dart';

void main() {
  // Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => NoteBloc()),

    ],
    child:MaterialApp(
      title: 'Today',
      theme: ThemeData(
        fontFamily: "ANegar",
        primarySwatch: Colors.blue,
        // canvasColor: Colors.transparent,
      ),
      // home: const HomePage(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        CalendarPage.routeName: (context) => const CalendarPage(),
        MoodPage.routeName:(context)=> const MoodPage(),
      },),
    );
  }
}
