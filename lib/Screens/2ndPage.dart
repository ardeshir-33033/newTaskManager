import 'dart:async';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:persian_datepicker/jalaali_js.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_new/ApiModels/Controller.dart';
import 'package:task_manager_new/ApiModels/ProjectsModel.dart';
import 'package:task_manager_new/ApiModels/TaskModel2.dart';
import 'package:task_manager_new/ApiModels/UserData.dart';
import 'package:task_manager_new/Buisness/ApiBuisness.dart';
import 'package:task_manager_new/Components/DoneEditRow.dart';
import 'package:task_manager_new/Components/SearchSpeech.dart';
import 'package:task_manager_new/Components/SpeechAlone.dart';
import 'package:task_manager_new/provider/SelectedUserProvider.dart';
import 'package:task_manager_new/provider/StateProvider.dart';

import '../provider/SelectedUserProvider.dart';
import '../provider/SelectedUserProvider.dart';
import '../provider/SelectedUserProvider.dart';
import '../provider/SelectedUserProvider.dart';

class MainPage2nd extends StatefulWidget {
  MainPage2nd({this.taskText});

  TimeOfDay picker;
  String taskText;

  @override
  _MainPage2ndState createState() => _MainPage2ndState();
}

class _MainPage2ndState extends State<MainPage2nd> {
  TextEditingController userSearchBarController = TextEditingController();
  TextEditingController projectSearchBarController = TextEditingController();

  // List<String> Users = ["سیف الهی", "اونق", "روحی", "اوژن"];
  List<UserData> Users = List<UserData>();
  List<UserData> selectedUsers = List<UserData>();
  List<Controller> Controllers = List<Controller>();
  List<Project> projects = List<Project>();

  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

  // List<String> Controllers = ["مجرب", "اونق", "هاتف", "اسحاق زاده", "مقدم"];
  String selectedController;

  TaskModel sendingModel = TaskModel();

  ScrollController scrollViewController = ScrollController();

  // List<String> projects = [
  //   "تسک منجیر",
  //   "کپ اپ",
  //   "تایم منیجمنت",
  //   "اینستاگرام",
  //   "رجیسترینگ"
  // ];
  String selectedprojects = SelectProject().getSelectedProject() ?? "";
  String selectedDate = SelectDate().getSelectedDate() ??
      SelectDate()
          .setSelectedProject(DateFormat("yyyy-MM-dd").format(DateTime.now()));

  TextEditingController CalendarEditingController = TextEditingController();

  PersianDatePickerWidget persianDatePicker;
  DateTime choosenTime;
  String selectedUser = "";
  String selectedUserId;
  String selectedControllerId;
  String selectedProjectname;
  bool doneChanged = false;
  String selectedDayName = todayProvider().getDay() == null
      ? null
      : WeekDay().weekDay(DateTime.now().weekday + todayProvider().getDay() );
  int timeDiffer =
      todayProvider().getDay() == null ? null : todayProvider().getDay();
  bool sendVisible = false;
  TextEditingController VoiceController = TextEditingController();

  @override
  void initState() {
    VoiceController.text = widget.taskText;
    Users = ApiServices().getUsersList();
    Controllers = ApiServices().getControllersList();
    projects = ApiServices().getProjects();
    persianDatePicker = PersianDatePicker(
        outputFormat: "DD",
        showGregorianDays: false,
        controller: CalendarEditingController,
        // selectedDayBackgroundColor: Colors.red,
        farsiDigits: false,
        weekCaptionsBackgroundColor: Colors.grey,
        headerTodayBackgroundColor: Colors.transparent,
        onChange: (res, s) {
          timeDiffer =
              int.parse(CalendarEditingController.text) - Jalaali.now().day;
          DateTime dayName = DateTime.now().add(Duration(days: timeDiffer));
          selectedDayName = WeekDay().weekDay(dayName.weekday);
          doneChanged = true;
          setState(() {});
        }).init();
    selectedUser = SelectUser().getSelectedUser() ?? "";
    selectedController = SelectController().getController() ?? "";

    choosenTime = SelectTime().getDateTime();

    // DateTime now = DateTime.now().subtract(duration);

    super.initState();
  }

  bool userVisibility = true;
  bool changeUserVisibility =
      SelectUser().getSelectedUser() == null ? false : true;
  bool controllerVisibility = false;
  bool projectVisibility = false;
  bool calendarVisibility = false;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: (){
        ClearSpeech().setClearSpeech(false);
        Navigator.pop(context);
        SpeechController.speechController.clear();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: scrollViewController,
            child: Column(
              children: [
                changeUserVisibility
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xffFDCF09),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        'assets/images/avatarTest.png'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(selectedUser),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      changeUserVisibility = false;
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 50,
                                      child: Image.asset(
                                        "assets/images/pencill.png",
                                        width: 25,
                                        height: 25,
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              height: phoneHeight / 7,
                              width: phoneWidth - 30,
                              child: TextField(
                                controller: VoiceController,
                                maxLines: null,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "متن..."),
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: phoneWidth / 9),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: phoneWidth / 1.8,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.grey,
                                    onChanged: (value) {
                                      searchUser(value);
                                    },
                                    cursorRadius: Radius.circular(5),
                                    controller: userSearchBarController,
                                  ),
                                ),
                                SearchSpeech(
                                  SpeechTextCallBack: (result) {
                                    userSearchBarController.text = result;
                                    searchUser(result);
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                      width: phoneWidth / 17,
                                      height: 25,
                                      child: Image.asset(
                                          'assets/images/search.png')),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            height: phoneHeight / 4.5,
                            child: Users.length == 0
                                ? Text("کاربر مورد نظر پیدا نشد لطفا تایپ کنید.")
                                : ListView.builder(
                                    itemCount: Users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (selectedUser ==
                                              Users[index].fullname) {
                                            selectedUser = "";
                                            selectedUserId = "";
                                          } else {
                                            selectedUser = Users[index].fullname;
                                            selectedUserId = Users[index].id;
                                          }

                                          setState(() {});
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                selectedUser.contains(
                                                        Users[index].fullname)
                                                    ? 'assets/images/check1.png'
                                                    : 'assets/images/check2.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Text(Users[index].fullname),
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              changeUserVisibility = true;
                              setState(() {});
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2, color: Colors.red))),
                                child: Text(
                                  "تایید",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )),
                          )),
                        ],
                      ),
                Container(
                  height: phoneHeight / 7.5,
                  padding: EdgeInsets.only(top: 20),
                  child: LoneSpeech(
                    speechText: VoiceController.text,
                    SpeechTextCallBack: (result) {
                      VoiceController.text = result;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                  visible: !calendarVisibility,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(children: [
                      Container(
                        height: phoneHeight / 15,
                        width: phoneWidth / 9,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.grey)),
                        child: Center(
                          child: Text(
                            timeDiffer == null ? '0' : timeDiffer.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          selectedDayName ??
                              WeekDay().weekDay(DateTime.now().weekday),
                          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            calendarVisibility = true;
                            setState(() {});
                          },
                          child: Container(
                            width: 50,
                            child: Image.asset(
                              "assets/images/pencill.png",
                              width: 25,
                              height: 25,
                            ),
                          ))
                    ]),
                  ),
                ),
                Visibility(
                  visible: calendarVisibility,
                  child: Column(
                    children: [
                      Container(
                        width: phoneWidth,
                        height: phoneHeight / 2.8,
                        child: persianDatePicker,
                      ),
                      Text(CalendarEditingController.text),
                      // TextField(
                      //   enableInteractiveSelection: false,
                      //   controller: CalendarEditingController,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      SendRowButton(
                        doneChanged: doneChanged,
                        voiceText: VoiceController.text,
                        onDoneCallback: () {
                          controllerVisibility = false;
                          projectVisibility = false;
                          calendarVisibility = false;
                          setState(() {});
                        },
                        onContinueCallBack: (res) {
                          calendarVisibility = false;
                          setState(() {});
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: phoneWidth / 13, vertical: 10),
                          child: Divider(
                            height: 3,
                            thickness: 2,
                          ))
                    ],
                  ),
                ),
                // FlatButton(
                //   color: Theme.of(context).accentColor,
                //   onPressed: () {},
                //   child: Text(
                //     "Open time picker",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: _time,
                              onChange: onTimeChanged,
                              minuteInterval: MinuteInterval.FIVE,
                              disableHour: false,
                              disableMinute: false,
                              minMinute: 7,
                              maxMinute: 56,
                              iosStylePicker: true,
                              is24HrFormat: true,
                              // Optional onChange to receive value as DateTime
                              onChangeDateTime: (DateTime dateTime) {
                                choosenTime = dateTime;
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'ساعت:',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[600]),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(2.5),
                              child: GestureDetector(
                                onTap: () async {
                                  widget.picker = await showTimePicker(
                                    initialEntryMode: TimePickerEntryMode.input,
                                    context: context,
                                    initialTime: TimeOfDay(hour: 12, minute: 00),
                                    builder: (BuildContext context, Widget child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(alwaysUse24HourFormat: true),
                                        child: child,
                                      );
                                    },
                                  );
                                  setState(() {});
                                },
                                child: choosenTime == null
                                    ? Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(DateFormat('kk:mm')
                                            .format(DateTime.now())),
                                      )
                                    : Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(choosenTime.minute.toString()),
                                            Text(':'),
                                            Text(
                                              choosenTime.hour.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 50,
                              child: Image.asset(
                                "assets/images/pencill.png",
                                width: 25,
                                height: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: !controllerVisibility,
                        child: Row(
                          children: [
                            Text(
                              'کنترلر:',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[600]),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(2.5),
                              child: GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(selectedController ?? ""),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  controllerVisibility = true;
                                  scrollViewController.animateTo(180.0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  setState(() {});
                                },
                                child: Container(
                                  width: 50,
                                  child: Image.asset(
                                    "assets/images/pencill.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controllerVisibility,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text("کنترلر:"),
                              ),
                              Consumer<ControllerCheckBox>(
                                builder: (context, controllerCheck, child) =>
                                    Container(
                                  margin: EdgeInsets.only(right: 30),
                                  height: phoneHeight / 3,
                                  child: ListView.builder(
                                      itemCount: Controllers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (selectedController ==
                                                Controllers[index].fullname) {
                                              selectedController = "";
                                              selectedControllerId = "";
                                              setState(() {});
                                            } else {
                                              selectedController =
                                                  Controllers[index].fullname;
                                              selectedControllerId =
                                                  Controllers[index].id;
                                              doneChanged = true;
                                              // controllerCheck.ChangeIcon();

                                              setState(() {});
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  selectedController ==
                                                          Controllers[index]
                                                              .fullname
                                                      ? 'assets/images/check1.png'
                                                      : 'assets/images/check2.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              Text(Controllers[index].fullname),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SendRowButton(
                                doneChanged: doneChanged,
                                voiceText: VoiceController.text,
                                onDoneCallback: () {
                                  controllerVisibility = false;
                                  projectVisibility = false;
                                  calendarVisibility = false;
                                  setState(() {});
                                },
                                onContinueCallBack: (res) {
                                  controllerVisibility = false;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: !projectVisibility,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                'پروژه:',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[600]),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.all(2.5),
                                child: Text(
                                  selectedprojects,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    projectVisibility = true;
                                    scrollViewController.animateTo(180.0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 50,
                                    child: Image.asset(
                                      "assets/images/pencill.png",
                                      width: 25,
                                      height: 25,
                                    ),
                                  ))
                              // IconButton(
                              //     icon: Icon(Icons.edit),
                              //     iconSize: 20,
                              //     color: Colors.grey[500],
                              //     onPressed: () {
                              //       projectVisibility = true;
                              //       setState(() {});
                              //     }),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: projectVisibility,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("پروژه:"),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        width: phoneWidth / 2,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          cursorColor: Colors.grey,
                                          onChanged: (value) {
                                            searchProject(value);
                                          },
                                          cursorRadius: Radius.circular(5),
                                          controller: projectSearchBarController,
                                        ),
                                      ),
                                      SearchSpeech(

                                        SpeechTextCallBack: (result) {
                                          projectSearchBarController.text =
                                              result;
                                          searchProject(result);
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, right: 11),
                                        child: Container(
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                                'assets/images/search.png')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Consumer<ProjectCheckBox>(
                              builder: (context, projectCheck, child) =>
                                  Container(
                                margin: EdgeInsets.only(right: phoneWidth / 12),
                                height: phoneHeight / 4,
                                child: projects.length == 0
                                    ? Text("پروژه مورد نظر پیدا نشد.")
                                    : ListView.builder(
                                        itemCount: projects.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (selectedprojects ==
                                                        projects[index].name) {
                                                      selectedprojects = "";
                                                    } else {
                                                      selectedprojects =
                                                          projects[index].name;
                                                      // projectCheck
                                                      //     .ChangeIcon();
                                                      doneChanged = true;
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Image.asset(
                                                    selectedprojects ==
                                                            projects[index].name
                                                        ? 'assets/images/check1.png'
                                                        : 'assets/images/check2.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                              ),
                                              Text(projects[index].name),
                                            ],
                                          );
                                        }),
                              ),
                            ),
                            SendRowButton(
                              doneChanged: doneChanged,
                              voiceText: VoiceController.text,
                              onDoneCallback: () {
                                controllerVisibility = false;
                                projectVisibility = false;
                                calendarVisibility = false;
                                setState(() {});
                              },
                              onContinueCallBack: (res) {
                                projectVisibility = false;
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Visibility(
                      visible: sendVisible,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.red[800],
                        ),
                        backgroundColor: Color(0xFF2C2C2C),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () async {
                    ClearSpeech().setClearSpeech(false);
                    SpeechController.speechController.clear();
                    sendingModel = TaskModel(
                      description: VoiceController.text,
                      creatorUserId: "e361abd4-a02c-4adc-bb5b-c74782da0a1f",
                      linkedContactId: selectedUserId,
                      startDate: selectedDate,
                      masterUserId: selectedControllerId,
                      projects: selectedprojects,
                    );
                    sendVisible = true;
                    doneChanged = false;
                    setState(() {});
                    bool result = await ApiServices().createTask(sendingModel);

                    if (result == true) {
                      startTimer();
                      clearDone();
                      sendVisible = false;
                      setState(() {});
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[800],
                              content: new SingleChildScrollView(
                                padding: const EdgeInsets.only(right: 0),
                                child: Center(
                                  child: Text(
                                    'اطلاعات شما با موفقیت ثبت شد',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if (result == false) {
                      sendVisible = false;
                      setState(() {});
                      startTimer();
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[800],
                              content: new SingleChildScrollView(
                                padding: const EdgeInsets.only(right: 0),
                                child: Center(
                                  child: Text(
                                    'ارسال با مشکل مواجه شد',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 70,
                    width: 80,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.orangeAccent,
                            width: doneChanged ? 6 : 3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.orangeAccent,
                        ),
                        Text("Done"),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearDone() {
    choosenTime = null;
    selectedUser = "";
    selectedUserId = null;
    selectedControllerId = null;
    selectedProjectname = null;
    selectedController = null;
    selectedprojects = "";
    selectedDayName = WeekDay().weekDay(DateTime.now().weekday);
    timeDiffer = todayProvider().getDay();
    changeUserVisibility = false;
    VoiceController.clear();
    VoiceController.text = "";
    SelectUser().setSelectedUser("");
    SelectController().setController("");
    SelectProject().setSelectedProject("");
    todayProvider().setDay(null);
  }

  Timer _timer;
  Timer _timer2;
  int _start = 2;
  int _start2 = 3;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          Navigator.pop(context);
          // Navigator.pop(context);
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
    _timer2 = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start2 == 0) {
          Navigator.pop(context);
          // Navigator.pop(context);
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start2--;
          });
        }
      },
    );
  }

  void searchUser(String _text) {
    if (_text.isEmpty) {
      Users = ApiServices().getUsersList();
    } else {
      Users = ApiServices().getUsersList().where((element) {
        return element.fullname.contains(_text);
      }).toList();
    }
    setState(() {});
  }

  void searchProject(String _text) {
    if (_text.isEmpty) {
      projects = ApiServices().getProjects();
    } else {
      projects = ApiServices().getProjects().where((element) {
        return element.name.contains(_text);
      }).toList();
    }
    setState(() {});
  }
}
