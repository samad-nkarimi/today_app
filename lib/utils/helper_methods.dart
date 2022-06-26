double getHourPercent() {
  int hour = DateTime.now().hour;
  int min = DateTime.now().minute;
  int totalMinute = 24 * 60;
  int pastMinute = hour * 60 + min;
  double hourPercent = 1.0 - pastMinute / totalMinute;
  return hourPercent;
}
