import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/ApiModels/TaskModel2.dart';
import 'package:task_manager_new/Buisness/ApiBuisness.dart';
import 'package:task_manager_new/Components/Speech.dart';
import 'package:task_manager_new/provider/SelectedUserProvider.dart';

import '../Services/EndPointService.dart';
import '2ndPage.dart';

class VoiceStartPage extends StatefulWidget {
  @override
  _VoiceStartPageState createState() => _VoiceStartPageState();
}

class _VoiceStartPageState extends State<VoiceStartPage> {
  String SpeechText;
  bool sendVisible = false;
   bool clearSpeech = false;

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
  TextEditingController speechController = TextEditingController();

  @override
  void initState() {
    // var hek = DateFormat('HH:mm:ss')
    //     .format(DateTime.now());
    // var jjd = DateFormat("yyyy-MM-dd").format(DateTime.now());
    // print(jjd);
    // print(hek);
    // DateTime hek = DateTime.now();
    // ApiServices().setTask();
    ApiServices().fetchProjects();
    ApiServices().fetchController();
    ApiServices().fetchAllUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: phoneHeight / 10,),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  side: BorderSide(width: 1, color: Colors.grey[400]),
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20),
                        child: TextField(

                          controller: speechController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "متن...",
                          ),
                          minLines: 5,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (result) {
                            SpeechText = result;
                            // widget.SpeechTextCallBack(speechController.text);
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: phoneHeight / 10,
                    margin: EdgeInsets.only(top: phoneHeight / 20),
                    width: 100,
                    child: Center(
                      child: Speech(
                        clearSpeech: clearSpeech,
                        SpeechTextCallBack: (result) {
                          SpeechText = result;
                          speechController.text = result;
                        },
                        SpeechButtonCallBack: () {
                          //  resultMessage = null;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool result = await ApiServices().createTask(
                        TaskModel(
                          projects: SelectProject().getSelectedProject() ?? "",
                          creatorUserId: "e361abd4-a02c-4adc-bb5b-c74782da0a1f",
                          description: SpeechText,
                          linkedContactId: SelectUser().getSelectedUser() ?? "",
                          startDate:
                              DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        ),
                      );

                      if (result == true) {
                        clearSpeech = true;

                        sendVisible = false;
                        speechController.clear();
                        setState(() {

                        });

                        // setState(() {
                        //   clearSpeech = true;
                        // });
                         startTimer();
                        // setState(() {
                        //   clearSpeech = false;
                        // });
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
                        clearSpeech = true;
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
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(7.0),
                          border:
                              Border.all(color: Colors.orangeAccent, width: 3)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Done"),
                          Icon(
                            Icons.done,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      clearSpeech = true;
                      speechController.clear();
                      setState(() {});

                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MainPage2nd(
                          taskText: SpeechText,
                        );
                      }));
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(7.0),
                          border:
                              Border.all(color: Colors.orangeAccent, width: 3)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Edit"),
                          Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
