import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:persian_datepicker/jalaali_js.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:task_manager_new/Components/SpeechAlone.dart';
import 'package:task_manager_new/provider/StateProvider.dart';

class MainPage2nd extends StatefulWidget {
  MainPage2nd({this.taskText});

  TimeOfDay picker;
  String taskText = "";

  @override
  _MainPage2ndState createState() => _MainPage2ndState();
}

class _MainPage2ndState extends State<MainPage2nd> {
  TextEditingController SearchBarController = TextEditingController();
  List<String> Users = ["سیف الهی", "اونق", "روحی", "اوژن"];
  List<String> selectedUsers = List<String>();
  List<String> Controllers = ["مجرب", "اونق", "هاتف", "اسحاق زاده", "مقدم"];
  String selectedController;
  List<String> projects = [
    "تسک منجیر",
    "کپ اپ",
    "تایم منیجمنت",
    "اینستاگرام",
    "رجیسترینگ"
  ];
  String selectedprojects;

  TextEditingController CalendarEditingController = TextEditingController();

  PersianDatePickerWidget persianDatePicker;
  String selectedUser;
  TextEditingController VoiceController = TextEditingController();

  @override
  void initState() {
    VoiceController.text = widget.taskText;
    persianDatePicker = PersianDatePicker(
            showGregorianDays: false,
            controller: CalendarEditingController,
            farsiDigits: true,
            weekCaptionsBackgroundColor: Colors.grey,
            headerTodayBackgroundColor: Colors.transparent)
        .init();
    selectedUser = Users[0];

    DateTime now = DateTime.now();

    super.initState();
  }

  bool userVisibility = true;
  bool changeUserVisibility = false;
  bool controllerVisibility = false;
  bool projectVisibility = false;
  bool calendarVisibility = false;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.grey[500],
                                  iconSize: 20,
                                  onPressed: () {
                                    changeUserVisibility = false;
                                    setState(() {});
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: phoneHeight / 5,
                              width: phoneWidth - 30,
                              child: TextField(
                                controller: VoiceController,
                                maxLines: null,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "متن..."),
                              ),
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
                            border:
                                Border.all(color: Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: phoneWidth / 1.7,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: Colors.grey,
                                  onChanged: (value) {
                                    // Search(value);
                                  },
                                  cursorRadius: Radius.circular(5),
                                  controller: SearchBarController,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: phoneWidth / 12),
                                child: Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          height: phoneHeight / 4.5,
                          child: ListView.builder(
                              itemCount: Users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedUsers.contains(Users[index])
                                        ? selectedUsers.remove(Users[index])
                                        : selectedUsers.clear();
                                    selectedUsers.add(Users[index]);
                                    selectedUser = selectedUsers.first;
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          selectedUsers.contains(Users[index])
                                              ? 'assets/images/check1.png'
                                              : 'assets/images/check2.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      Text(Users[index]),
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
                height: phoneHeight / 9,
                padding: EdgeInsets.only(top: 20),
                child: LoneSpeech(
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
                  child: Row(
                    children: [
                      Container(
                        height: phoneHeight / 15,
                        width: phoneWidth / 9,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.grey)),
                        child: Center(
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          WeekDay().weekDay(DateTime.now().weekday),
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[700]),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          color: Colors.grey[500],
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                          onPressed: () {
                            calendarVisibility = true;
                            setState(() {});
                            // print(DateTime.now().weekday);
                          })
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: calendarVisibility,
                child: Column(
                  children: [
                    Container(
                      width: phoneWidth,
                      height: 300,
                      child:
                          persianDatePicker, // just pass `persianDatePicker` variable as child with no ( )
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        calendarVisibility = false;
                        setState(() {});
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: Colors.red))),
                          child: Text(
                            "تایید",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'ساعت:',
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[600]),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(2.5),
                          child: GestureDetector(
                            onTap: () async {
                              // widget.picker = await showTimePicker(
                              //   initialEntryMode: TimePickerEntryMode.input,
                              //   context: context,
                              //   initialTime: TimeOfDay(hour: 12, minute: 00),
                              //   builder: (BuildContext context, Widget child) {
                              //     return MediaQuery(
                              //       data: MediaQuery.of(context)
                              //           .copyWith(alwaysUse24HourFormat: true),
                              //       child: child,
                              //     );
                              //   },
                              // );
                              setState(() {});
                            },
                            child: widget.picker == null
                                ? Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(DateFormat('kk:mm')
                                        .format(DateTime.now())),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text(widget.picker.minute.toString()),
                                        Text(':'),
                                        Text(
                                          widget.picker.hour.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.grey[500],
                            iconSize: 20,
                            onPressed: () {
                              DatePicker.showTime12hPicker(context,
                                  locale: LocaleType.fa);
                            }),
                      ],
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
                                child: Text(selectedController ?? "اتوماتیک"),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 20,
                              color: Colors.grey[500],
                              onPressed: () {
                                controllerVisibility = true;
                                setState(() {});
                              }),
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
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              height: phoneHeight / 3,
                              child: ListView.builder(
                                  itemCount: Controllers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedController = Controllers[index];
                                        setState(() {});
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              selectedController ==
                                                      Controllers[index]
                                                  ? 'assets/images/check1.png'
                                                  : 'assets/images/check2.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          Text(Controllers[index]),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                controllerVisibility = false;
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )),
                            )),
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
                                selectedprojects ?? "اینستاگرام",
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(Icons.edit),
                                iconSize: 20,
                                color: Colors.grey[500],
                                onPressed: () {
                                  projectVisibility = true;
                                  setState(() {});
                                }),
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
                                  border: Border.all(
                                      color: Colors.redAccent, width: 1),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: phoneWidth / 1.75,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        cursorColor: Colors.grey,
                                        onChanged: (value) {
                                          // Search(value);
                                        },
                                        cursorRadius: Radius.circular(5),
                                        controller: SearchBarController,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.search),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: phoneWidth / 12),
                            height: phoneHeight / 4,
                            child: ListView.builder(
                                itemCount: projects.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            selectedprojects = projects[index];
                                            setState(() {});
                                          },
                                          child: Image.asset(
                                            selectedprojects == projects[index]
                                                ? 'assets/images/check1.png'
                                                : 'assets/images/check2.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                      Text(projects[index]),
                                    ],
                                  );
                                }),
                          ),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              projectVisibility = false;
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
            ],
          ),
        ),
      ),
    );
  }
}
