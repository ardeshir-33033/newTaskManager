import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/ApiModels/TaskModel2.dart';
import 'package:task_manager_new/Buisness/ApiBuisness.dart';
import 'package:task_manager_new/provider/SelectedUserProvider.dart';

class SendRowButton extends StatefulWidget {
  SendRowButton(
      {this.voiceText, this.onContinueCallBack, @required this.doneChanged , this.onDoneCallback});

  String voiceText = "";
  bool doneChanged;
  Function(bool calVis) onContinueCallBack;
  Function() onDoneCallback;

  @override
  _SendRowButtonState createState() => _SendRowButtonState();
}

class _SendRowButtonState extends State<SendRowButton> {
  Timer _timer;
  int _start = 1;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            BuildContext dialogContext;
            bool result = await ApiServices().createTask(
              TaskModel(
                projects: SelectProject().getSelectedProject() ?? "",
                creatorUserId: "e361abd4-a02c-4adc-bb5b-c74782da0a1f",
                description: widget.voiceText,
                linkedContactId: SelectUser().getSelectedUser() ?? "",
                startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
              ),
            );
            widget.doneChanged = false;

            if (result == true) {
              setState(() {});
              widget.onDoneCallback();
              startTimer();
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    dialogContext = context;

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
                    dialogContext = context;
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
            Navigator.pop(dialogContext);
          },
          child: Container(
            height: 80,
            width: 80,
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.orangeAccent,
                    width: widget.doneChanged ? 6 : 3)),
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
            widget.onContinueCallBack(false);
            // calendarVisibility = false;
            // setState(() {});
          },
          child: Container(
            height: 80,
            width: 80,
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.orangeAccent, width: 3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Continue"),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
