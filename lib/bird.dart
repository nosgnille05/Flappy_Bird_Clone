import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdYaxis;
  final double birdHeight;
  final double birdWidth;

  MyBird({this.birdYaxis, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            Alignment(0, (2 * birdYaxis + birdHeight) / (2 - birdHeight)),
        child: Image.asset(
          'lib/images/flappy_bird.png',
          width: 50,
          height: 50,
        ));
  }
}
