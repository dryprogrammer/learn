// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'src/basics/01_animated_container.dart';
import 'src/basics/02_page_route_builder.dart';
import 'src/basics/03_animation_controller.dart';
import 'src/basics/04_tweens.dart';
import 'src/basics/05_animated_builder.dart';
import 'src/basics/06_custom_tween.dart';
import 'src/basics/07_tween_sequence.dart';
import 'src/basics/08_fade_transition.dart';
import 'src/misc/animated_list.dart';
import 'src/misc/animated_positioned.dart';
import 'src/misc/animated_switcher.dart';
import 'src/misc/card_swipe.dart';
import 'src/misc/carousel.dart';
import 'src/misc/curved_animation.dart';
import 'src/misc/expand_card.dart';
import 'src/misc/focus_image.dart';
import 'src/misc/hero_animation.dart';
import 'src/misc/physics_card_drag.dart';
import 'src/misc/repeating_animation.dart';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          controller: _controller,
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
      ),
    );
  }
}
