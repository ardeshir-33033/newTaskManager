import 'package:flutter/material.dart';

class UserCheckBox with ChangeNotifier {
  void ChangeIcon() {
    notifyListeners();
  }
}

class ControllerCheckBox with ChangeNotifier {
  void ChangeIcon() {
    notifyListeners();
  }
}

class ProjectCheckBox with ChangeNotifier {
  void ChangeIcon() {
    notifyListeners();
  }

  // void ChangeHour(){
  //   notifyListeners();
  // }
}
class ClearSpeech{
  static bool clearSpeech = false;

  setClearSpeech(bool res){
    clearSpeech = res;
  }
  bool getClearSpeech(){
    return clearSpeech;
  }
}
class SpeechController{
  static TextEditingController speechController = TextEditingController();

}

class WeekDay {
  String dayName;

  String weekDay(int day) {
    day = day % 7;
    print(day);
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
      case 7 :
        dayName = "یک شنبه";
        break;
      case 0:
        dayName = "یک شنبه";
    }
    return dayName;
  }
}
