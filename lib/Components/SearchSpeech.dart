import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchSpeech extends StatefulWidget {
  SearchSpeech({this.SpeechTextCallBack, this.SpeechButtonCallBack});

  Function(String SpeechText) SpeechTextCallBack;
  Function() SpeechButtonCallBack;

  @override
  _SearchSpeechState createState() => _SearchSpeechState();
}

class _SearchSpeechState extends State<SearchSpeech> {
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
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: time),
        localeId: _currentLocaleId,
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

  ////would take words from api and put it on a string and will save status for showing changes in button
  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      speechController.text = "${result.recognizedWords}";
    });
    widget.SpeechTextCallBack(speechController.text);
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
    return GestureDetector(
      onTap: () {
        !_hasSpeech || speech.isListening ? null : startListeningTap(10);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 16,
        height: 30,
        // margin: EdgeInsets.only(left: 10 , bottom: 10),
        child: Icon(
          Icons.mic_none,
          color: speech.isListening ? Colors.orangeAccent : Colors.black45,
          size: 28,
        ),
      ),
    );
    // Container(
    // padding: EdgeInsets.only(left: 20 , bottom: 20),
    //
    // // margin: EdgeInsets.only(bottom: 17),
    // height: 30,
    // width: 30,
    // color: Colors.red,
    // child: IconButton(
    //   icon: Icon(Icons.mic_none),
    //   color: Colors.grey[600],
    //   iconSize: MediaQuery.of(context).size.width / 14,
    //   onPressed: () {
    //     !_hasSpeech || speech.isListening ? null : startListeningTap(10);
    //   },
    // ),
    // child: IconButton(
    //
    //   Icons.mic_none,
    //   size: 30,
    //   color:
    //   speech.isListening ? Colors.orangeAccent : Colors.grey, icon: null, onPressed: () {  !_hasSpeech || speech.isListening
    //     ? null
    //     : startListeningTap(10); },
    // ),
    // );
  }
}
