import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:today_app/blocs/blocs.dart';
import 'package:today_app/blocs/note/note.dart';
import 'package:today_app/calender_page.dart';
import 'package:today_app/database/database_provider.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';
import 'package:today_app/mood_page.dart';
import 'package:today_app/size/size_config.dart';
import 'package:today_app/theme/styling.dart';

import './home_page.dart';

void main() async {
  // Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final databasePath = join(await getDatabasesPath(), 'notes_database.db');
  // await deleteDatabase(databasePath);
  print(databasePath);
  final database = await openDatabase(
    databasePath,
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, subtitle TEXT)');
    },
    version: 1,
  );
  DatabaseProvider databaseProvider = DatabaseProvider(database);
  Notes notes;
  try {
    notes = await databaseProvider.notes();
  } catch (e) {
    notes = Notes();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc(databaseProvider, notes)),
        BlocProvider(create: (context)=> ThemeSettingBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orient) {
            SizeConfig().init(constraints, orient);
            return BlocBuilder<ThemeSettingBloc,ThemeSettingState>(
              builder: (context,themeState) {
                // if(themeState is ThemeLoaded)

                return MaterialApp(
                  title: 'Today',
                  theme:  AppTheme.setTheme(themeState.theme),
                  // home: const HomePage(),
                  initialRoute: "/",
                  routes: {
                    "/": (context) => const HomePage(),
                    CalendarPage.routeName: (context) => const CalendarPage(),
                    MoodPage.routeName: (context) => const MoodPage(),
                  },
                );
              }
            );
          },
        );
      },
    );
  }
}
