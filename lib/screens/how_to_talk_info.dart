import 'package:flutter/material.dart';

class HowToTalkInfo extends StatefulWidget {
  const HowToTalkInfo({Key? key}) : super(key: key);

  @override
  _HowToTalkInfoState createState() => _HowToTalkInfoState();
}

class _HowToTalkInfoState extends State<HowToTalkInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to talk'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Image.asset(
            "lib/assets/info.jpg",
          ),
        ),
      ),
    );
  }
}
