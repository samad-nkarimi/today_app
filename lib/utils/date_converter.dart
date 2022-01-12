List<int> gregorianToJalali(int gy, int gm, int gd) {
  var gdm, jy, jm, jd, gy2, days;
  gdm = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  gy2 = (gm > 2) ? (gy + 1) : gy;
  days = 355666 +
      (365 * gy) +
      ((gy2 + 3) ~/ 4) -
      ((gy2 + 99) ~/ 100) +
      ((gy2 + 399) ~/ 400) +
      gd +
      gdm[gm - 1];
  jy = -1595 + (33 * (days ~/ 12053));
  days %= 12053;
  jy += 4 * (days ~/ 1461);
  days %= 1461;
  if (days > 365) {
    jy += ((days - 1) ~/ 365);
    days = (days - 1) % 365;
  }
  if (days < 186) {
    jm = 1 + (days ~/ 31);
    jd = 1 + (days % 31);
  } else {
    jm = 7 + ((days - 186) ~/ 30);
    jd = 1 + ((days - 186) % 30);
  }
  return [jy, jm, jd];
}

List jalaliToGregorian(int jy, int jm, int jd) {
  var salA, gy, gm, gd, days;
  jy += 1595;
  days = -355668 +
      (365 * jy) +
      ((jy ~/ 33) * 8) +
      (((jy % 33) + 3) ~/ 4) +
      jd +
      ((jm < 7) ? (jm - 1) * 31 : ((jm - 7) * 30) + 186);
  gy = 400 * (days ~/ 146097);
  days %= 146097;
  if (days > 36524) {
    gy += 100 * (--days ~/ 36524);
    days %= 36524;
    if (days >= 365) days++;
  }
  gy += 4 * (days ~/ 1461);
  days %= 1461;
  if (days > 365) {
    gy += ((days - 1) ~/ 365);
    days = (days - 1) % 365;
  }
  gd = days + 1;
  salA = [
    0,
    31,
    ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0)) ? 29 : 28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  for (gm = 0; gm < 13 && gd > salA[gm]; gm++) gd -= salA[gm];
  return [gy, gm, gd];
}

String getWeekdayInShamsi() {
  int weekdayIndex = DateTime.now().weekday;
  String weekdayString = "";
  switch (weekdayIndex) {
    case 1:
      weekdayString = "دو شنبه";
      break;
    case 2:
      weekdayString = "سه شنبه";
      break;
    case 3:
      weekdayString = "چهار شنبه";
      break;
    case 4:
      weekdayString = "پنج شنبه";
      break;
    case 5:
      weekdayString = "جمعه";
      break;
    case 6:
      weekdayString = "شنبه";
      break;
    case 7:
      weekdayString = "یک شنبه";
      break;
    default:
      weekdayString = "error";
  }
  return weekdayString;
}

String getTodayDateStringInShamsi() {
  List<int> today = gregorianToJalali(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String todayString = "${today[0]}.${today[1]}.${today[2]}";
  return todayString;
}

void main() {
  print(getWeekdayInShamsi());
  print(getTodayDateStringInShamsi());
//   var j, jYear, jMonth, jDay, g, gYear, gMonth, gDay;

//   j = gregorianToJalali(2020, 5, 17);
//   jYear = j[0];
//   jMonth = j[1];
//   jDay = j[2];
//   print('Jalali: \t$jYear/$jMonth/$jDay');

//   g = jalaliToGregorian(1399, 2, 28);
//   gYear = g[0];
//   gMonth = g[1];
//   gDay = g[2];
//   print('Gregorian: \t$gYear/$gMonth/$gDay');
}
