import 'package:flutter/material.dart';
import '../models/models.dart';
import '../size/size_config.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF75C28C);
  static const Color subTitleSmallTextColor = Color(0x99000000);



  static ThemeData setTheme(Themes theme) {
    switch (theme) {
      case Themes.light:
        return lightTheme;
      case Themes.dark:
        return darkTheme;
      case Themes.green:
        return greenTheme;
      case Themes.blue:
        return blueTheme;
    }
  }

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    // appBarTheme: const AppBarTheme(color: Colors.red, brightness: Brightness.light),
    fontFamily: 'Negar',
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    // appBarTheme: const AppBarTheme(color: Colors.red, brightness: Brightness.light),
    fontFamily: 'Negar',
  );

  static final ThemeData greenTheme = ThemeData(
    scaffoldBackgroundColor: Colors.lightGreen,
    // brightness: Brightness.dark,
    textTheme: blueTextTheme,
    fontFamily: 'Negar',
  );

  static final ThemeData blueTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueAccent,
    // brightness: Brightness.dark,
    textTheme: greenTextTheme,
    fontFamily: 'Negar',
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline6: _titleLight,
    subtitle1: _subTitleLight,
    subtitle2: _subTitleSmallLight,
    button: _buttonLight,
    headline4: _greetingLight,
    headline3: _searchLight,
    bodyText1: _selectedTabLight,
    bodyText2: _unSelectedTabLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline6: _titleDark,
    subtitle2: _subTitleDark,
    button: _buttonDark,
    headline4: _greetingDark,
    headline3: _searchDark,
    bodyText1: _selectedTabDark,
    bodyText2: _unSelectedTabDark,
  );
  static final TextTheme greenTextTheme = TextTheme(
    headline6: _titleGreen,
    subtitle2: _subTitleGreen,
    button: _buttonGreen,
    headline4: _greetingGreen,
    headline3: _searchGreen,
    bodyText1: _selectedTabGreen,
    bodyText2: _unSelectedTabGreen,
  );
  static final TextTheme blueTextTheme = TextTheme(
    headline6: _titleBlue,
    subtitle2: _subTitleBlue,
    button: _buttonBlue,
    headline4: _greetingBlue,
    headline3: _searchBlue,
    bodyText1: _selectedTabBlue,
    bodyText2: _unSelectedTabBlue,
  );

  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontSize: 5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: subTitleTextColor,
    fontSize: 3 * SizeConfig.textMultiplier,
    height: 1.5,
  );

  static final TextStyle _subTitleSmallLight = TextStyle(
    color: subTitleSmallTextColor,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.white,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 3.2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 2.2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: const Color(0xFF75C28C),
    fontWeight: FontWeight.bold,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  // dark text theme
  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);
  static final TextStyle _subTitleDark = _subTitleLight.copyWith(color: Colors.white70);
  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);
  static final TextStyle _greetingDark = _greetingLight.copyWith(color: Colors.black);
  static final TextStyle _searchDark = _searchLight.copyWith(color: Colors.black);
  static final TextStyle _selectedTabDark = _selectedTabLight.copyWith(color: Colors.white);
  static final TextStyle _unSelectedTabDark = _unSelectedTabLight.copyWith(color: Colors.white70);

  // green text theme
  static final TextStyle _titleGreen = _titleLight.copyWith(color: Colors.white);
  static final TextStyle _subTitleGreen = _subTitleLight.copyWith(color: Colors.white70);
  static final TextStyle _buttonGreen = _buttonLight.copyWith(color: Colors.black);
  static final TextStyle _greetingGreen = _greetingLight.copyWith(color: Colors.black);
  static final TextStyle _searchGreen = _searchLight.copyWith(color: Colors.black);
  static final TextStyle _selectedTabGreen = _selectedTabLight.copyWith(color: Colors.white);
  static final TextStyle _unSelectedTabGreen = _unSelectedTabLight.copyWith(color: Colors.white70);

// blue text theme
  static final TextStyle _titleBlue = _titleLight.copyWith(color: Colors.white);
  static final TextStyle _subTitleBlue = _subTitleLight.copyWith(color: Colors.white70);
  static final TextStyle _buttonBlue = _buttonLight.copyWith(color: Colors.black);
  static final TextStyle _greetingBlue = _greetingLight.copyWith(color: Colors.black);
  static final TextStyle _searchBlue = _searchLight.copyWith(color: Colors.black);
  static final TextStyle _selectedTabBlue = _selectedTabLight.copyWith(color: Colors.white);
  static final TextStyle _unSelectedTabBlue = _unSelectedTabLight.copyWith(color: Colors.white70);

}
