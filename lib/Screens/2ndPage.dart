import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_datepicker/jalaali_js.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:task_manager_new/Components/SpeechAlone.dart';

class MainPage2nd extends StatefulWidget {
  TimeOfDay picker;

  @override
  _MainPage2ndState createState() => _MainPage2ndState();
}

class _MainPage2ndState extends State<MainPage2nd> {
  TextEditingController SearchBarController = TextEditingController();
  List<String> Users = ["سیف الهی", "اونق", "روحی", "اوژن"];
  List<String> selectedUsers= List<String>();
  List<String> Controllers = ["مجرب", "اونق", "هاتف", "اسحاق زاده", "مقدم"];
  List<String> selectedController = List<String>();
  List<String> projects = [
    "تسک منجیر",
    "کپ اپ",
    "تایم منیجمنت",
    "اینستاگرام",
    "رجیسترینگ"
  ];

  TextEditingController CalendarEditingController = TextEditingController();

  PersianDatePickerWidget persianDatePicker;
  String selectedUser;

  @override
  void initState() {
    persianDatePicker = PersianDatePicker(
      showGregorianDays: false,
      controller: CalendarEditingController,
      farsiDigits: true,
      weekCaptionsBackgroundColor: Colors.orangeAccent,
    ).init();
    selectedUser = Users[0];

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
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xffFDCF09),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('assets/images/avatarTest.png'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(selectedUser),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                changeUserVisibility = false;
                                setState(() {});
                              }),
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
                            borderRadius: BorderRadius.circular(15.0),
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
                          height: 150,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                              itemCount: Users.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 100,
                                      childAspectRatio: 5 / 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    changeUserVisibility = true;
                                    selectedUser = Users[index];
                                    setState(() {});
                                  },
                                  child: Card(
                                    child: Center(
                                      child: Text(Users[index]),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
              Container(
                height: 100,
                padding: EdgeInsets.only(top: 20),
                child: LoneSpeech(
                  SpeechTextCallBack: (result) {
                    SearchBarController.text = result;
                  },
                ),
              ),
              Visibility(
                visible: !calendarVisibility,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
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
                          'دوشنبه',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.edit),
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
                      width: 300,
                      height: 300,
                      child:
                          persianDatePicker, // just pass `persianDatePicker` variable as child with no ( )
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
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'ساعت:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(2.5),
                          child: GestureDetector(
                            onTap: () async {
                              widget.picker = await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.input,
                                context: context,
                                initialTime: TimeOfDay(hour: 00, minute: 00),
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
                        IconButton(icon: Icon(Icons.edit), onPressed: null),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Visibility(
                      visible: !controllerVisibility,
                      child: Row(
                        children: [
                          Text(
                            'کنترلر:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(2.5),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text("اتوماتیک"),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                controllerVisibility = true;
                                setState(() {});
                              }),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controllerVisibility,
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
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      selectedController
                                              .contains(Controllers[index])
                                          ? selectedController
                                              .remove(Controllers[index])
                                          : selectedController.clear();
                                      selectedController
                                          .add(Controllers[index]);
                                      setState(() {

                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            selectedController.contains(
                                                    Controllers[index])
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
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )),
                          )),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Visibility(
                      visible: !projectVisibility,
                      child: Row(
                        children: [
                          Text(
                            'پروژه:',
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(2.5),
                            child: Text(
                              "اینستاگرام",
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                projectVisibility = true;
                                setState(() {});
                              }),
                        ],
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
                            margin: EdgeInsets.only(right: 30),
                            height: phoneHeight / 3,
                            child: ListView.builder(
                                itemCount: projects.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/check2.png',
                                          width: 30,
                                          height: 30,
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
                      color: Colors.grey,
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
