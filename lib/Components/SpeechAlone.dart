import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LoneSpeech extends StatefulWidget {
  LoneSpeech({this.SpeechTextCallBack, this.SpeechButtonCallBack});

  Function(String SpeechText) SpeechTextCallBack;
  Function() SpeechButtonCallBack;

  @override
  _LoneSpeechState createState() => _LoneSpeechState();
}

class _LoneSpeechState extends State<LoneSpeech> {
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
      speechController.text = "${result.recognizedWords} ";
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // widget.SpeechButtonCallBack();

                print('tap');
                !_hasSpeech || speech.isListening
                    ? null
                    : startListeningTap(10);
              },
              onLongPress: () {
                print('long');
                !_hasSpeech || speech.isListening
                    ? null
                    : startListeningTap(30);
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.orangeAccent, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic_none_outlined,
                      size: 40,
                      color:
                          speech.isListening ? Colors.orangeAccent : Colors.red,
                    ),
                    Text(
                      'Voice',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            //////

            ////container which listened words would be written in

            /////
          ],
        ),
      ),
    );
  }
}
