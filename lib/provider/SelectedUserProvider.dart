import 'package:flutter/material.dart';

class SelectUser {
  static String selectedUser;

  String getSelectedUser() {
    return selectedUser;
  }

  setSelectedUser(String user) {
    selectedUser = user;
  }
}

class SelectProject {
  static String selectedProject;

  String getSelectedProject() {
    return selectedProject;
  }

  setSelectedProject(String project) {
    selectedProject = project;
  }
}

class SelectDate {
  static String selectedDate;

  String getSelectedDate() {
    return selectedDate;
  }

  setSelectedProject(String Date) {
    selectedDate = Date;
  }
}

class todayProvider {
  static int tommarow;

  int getDay() {
    return tommarow;
  }

  void setDay(int day) {
    tommarow = day;
  }
}

class SelectController {
  static String controller;

  String getController() {
    return controller;
  }

  void setController(String res) {
    controller = res;
  }
}

class SelectTime {
  static DateTime time;

  DateTime getDateTime() {
    return time;
  }

  void setDateTime(int hour, int min) {
    time = DateTime.now();
    time = DateTime(time.year, time.month, time.day, hour, min, time.second,
        time.millisecond, time.microsecond);
  }
}
