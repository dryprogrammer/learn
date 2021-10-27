// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end = ''})
      : super(begin: begin, end: end);

  @override
  String lerp(double t) {
    var cutoff = (end!.length * t).round();
    return end!.substring(0, cutoff);
  }
}

class CustomTweenDemo extends StatefulWidget {
  const CustomTweenDemo({Key? key}) : super(key: key);
  static const String routeName = '/basics/custom_tweens';

  @override
  _CustomTweenDemoState createState() => _CustomTweenDemoState();
}

class _CustomTweenDemoState extends State<CustomTweenDemo>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(seconds: 25);
  static const String message = loremIpsum;
  late final AnimationController controller;
  late final Animation<String> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration);
    animation = TypewriterTween(end: message).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대본훑어보기'),
        actions: [
          MaterialButton(
            child: Text(
              controller.status == AnimationStatus.completed
                  ? '반대로 보기'
                  : '대본 보기',
            ),
            textColor: Colors.white,
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse().whenComplete(() {
                  setState(() {});
                });
              } else {
                controller.forward().whenComplete(() {
                  setState(() {});
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Text(
                            animation.value,
                            style: const TextStyle(
                                fontSize: 19, fontFamily: 'SpecialElite'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String loremIpsum = '''
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
안녕하세요 저는 엄유주 입니다. 반갑습니다. 플러터는 재미있네요.,
''';
