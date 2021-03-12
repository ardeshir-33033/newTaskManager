import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task_manager_new/ApiModels/Controller.dart';
import 'package:task_manager_new/ApiModels/Controller.dart';
import 'package:task_manager_new/ApiModels/Controller.dart';
import 'package:task_manager_new/ApiModels/ProjectsModel.dart';
import 'package:task_manager_new/ApiModels/TaskModel2.dart';
import 'package:task_manager_new/ApiModels/UserData.dart';
import 'package:task_manager_new/Buisness/ApiBuisness.dart';
import 'package:task_manager_new/provider/SelectedUserProvider.dart';
import 'package:task_manager_new/provider/StateProvider.dart';

import '../Screens/2ndPage.dart';

class Speech extends StatefulWidget {
  Speech({
    this.SpeechTextCallBack,
    this.SpeechButtonCallBack,
    // this.clearSpeech
  });

  Function(String SpeechText) SpeechTextCallBack;
  Function() SpeechButtonCallBack;

  // bool clearSpeech;

  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "fa_IR";

//  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future Waiting(int val) async {
    await Future.delayed(Duration(seconds: val));
  }

  ////choosing default language
  Future language() async {
    speech.listen(
      onResult: resultListener,
      localeId: ("fa"),
    );
  }

  ///////

  ////initializing every needed var to start listening
  @override
  void initState() {
    initSpeechState();
    Waiting(3).then((value) {
      !_hasSpeech || speech.isListening ? null : startListeningTap(10);
    });
    super.initState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _currentLocaleId = "fa_IR";
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  ///////

  //////starts listening when button pressed and the time for it depends on taping or long pressing the button
  void startListeningTap(int time) {
    lastWords = speechController.text;
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: time),
        localeId: _currentLocaleId,
        partialResults: false,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  ///////

  /////would be triggered if stop button pressed
  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
    widget.SpeechTextCallBack(speechController.text);
  }

  //////

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  List<UserData> allUsers = ApiServices().getUsersList();
  List<Project> projects = ApiServices().getProjects();
  List<Controller> controllers = ApiServices().getControllersList();

  Timer _timer;
  int _start = 2;

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
  }

  Future<Function> endHandler() async {
    widget.SpeechTextCallBack(speechController.text);
    speechController.clear();
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return MainPage2nd(
    //     taskText: speechController.text,
    //   );
    // }));
    bool result = await ApiServices().createTask(
      TaskModel(
        projects: SelectProject().getSelectedProject() ?? "",
        creatorUserId: "e361abd4-a02c-4adc-bb5b-c74782da0a1f",
        description: speechController.text,
        linkedContactId: SelectUser().getSelectedUser() ?? "",
        startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      ),
    );
    if (result == true) {
      speechController.clear();
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
  }

  // List<String> Users = ["سیف الهی", "اونق", "روحی", "اوژن", "اردشیر"];

  ////would take words from api and put it on a string and will save status for showing changes in button
  void resultListener(SpeechRecognitionResult result) {
    // if (widget.clearSpeech == true) {
    if (ClearSpeech().getClearSpeech() == true) {
      SpeechController.speechController.clear();
      speechController.clear();
    }
    SpeechController.speechController.text += "${result.recognizedWords} ";

    if (result.recognizedWords.contains("تمام")) {
      // setState(() {
      //   // speechController.text = "${result.recognizedWords} ";
      // });
      endHandler();
    }
    if (allUsers.any((element) {
      if (result.recognizedWords.contains("توسط ${element.fullname}")) {
        SelectUser().setSelectedUser(element.fullname);
        setState(() {
          // speechController.text += "${result.recognizedWords} ";
        });
        widget.SpeechTextCallBack(SpeechController.speechController.text);
        return true;
      } else {
        return false;
      }
    })) {}
    if (projects.any((element) {
      if (result.recognizedWords.contains(element.name)) {
        SelectProject().setSelectedProject(element.name);
        setState(() {
          // speechController.text += "${result.recognizedWords} ";
        });
        widget.SpeechTextCallBack(SpeechController.speechController.text);
        return true;
      } else {
        return false;
      }
    })) {}
    if (controllers.any((element) {
      if (result.recognizedWords.contains("کنترل کننده ${element.fullname}")) {
        SelectController().setController(element.fullname);
        widget.SpeechTextCallBack(SpeechController.speechController.text);
        return true;
      } else {
        return false;
      }
    })) if (result.recognizedWords.contains("فردا")) {
      SelectDate().setSelectedProject(DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: 1))));
      todayProvider().setDay(1);
      // speechController.text += "${result.recognizedWords} ";
      widget.SpeechTextCallBack(SpeechController.speechController.text);
    }

    final regex = RegExp('([۰-۹]+):([۰-۹]+)');
    final match = regex.firstMatch(result.recognizedWords);
    // ۱۲۳۴۵۶۷۸۹
    if (match != null) {
      String hour = match.group(1);
      String min = match.group(2);
      DateTime res;
      // res =DateTime( , )
      // Text("۱۲۳۴۵۶۷۸۹".toEnglishDigit());
      hour = hour.toEnglishDigit();
      min = min.toEnglishDigit();
      SelectTime().setDateTime(int.parse(hour), int.parse(min));
    }

    if (result.recognizedWords.contains("پس فردا")) {
      SelectDate().setSelectedProject(DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: 2))));
      todayProvider().setDay(2);
      // speechController.text += "${result.recognizedWords} ";
      widget.SpeechTextCallBack(SpeechController.speechController.text);
    } else {
      setState(() {
        // speechController.text += "${result.recognizedWords} ";
      });
      widget.SpeechTextCallBack(SpeechController.speechController.text);
    }
    // else if (ApiServices().getUsersList().where(
    //         (element) => result.recognizedWords.contains(element.userName)) !=
    //     null) {
    //   bool dd = ApiServices().getUsersList().has
    // }

    // else if(result.recognizedWords.contains(ApiServices().getUsersList().)){
    //   print("use");
    //  // SelectUser().setSelectedUser(user)
    // }
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
    });
  }

  ///////

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  ////to change sound
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  TextEditingController speechController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /////button for listening it would be changes by listening or not
            GestureDetector(
              onTap: () {
                widget.SpeechButtonCallBack();

                print('tap');
                !_hasSpeech || speech.isListening
                    ? null
                    : startListeningTap(10);
              },
              // onLongPress: () {
              //   print('long');
              //   !_hasSpeech || speech.isListening
              //       ? null
              //       : startListeningTap(30);
              // },
              child: Container(
                height: 80,
                width: 90,
                // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.orangeAccent, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic_none,
                      size: 40,
                      color:
                          speech.isListening ? Colors.red : Colors.orangeAccent,
                    ),
                    Text(
                      'Continue',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),

            ////container which listened words would be written in

            /////
          ],
        ),
      ),
    );
  }
}
