import 'package:flutter/material.dart';
import 'package:task_manager_new/Components/Speech.dart';

import '2ndPage.dart';

class VoiceStartPage extends StatefulWidget {
  @override
  _VoiceStartPageState createState() => _VoiceStartPageState();
}

class _VoiceStartPageState extends State<VoiceStartPage> {

  String SpeechText;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: phoneHeight / 2,
                margin: EdgeInsets.only(top: phoneHeight / 9),
                width: phoneWidth,
                child: Speech(
                  SpeechTextCallBack: (result) {
                    SpeechText = result;
                  },
                  SpeechButtonCallBack: () {
                    //  resultMessage = null;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: phoneHeight / 3.5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MainPage2nd(
                      taskText: SpeechText,
                    );
                  }));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2, color: Colors.red))),
                    child: Text(
                      "ادامه",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
