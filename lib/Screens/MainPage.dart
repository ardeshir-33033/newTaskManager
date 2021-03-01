import 'package:flutter/material.dart';
import 'package:task_manager_new/ApiModels/TaskModel.dart';
import 'package:task_manager_new/Components/Speech.dart';
import 'package:task_manager_new/Services/TaskServiceEndPoint.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String SpeechText;
  String resultMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: Speech(
                  SpeechTextCallBack: (result) {
                    SpeechText = result;
                  },
                  SpeechButtonCallBack: () {
                    resultMessage = null;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(resultMessage ?? ""),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.black,
                onPressed: () {
                  TaskServiceEndPoint()
                      .uploadTask(
                    TaskModel(
                      Description: SpeechText,
                      Creator_user_id: TaskServiceEndPoint().getToken(),
                    ),
                  )
                      .then((value) {
                    if (TaskServiceEndPoint().getTaskId() != null) {
                      resultMessage = "تسک با موفقیت ارسال شد";
                    } else {
                      resultMessage = "ارسال با مشکل مواجه شد";
                    }
                    setState(() {});
                  });
                },
                child: Text(
                  "ثبت",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
