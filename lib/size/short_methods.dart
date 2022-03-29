import 'size_config.dart';

// width:360 , height:640

double rw(double mobileRes, double tabletRes) {
  return SizeConfig.responsiveWidth(mobileRes, tabletRes);
}

double rh(double mobileRes, double tabletRes) {
  return SizeConfig.responsiveHeight(mobileRes, tabletRes);
}

double rt(double mobileRes, double tabletRes) {
  return SizeConfig.responsiveText(mobileRes, tabletRes);
}

//percent
double rwp(double mobileRes, double tabletRes, width) {
  return SizeConfig.percentWidth(mobileRes, tabletRes, width);
}

double rhp(double mobileRes, double tabletRes) {
  return SizeConfig.percentHeight(mobileRes, tabletRes);
}


// double resH(double height, double size) {
//   double percent = size / 640;
//   double result = percent * height;
//   // print(result);
//   return result;
// }

// double resW(double width, double size) {
//   double percent = size / 360;
//   double result = percent * width;
//   // print(result);
//   return result;
// }
