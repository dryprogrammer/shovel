import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text_input = "";
  var origin_text = "";
  late Timer focusTimer;
  var isFocusing = false;
  var text_array = [];
  var focusTextCount = 0;
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('toy'),
          actions: [isFocusing ? StopButton() : PlayButton()],
        ),
        body: isFocusing
            ? Container(
                child: Wrap(
                children: text_array
                    .sublist(0, focusTextCount)
                    .map((e) => Text("$e "))
                    .toList(),
              ))
            : TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: textController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (v) {
                  setState(() {
                    origin_text = v;
                  });
                },
              ));
  }

  IconButton PlayButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            isFocusing = !isFocusing;
            textController.text = "";
            focusTextCount = 0;

            text_array = origin_text.split(" ");
            focusTimer = Timer.periodic(Duration(seconds: 1), (timer) {
              focusTextCount++;
              if (focusTextCount > text_array.length) {
                focusTimer.cancel();
              }
            });
          });
        },
        icon: Icon(Icons.play_arrow));
  }

  IconButton StopButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            isFocusing = !isFocusing;
            textController.text = origin_text;
            focusTimer.cancel();
          });
        },
        icon: Icon(Icons.stop));
  }
}
