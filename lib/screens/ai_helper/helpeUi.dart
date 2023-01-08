import 'package:flutter/material.dart';
import 'package:sentiment_dart/sentiment_dart.dart';
import 'package:social_app/widgets/coolButtion.dart';
import 'package:social_app/widgets/coolText.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'helperAI.dart';

class HelperUI extends StatefulWidget {
  const HelperUI({Key? key}) : super(key: key);

  @override
  _helper createState() => _helper();
}

class _helper extends State<HelperUI> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  late Map results;
  late bool ERROR;
  late String reply;
  late String whatError;
  double finalScore = 0;
  bool convoPart = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void resultShow() {
    setState(() {
      switch (convoPart) {
        case false:
          try {
            finalScore = Ai().opening(0, _lastWords) + results["score"];
            convoPart = true;
            _stopListening;
            reply = Ai().respond();
          } catch (error) {
            finalScore = 0;
          }
          break;
        case true:
          try {
            finalScore += Ai().body(1, _lastWords) + results["score"];
            convoPart = false;
            _stopListening;
            reply = "";
          } catch (error) {
            finalScore = 0;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      results = {
        "score": Sentiment
            .analysis(_lastWords)
            .score
            .toDouble(),
        "good": Sentiment
            .analysis(_lastWords)
            .words
            .good
            .toString(),
        "bad": Sentiment
            .analysis(_lastWords)
            .words
            .bad
            .toString(),
        "comparative": Sentiment
            .analysis(_lastWords)
            .comparative
            .toString(),
      };
      ERROR = false;
    } catch (error) {
      results = {
        "score": 0.toString(),
        "good": "empty",
        "bad": "empty",
        "comparative": 0.toString(),
        "error": error.toString(),
      };
      ERROR = true;
      whatError = error.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: const coolText(
          text: 'Speech Helper',
          fontSize: 20,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _speechToText.isListening
                        ? _lastWords
                        : _speechEnabled
                        ? _lastWords
                        : 'Please Go To Setting And Change Permissions',
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: 350,
              child: coolText(
                  text: convoPart
                      ? "They respond '$reply',"
                      : "Start The Conversation",
                  fontSize: 15),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Text(
                'score: ${finalScore.toString()}',
              ),
            ),
            ExpandedButton(
                onPressed: () {
                  resultShow();
                },
                text: convoPart ? "Retry/See Score" : "See Score",
                flex: 1,
                fontSize: 20,
                width: 200),
            const Spacer(
              flex: 1,
            ),
            ExpandedButton(
                onPressed: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                text: _speechToText.isNotListening ? "Start" : "Stop",
                flex: 1,
                fontSize: 20,
                width: 200),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
