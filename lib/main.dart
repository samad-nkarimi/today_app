import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today/widgets/form_widget.dart';
import './blocs/blocs.dart';
import 'screens/calender_page.dart';
import './database/database_provider.dart';
import './models/models.dart';
import 'screens/mood_page.dart';
import './size/size_config.dart';
import './theme/styling.dart';

import 'screens/home_page.dart';

void main() async {
  // Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final dp = DatabaseProvider();
  Notes notes = await dp.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc(dp, notes)),
        BlocProvider(create: (context) => CalenderBloc()),
        BlocProvider(create: (context) => ThemeSettingBloc()),
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
            return BlocBuilder<ThemeSettingBloc, ThemeSettingState>(
                builder: (context, themeState) {
              // if(themeState is ThemeLoaded)

              return MaterialApp(
                title: 'Today',
                theme: AppTheme.setTheme(themeState.theme),
                // home: const HomePage(),
                initialRoute: "/",
                routes: {
                  "/": (context) => const HomePage(),
                  CalendarPage.routeName: (context) => const CalendarPage(),
                  MoodPage.routeName: (context) => const MoodPage(),
                  FormWidget.routeName: (context) =>
                      FormWidget(initialData: Note("", "")),
                },
              );
            });
          },
        );
      },
    );
  }
}
