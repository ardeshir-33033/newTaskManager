import 'package:flutter/material.dart';

class UserCheckBox with ChangeNotifier {
  void ChangeIcon() {
    notifyListeners();
  }
}

class WeekDay {
  String dayName;

  String weekDay(int day) {
    switch (day) {
      case 1:
        dayName = 'دوشنبه';
        break;
      case 2:
        dayName = "سه شنبه";
        break;
      case 3:
        dayName = "چهارشنبه";
        break;
      case 4:
        dayName = 'پنج شنبه';
        break;
      case 5:
        dayName = "جمعه";
        break;
      case 6:
        dayName = "شنبه";
        break;
      case 7:
        dayName = "یک شنبه";
        break;
    }
    return dayName;
  }
}
