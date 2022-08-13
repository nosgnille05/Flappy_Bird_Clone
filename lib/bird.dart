import 'package:flutter/material.dart';

/*class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset('lib/images/flappy_bird.png'),
    );
  }
}*/

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
          width: MediaQuery.of(context).size.width * birdWidth / 2,
          height: MediaQuery.of(context).size.width * 3 / 4 * birdWidth / 2,
          fit: BoxFit.fill,
        ));
  }
}
