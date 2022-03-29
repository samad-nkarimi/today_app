import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth = 100;
  static double _screenHeight = 100;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 1;
  static double imageSizeMultiplier = 1;
  static double heightMultiplier = 1;
  static double widthMultiplier = 1;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  // development time device
  static double devMobileWidth = 360;
  static double devMobileHeight = 640;
  static double devTabletWidth = 1024;
  static double devTabletHeight = 1350;

  // static double responsiveHeight(mobileRes, tabletRes) {
  //   return (isMobilePortrait ? mobileRes : tabletRes) * heightMultiplier;
  // }
  static double responsiveHeight(mobileRes, tabletRes) {
    // print("res height: $isMobilePortrait");
    // print("res height tablet: $tabletRes");
    // print("res height mobile: $mobileRes");
    return (isMobilePortrait
        ? mobileRes * (_screenHeight / devMobileHeight)
        //  *
        // ((_screenHeight / _screenWidth) / 1.77)
        : tabletRes * (_screenHeight / devTabletHeight));
  }

  // static double responsiveWidth(mobileRes, tabletRes) {
  //   return (isMobilePortrait ? mobileRes : tabletRes) * widthMultiplier;
  // }
  static double responsiveWidth(mobileRes, tabletRes) {
    print("res width: $isMobilePortrait");
    print("res width tablet: $tabletRes");
    print("res width mobile: $mobileRes");
    return (isMobilePortrait
        ? mobileRes * (_screenWidth / devMobileWidth)
        //  *
        // ((_screenHeight / _screenWidth) / 1.77)
        : tabletRes * (_screenWidth / devTabletWidth));
  }

  // static double responsiveText(mobileRes, tabletRes) {
  //   return (isMobilePortrait ? mobileRes : tabletRes) * textMultiplier;
  // }
  static double responsiveText(mobileRes, tabletRes) {
    return (isMobilePortrait
        ? mobileRes *
            (_screenHeight / devMobileHeight) *
            ((_screenHeight / _screenWidth) / 1.77)
        : tabletRes * (_screenHeight / devTabletHeight));
  }

  //percent sizes
  static double percentHeight(mobileRes, tabletRes) {
    return (isMobilePortrait
        ? mobileRes * 0.01 * _screenHeight
        : tabletRes * 0.01 * _screenHeight);
  }

  static double percentWidth(mobileRes, tabletRes, width) {
    return (isMobilePortrait
        ? mobileRes * 0.01 * width
        : tabletRes * 0.01 * width);
  }

  void init(BoxConstraints constraints, Orientation orientation) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;
    if (orientation == Orientation.portrait) {
      isPortrait = true;
      // choose a correct range!!
      if (_screenWidth < 500) {
        isMobilePortrait = true;
        print("w<500");
      } else {
        isMobilePortrait = false;
      }
    } else {
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    print("width: $_screenWidth");
    print("height: $_screenHeight");
    print(kIsWeb
        ? "Web"
        : isMobilePortrait
            ? "Mobile"
            : "Tablet");
  }
}
