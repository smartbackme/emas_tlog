import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:emas_tlog/emas_tlog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    EmasTlog.init("", "", "",
      "", "",
        "",
        );
  }

  @override
  Widget build(BuildContext context) {

    EmasTlog.log(ApmLogType.I, "tag2_1231231I",module: "hehe2_flutterI",tag: "tag_hehe2");
    EmasTlog.log(ApmLogType.V, "tag2_1231231",module: "hehe2_flutter",tag: "tag_hehe2");
    EmasTlog.log(ApmLogType.W, "tag2_1231231W",module: "hehe2_flutterW",tag: "tag_hehe2");
    EmasTlog.log(ApmLogType.E, "tag2_1231231E",module: "hehe2_flutterE",tag: "tag_hehe2");
    EmasTlog.log(ApmLogType.D, "tag2_1231231D",module: "hehe2_flutterD",tag: "tag_hehe2");
    EmasTlog.log(ApmLogType.I, "tag2_1231231I",module: "hehe2_flutterI",tag: "tag_hehe2");
    // EmasTlog.comment(); // 上报
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
