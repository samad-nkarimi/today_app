import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier=1;
  static double imageSizeMultiplier=1;
  static double heightMultiplier=1;
  static double widthMultiplier=1;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;


  static double responsiveHeight(mobileRes, tabletRes) {
    return (isMobilePortrait ? mobileRes : tabletRes) *heightMultiplier;
  }

  static double responsiveWidth(mobileRes, tabletRes) {
    return (isMobilePortrait ? mobileRes : tabletRes) *widthMultiplier;
  }

  static double responsiveText(mobileRes, tabletRes) {
    return (isMobilePortrait ? mobileRes : tabletRes) * textMultiplier;
  }

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      // choose a correct range!!
      if (_screenWidth !< 500) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth !/ 100;
    _blockHeight = _screenHeight !/ 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    print(_screenWidth);
  }
}
