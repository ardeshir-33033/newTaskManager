import 'package:flutter/material.dart';
import 'package:task_manager_new/Components/Speech.dart';

class VoiceStartPage extends StatefulWidget {
  @override
  _VoiceStartPageState createState() => _VoiceStartPageState();
}

class _VoiceStartPageState extends State<VoiceStartPage> {
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight =  MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: phoneWidth,
          child: Speech(
            SpeechTextCallBack: (result) {
              // SpeechText = result;
            },
            SpeechButtonCallBack: () {
              //  resultMessage = null;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
