// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CustomTweenDemo extends StatefulWidget {
  const CustomTweenDemo({Key? key}) : super(key: key);
  static const String routeName = '/basics/custom_tweens';

  @override
  _CustomTweenDemoState createState() => _CustomTweenDemoState();
}

class _CustomTweenDemoState extends State<CustomTweenDemo>
    with TickerProviderStateMixin {
  double _currentSliderValue = 60;
  late AnimationController controller;
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _teController = TextEditingController();
  int index = 0;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // 0 1
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: _currentSliderValue.round(),
      ),
    );

    // controller = AnimationController(vsync: this, duration: _duration);
    // animation = TypewriterTween(end: '').animate(controller);
    // _scrollController.addListener(() {
    //   print(_scrollController.offset);
    // });

    controller.addListener(() {
      if (isPlaying && index > 1) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          isPlaying &&
          index < _teController.text.length) {
        index++;
        setState(() {});

        controller.reset();
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _textFeild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Input Text',
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _teController,
        onSubmitted: (String value) async {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('대본암기도우미'),
                content: Text('"$value"를 암기하도록 도와주겠습니다.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('암기하러가기'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _player() {
    return Container(
      color: const Color(0xFFFFFFFF),
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                // ABCD
                // (stIndex,endIndex);
                // 0 0 A
                // 0 1 AB
                _teController.text.substring(0, index),
                style:
                    const TextStyle(fontSize: 20, fontFamily: 'SpecialElite'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.duration = Duration(
      milliseconds: 315 - _currentSliderValue.round(),
    ); //
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Clipboard Reader'),
        backgroundColor: const Color(0xFF414435),
        actions: [
          MaterialButton(
            child: Text(
              //3hang
              isPlaying ? 'Stop!!' : '대본 보기',
            ),
            textColor: Colors.white,
            onPressed: () {
              index = 0;
              if (isPlaying) {
                controller.stop();
                controller.reset();
                // 0.35 0.77
                // 0-1
              } else {
                controller.forward();
              }
              setState(() {
                isPlaying = !isPlaying;
              });
              // Q.A - setState안에다가
              //isPlaying 넣는게 아닌지??
            },
          ),
        ],
      ),
      body: SafeArea(
        // 3 항 연산자 ( 조건 ? 참일때 : 거짓일때  )
        child: Column(
          children: [
            Expanded(
              child: isPlaying ? _player() : _textFeild(),
            ),
            Slider(
              value: _currentSliderValue,
              min: 15,
              max: 300,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
