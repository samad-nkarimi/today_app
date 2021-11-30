import 'package:flutter/material.dart';

import '../size/size_config.dart';

class AppTheme {


  AppTheme._();



  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF75C28C);
  static const Color subTitleSmallTextColor = Color(0x99000000);



  static ThemeData lightTheme() {


    return ThemeData(
        scaffoldBackgroundColor: AppTheme.appBackgroundColor,
        brightness: Brightness.light,
        textTheme: lightTextTheme(),
        appBarTheme: const AppBarTheme(color: Colors.red,brightness: Brightness.light),
        fontFamily: 'IRANSansFaNum_Medium');
  }

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );

  static TextTheme lightTextTheme() => TextTheme(
    headline6: _titleLight,
    subtitle1: _subTitleSmallLight(),
    subtitle2: _subTitleLight(),
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

  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontSize: 5 * SizeConfig.textMultiplier ,
  );

  static TextStyle _subTitleLight() {
    // print("$languageFontTextMultiplier    9999999999999999999999999999999999");
    return TextStyle(
      color: subTitleTextColor,
      fontSize: 3 * SizeConfig.textMultiplier ,
      height: 1.5,
    );
  }

  static TextStyle _subTitleSmallLight() {
    // print("$subTitleSmallTextColor  colorrrrrrrrrr");
    return TextStyle(
      color: subTitleSmallTextColor,
      fontSize: 2.0 * SizeConfig.textMultiplier ,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
  }

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.white,
    fontSize: 2.5 * SizeConfig.textMultiplier ,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 3 * SizeConfig.textMultiplier ,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 3.2 * SizeConfig.textMultiplier ,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 2.2 * SizeConfig.textMultiplier ,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Color(0xFF75C28C),
    fontSize: 2.5 * SizeConfig.textMultiplier ,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark = _subTitleLight().copyWith(color: Colors.white70);

  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);

  static final TextStyle _greetingDark = _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark = _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark = _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark = _selectedTabDark.copyWith(color: Colors.white70);
}
